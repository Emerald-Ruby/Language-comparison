const std = @import("std");

pub fn main() !void {
    var user_str: [1024]u8 = undefined;
    const stdin = std.io.getStdIn().reader();

    std.debug.print(">> ", .{});

    // read the console, store the success or failure in result
    const result = try stdin.readUntilDelimiterOrEof(&user_str, '\n');

    // unwrap, error handle
    if (result) |value| {
        std.debug.print("{s}\n", .{value});
    } else {
        std.debug.print("Something went wrong", .{});
    }
}
