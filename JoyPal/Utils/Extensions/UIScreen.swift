import UIKit

extension UIScreen {
    /// Returns the current screen.
    static var screenBounds: CGRect {
        guard let screenBounds = UIWindow.current?.screen.bounds else {
            fatalError("Failed to get the current screen.")
        }
        return screenBounds
    }
}
