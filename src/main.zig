const std = @import("std");
const day01 = @import("01/solver.zig");
const day02 = @import("02/solver.zig");

const DaySolver = struct {
    part1: *const fn (std.mem.Allocator) anyerror!void,
    part2: *const fn (std.mem.Allocator) anyerror!void,
};

const solvers = [_]?DaySolver{
    null,
    DaySolver{ .part1 = day01.part1, .part2 = day01.part2 },
    DaySolver{ .part1 = day02.part1, .part2 = day02.part2 },
};

fn runDay(arena: std.mem.Allocator, day: u8) !void {
    if (day >= solvers.len or solvers[day] == null) {
        std.debug.print("Day {} not implemented\n", .{day});
        return;
    }

    const solver = solvers[day].?;
    std.debug.print("Day {}\n", .{day});
    try solver.part1(arena);
    try solver.part2(arena);
}

pub fn main() !void {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    var args = try std.process.argsWithAllocator(arena);
    defer args.deinit();

    _ = args.skip();
    const day = if (args.next()) |day_str|
        try std.fmt.parseInt(u8, day_str, 10)
    else
        1;

    try runDay(arena, day);
}
