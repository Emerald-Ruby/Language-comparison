const std = @import("std");

// In Vscode it formates to this... I hate this
pub fn main() void {
    const hello: []const u8 = "Hello world!!";
    std.debug.print("{s}", .{hello});
}
