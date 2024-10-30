const std = @import("std");
const print = std.debug.print;
const mem = std.mem;

pub fn main() !void {
    const PROMPT = "Please enter one of the following:";
    const TYPE = "type";
    const TS = "typescript";
    const JS = "javascript";
    const ANYTHING = "Or anything!!";

    print("{s}\n\t{s}\n\t{s}\n\t{s}\n\t{s}\n", .{ PROMPT, TYPE, TS, JS, ANYTHING });

    var buffer: [1024]u8 = undefined;
    const stdin = std.io.getStdIn().reader();

    // read the console, store the success or failure in result
    const result = try stdin.readUntilDelimiterOrEof(&buffer, '\n');

    if (result) |user_str| {
        if (user_str.len == 1) {
            print("That's nothing!\n", .{});
        } else if (user_str.len >= TS.len and (string_comparison(user_str, TS) or string_comparison(user_str, JS))) {
            print("Ew ew ew ew away!\n", .{});
        } else if (user_str.len >= TYPE.len and string_comparison(user_str, TYPE)) {
            print("safety!\n", .{});
        } else {
            print("Hmm yes I see, {s}\n", .{user_str[0..user_str.len]});
        }
    } else {
        print("Something went wrong\n", .{});
    }
}

// easier then mem.eql(u8, user_str[0..TYPE.len], TYPE)
// a little easier then that in every if statement
fn string_comparison(input: []u8, target: []const u8) bool {
    return mem.eql(u8, input[0..target.len], target);
}
