import Foundation

extension String {
    /// Counts the number of characters in the string, treating ASCII characters as 1 and non-ASCII characters as 2.
    public var weightedCount: Int {
        get {
            self.unicodeScalars.reduce(0) {
                $0 + ($1.isASCII ? 1 : 2)
            }
        }
    }
}
