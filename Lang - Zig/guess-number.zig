const std = @import("std");
const rnd = std.Random;

pub fn main() !void {
    // Stolen ♥
    // https://zig.guide/standard-library/random-numbers/
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    const stdin = std.io.getStdIn().reader();

    const random_num: u8 = rand.int(u8) % 10;
    std.debug.print("{}\n", .{random_num});
    var user_input: [1024]u8 = undefined;
    var user_guess: u8 = 10;

    while (user_guess != random_num) {
        std.debug.print("Please enter a number from 0 to 9\n", .{});
        std.debug.print(">> ", .{});
        const result = try stdin.readUntilDelimiterOrEof(&user_input, '\n');
        if (result) |value| {
            if (value[0] > 58 or value[0] < 47) {
                std.debug.print("invalid input\n", .{});
            } else {
                user_guess = value[0] - 48;
                if (user_guess > random_num) {
                    std.debug.print("That's a little too high\n", .{});
                } else if (user_guess < random_num) {
                    std.debug.print("That's a little too low\n", .{});
                }
            }
        }
    }
    std.debug.print("That's correct!! Well done", .{});
    return;
}
