import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var tabManager: TabManager
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $tabManager.selectedTab) {
                HomeView()
                    .tag(TabbedItems.home)
                
                ExploreView()
                    .tag(TabbedItems.explore)
                
                CreateView()
                    .tag(TabbedItems.create)
                
                JoyPetView()
                    .tag(TabbedItems.joyPet)
            }
            
            HStack(spacing: 0) {
                ForEach(TabbedItems.allCases, id: \.self) { item in
                    Button(action: {
                        tabManager.selectedTab = item
                    }) {
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
                    .foregroundStyle(.butteryWhite)
            )
        }
        .ignoresSafeArea()
    }
}

private struct CustomTabItem: View {
    var item: TabbedItems
    @EnvironmentObject private var tabManager: TabManager
    
    var body: some View {
        let isActive = (tabManager.selectedTab == item)
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
        .frame(width: UIScreen.screenBounds.width / 5)
        .animation(.easeInOut(duration: 0.2), value: isActive)
    }
}

#Preview {
    ContentView()
        .environmentObject(TabManager())
}
