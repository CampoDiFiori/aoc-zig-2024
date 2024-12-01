const std = @import("std");
const lib = @import("lib.zig");

pub fn task1(allocator: std.mem.Allocator, input: []const u8) !usize {
    var iter = std.mem.splitScalar(u8, input, '\n');

    var list1 = std.ArrayList(usize).init(allocator);
    defer list1.deinit();
    var list2 = std.ArrayList(usize).init(allocator);
    defer list2.deinit();

    while (iter.next()) |line| {
        if (line.len == 0) {
            break;
        }

        var nums = std.mem.splitSequence(u8, line, "   ");

        try list1.append(try std.fmt.parseInt(usize, nums.next().?, 10));
        try list2.append(try std.fmt.parseInt(usize, nums.next().?, 10));
    }

    std.mem.sort(usize, list1.items, {}, comptime std.sort.asc(usize));
    std.mem.sort(usize, list2.items, {}, comptime std.sort.asc(usize));

    var sum: usize = 0;
    var i: usize = 0;

    while (i < list1.items.len) : (i += 1) {
        if (list1.items[i] > list2.items[i]) {
            sum += list1.items[i] - list2.items[i];
        } else {
            sum += list2.items[i] - list1.items[i];
        }
    }

    return sum;
}

pub fn task2(allocator: std.mem.Allocator, input: []const u8) !usize {
    var iter = std.mem.splitScalar(u8, input, '\n');

    var list1 = std.ArrayList(usize).init(allocator);
    defer list1.deinit();
    var counts = std.AutoHashMap(usize, usize).init(allocator);
    defer counts.deinit();

    while (iter.next()) |line| {
        if (line.len == 0) {
            break;
        }

        var nums = std.mem.splitSequence(u8, line, "   ");

        try list1.append(try std.fmt.parseInt(usize, nums.next().?, 10));

        const n = try std.fmt.parseInt(usize, nums.next().?, 10);
        const count = try counts.getOrPut(n);
        if (count.found_existing) {
            count.value_ptr.* += 1;
        } else {
            count.value_ptr.* = 1;
        }
    }

    var sum: usize = 0;

    for (list1.items) |n| {
        sum += n * (counts.get(n) orelse 0);
    }

    return sum;
}

pub const solution: lib.Solution = .{ .task1 = task1, .task2 = task2, .day = 1 };
