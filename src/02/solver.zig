const std = @import("std");

pub fn parseFile(arena: std.mem.Allocator, filename: []const u8) ![]const []const u8 {
    const file = try std.fs.cwd().openFile(filename, .{});
    defer file.close();

    var lines = std.ArrayList([]const u8).init(arena);
    while (try file.reader().readUntilDelimiterOrEofAlloc(arena, ',', std.math.maxInt(usize))) |line| {
        try lines.append(line);
    }
    return lines.toOwnedSlice();
}

pub fn checkValidId(arena: std.mem.Allocator, id: usize) bool {
    const strId = std.fmt.allocPrint(arena, "{d}", .{id}) catch unreachable;
    if (strId.len == 0) return false;
    if (strId.len % 2 != 0) return false;

    const middle = strId.len / 2;

    const left = strId[0..middle];
    const right = strId[middle..strId.len];

    if (std.mem.eql(u8, left, right))
        return true;
    return false;
}

pub fn part1(arena: std.mem.Allocator) !void {
    const pairs = try parseFile(arena, "./src/02/input.txt");
    var sum: usize = 0;
    for (pairs) |pair| {
        var it = std.mem.split(u8, pair, "-");
        const left_str = std.mem.trim(u8, it.next().?, " \r\n\t");
        const right_str = std.mem.trim(u8, it.next().?, " \r\n\t");
        const left = try std.fmt.parseInt(usize, left_str, 10);
        const right = try std.fmt.parseInt(usize, right_str, 10);

        for (left..right + 1) |i| {
            if (checkValidId(arena, i)) {
                sum += i;
            }
        }
    }
    std.debug.print("Sum of valid IDs: {d}\n", .{sum});
}

pub fn part2(arena: std.mem.Allocator) !void {
    _ = arena;
    std.debug.print("Part 2:\n", .{});
}
