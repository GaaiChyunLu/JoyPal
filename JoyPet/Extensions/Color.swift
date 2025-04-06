import SwiftUI

extension Color {
    /// Creates a constant color from hex color codes.
    ///
    /// - Parameters:
    ///   - hex: hex color codes. For example, `0xFF0000` is red.
    ///   - opacity: An optional degree of opacity, given in the range `0` to `1`. A value of `0` means 100% transparency, while a value of `1` means 100% opacity. The default is `1`.
    init(hex: UInt, opacity: Double = 1) {
        guard (0x000000 ... 0xFFFFFF) ~= hex else {
            self.init(red: 0, green: 0, blue: 0, opacity: opacity)
            return
        }
            
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
