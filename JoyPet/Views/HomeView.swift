import SwiftUI

struct HomeView: View {
    var body: some View {
        BaseSubView(title: "Home") {
            Text("Home View")
        }
    }
}

#Preview {
    HomeView()
}
