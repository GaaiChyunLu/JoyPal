import SwiftUI

extension View {
    /// Applies a custom font to the view.
    ///
    /// - Parameters:
    ///   - name: The name of the font.
    ///   - size: The size of the font.
    ///
    /// - Returns: A view with the custom font applied.
    nonisolated public func font(_ name: FontName, size: CGFloat) -> some View {
        self.font(.custom(name.rawValue, size: size))
    }
    
    /// Applies a custom color to the view.
    ///
    /// - Parameters:
    ///   - color: The hex color code.
    ///   - opacity: An optional degree of opacity, given in the range `0` to `1`. A value of `0` means 100% transparency, while a value of `1` means 100% opacity. The default is `1`.
    ///
    /// - Returns: A view with the custom color applied.
    nonisolated public func foregroundStyle(_ color: HexColor, opacity: Double = 1) -> some View {
        self.foregroundStyle(Color(hex: color.rawValue, opacity: opacity))
    }
    
    /// Applies a custom background color to the view.
    ///
    /// - Parameters:
    ///   - color: The hex color code.
    ///   - opacity: An optional degree of opacity, given in the range `0` to `1`. A value of `0` means 100% transparency, while a value of `1` means 100% opacity. The default is `1`.
    ///
    /// - Returns: A view with the custom background color applied.
    nonisolated public func background(_ color: HexColor, opacity: Double = 1) -> some View {
        self.background(Color(hex: color.rawValue, opacity: opacity))
    }
}
