import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject private var envManager: EnvManager
    @Query private var allProfiles: [Profile]
    var profiles: [Profile] {
        allProfiles.filter { $0.userId == envManager.userId }
    }
    
    private var filteredTabItems: [TabbedItems] {
        TabbedItems.allCases.filter { item in
            !(item == .joyPal && profiles.isEmpty)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $envManager.selectedTab) {
                HomeView()
                    .tag(TabbedItems.home)
                
                CreateView()
                    .tag(TabbedItems.create)
                
                JoyPalView()
                    .tag(TabbedItems.joyPal)
                
                SettingsView()
                    .tag(TabbedItems.settings)
            }
            
            HStack(spacing: 0) {
                ForEach(filteredTabItems, id: \.self) { item in
                    Button {
                        envManager.selectedTab = item
                    } label: {
                        CustomTabItem(item: item)
                    }
                }
            }
            .frame(width: UIScreen.screenBounds.width, height: 82)
            .padding(.bottom, 10)
            .background(
                Rectangle()
                    .fill(
                        .shadow(.drop(color: .black.opacity(0.25), radius: 2, x: 0, y: -4))
                    )
                    .foregroundStyle(.white)
            )
        }
        .background(.white)
        .ignoresSafeArea()
    }
}

private struct CustomTabItem: View {
    var item: TabbedItems
    @EnvironmentObject private var envManager: EnvManager
    @Query private var allProfiles: [Profile]
    var profiles: [Profile] {
        allProfiles.filter { $0.userId == envManager.userId }
    }
    
    var body: some View {
        let isActive = (envManager.selectedTab == item)
        VStack(spacing: 6) {
            Image(item.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            if isActive {
                Text(item.title)
                    .font(.Hannari_Regular, size: 12)
            }
        }
        .foregroundStyle(.vampireGrey)
        .frame(width: UIScreen.screenBounds.width /
               CGFloat(profiles.isEmpty ? TabbedItems.allCases.count - 1: TabbedItems.allCases.count))
        .animation(.easeInOut(duration: 0.2), value: isActive)
    }
}

#Preview {
    ContentView()
        .environmentObject(EnvManager())
}
