import SwiftUI
import SwiftData

@main
struct JoyPalApp: App {
    @StateObject private var envManager = EnvManager()
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
        .environmentObject(envManager)
        .modelContainer(for: Profile.self)
    }
}
