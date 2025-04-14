import SwiftUI

@main
struct JoyPetApp: App {
    @StateObject private var tabManager = TabManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tabManager)
        }
    }
}
