const std = @import("std");
const lib = @import("lib.zig");
const day1 = @import("day1.zig");

pub fn main() !void {
    var args = std.process.args();
    _ = args.next();
    const input_dirpath = args.next() orelse {
        std.log.err("Expected an argument with a path to a directory with AOC 2024 input files.", .{});
        return;
    };

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    try run_day(allocator, input_dirpath, day1.solution);
}

fn run_day(allocator: std.mem.Allocator, input_dirpath: []const u8, solution: lib.Solution) !void {
    const input = try lib.read_day_file(allocator, input_dirpath, solution.day);

    var output = try solution.task1(allocator, input);
    std.log.info("TASK 1 result is {}.", .{output});

    output = try solution.task2(allocator, input);
    std.log.info("TASK 2 result is {}.", .{output});
}
