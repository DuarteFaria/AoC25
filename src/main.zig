const std = @import("std");
const day01 = @import("01/solver.zig");
const day02 = @import("02/solver.zig");

pub fn main() !void {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();

    var args = try std.process.argsWithAllocator(arena);
    defer args.deinit();

    const day = if (args.next()) |_| blk: {
        if (args.next()) |day_str| {
            break :blk try std.fmt.parseInt(u8, day_str, 10);
        }
        break :blk 1;
    } else 1;

    switch (day) {
        1 => {
            std.debug.print("Day 1\n", .{});
            try day01.part1(arena);
            try day01.part2(arena);
        },
        2 => {
            std.debug.print("Day 2\n", .{});
            try day02.part1(arena);
            try day02.part2(arena);
        },
        else => std.debug.print("Day {} not implemented\n", .{day}),
    }
}
