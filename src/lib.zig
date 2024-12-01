const std = @import("std");

pub fn read_day_file(allocator: std.mem.Allocator, dir_path: []const u8, day: u8) ![]const u8 {
    var buf: [100]u8 = undefined;
    const filepath = try std.fmt.bufPrint(&buf, "{s}/{}.txt", .{ dir_path, day });

    var file = std.fs.openFileAbsolute(filepath, .{}) catch |e| {
        std.log.err("Failed to open file {s}.", .{dir_path});
        return e;
    };
    defer file.close();

    const MAX_FILE_SIZE: usize = 1_000_000_000;
    return file.readToEndAlloc(allocator, MAX_FILE_SIZE);
}

pub const Solution = struct {
    day: u8,
    task1: *const fn (allocator: std.mem.Allocator, input: []const u8) anyerror!usize,
    task2: *const fn (allocator: std.mem.Allocator, input: []const u8) anyerror!usize,
};
