import SwiftUI

/// Enum representing the tabbed items of the tab bar.
public enum TabbedItems: Int, CaseIterable {
    /// The tab representing the home view.
    case home = 0
    /// The tab representing the create view.
    case create
    /// The tab representing the JoyPal view.
    case joyPal
    /// The tab representing the settings view.
    case settings
    
    /// The title of the tab.
    var title: String {
        get {
            switch self {
            case .home: "Home"
            case .create: "Create"
            case .joyPal: "JoyPal"
            case .settings: "Settings"
            }
        }
    }
    
    /// The image resource associated with the tab.
    var iconName: ImageResource {
        get {
            switch self {
            case .home: .contentHome
            case .create: .contentCreate
            case .joyPal: .contentJoyPal
            case .settings: .contentSettings
            }
        }
    }
}

/// A class that manages the state of some environment variables in the app.
public class EnvManager: ObservableObject {
    /// The currently selected tab in the tab bar.
    @Published var selectedTab: TabbedItems = .home
    /// The indices of the currently displayed profile.
    @Published var profileIndex = ProfileIndex()
}

/// A struct representing the indices of the currently displayed profiles.
public struct ProfileIndex {
    /// The profile index in the home view.
    var home: Int = 0
    /// The profile index in the JoyPal view.
    var joyPal: Int = 0
    
    /// Resets the profile indices to their initial values, i.e., `0`.
    public mutating func reSet() {
        home = 0
        joyPal = 0
    }
}
