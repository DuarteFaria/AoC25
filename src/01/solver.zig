const std = @import("std");

pub fn parseFile(arena: std.mem.Allocator, filename: []const u8) ![]const []const u8 {
    const file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    var lines = std.ArrayList([]const u8).init(arena);
    while (try file.reader().readUntilDelimiterOrEofAlloc(arena, '\n', std.math.maxInt(usize))) |line| {
        try lines.append(line);
    }
    return lines.toOwnedSlice();
}

pub fn part1(arena: std.mem.Allocator) !void {
    const lines = try parseFile(arena, "./src/01/input.txt");
    var curr: i32 = 50;
    var sum: i32 = 0;
    for (lines) |line| {
        const dir: i32 = if (line[0] == 'R') 1 else -1;
        const num: i32 = try std.fmt.parseInt(i32, line[1..], 10);
        curr = @mod(curr + (dir * num), 100);
        sum += if (curr == 0) 1 else 0;
    }
    std.debug.print("Part 1: {}\n", .{sum});
}

pub fn part2(arena: std.mem.Allocator) !void {
    const lines = try parseFile(arena, "./src/01/input.txt");
    var pos: i32 = 50;
    var sum: i32 = 0;
    for (lines) |line| {
        const dir: i32 = if (line[0] == 'R') 1 else -1;
        const num: i32 = try std.fmt.parseInt(i32, line[1..], 10) * dir;
        const next: i32 = pos + num;
        if (num >= 0) {
            sum += @divFloor(next, 100) - @divFloor(pos, 100);
        } else {
            sum += @divFloor(pos - 1, 100) - @divFloor(next - 1, 100);
        }
        pos = next;
    }
    std.debug.print("Part 2: {}\n", .{sum});
}
