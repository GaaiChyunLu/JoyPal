import SwiftUI

public enum TabbedItems: Int, CaseIterable {
    case home = 0
    case explore
    case create
    case joyPet
    case settings
    
    var title: String {
        switch self {
        case .home: "Home"
        case .explore: "Explore"
        case .create: "Create"
        case .joyPet: "JoyPet"
        case .settings: "Settings"
        }
    }
    
    var iconName: ImageResource {
        switch self {
        case .home: .contentHome    
        case .explore: .contentExplore
        case .create: .contentCreate
        case .joyPet: .contentJoyPet
        case .settings: .contentSettings
        }
    }
}

class TabManager: ObservableObject {
    @Published var selectedTab: TabbedItems = .home
}
