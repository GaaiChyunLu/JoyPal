import SwiftUI

extension Shape {
    /// Traces the shape with a stroke using a hex color code.
    ///
    /// - Parameters:
    ///   - color: The hex color code.
    ///   - opacity: An optional degree of opacity, given in the range `0` to `1`. A value of `0` means 100% transparency, while a value of `1` means 100% opacity. The default is `1`.
    ///   - lineWidth: The width of the stroke that outlines this shape.
    nonisolated public func stroke(_ color: HexColor, opacity: Double = 1, lineWidth: CGFloat) -> some View {
        self.stroke(Color(hex: color.rawValue, opacity: opacity), lineWidth: lineWidth)
    }
}
