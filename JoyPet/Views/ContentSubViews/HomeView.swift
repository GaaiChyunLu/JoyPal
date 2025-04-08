import SwiftUI

struct HomeView: View {
    var body: some View {
        BaseSubView(title: "Home") {
            VStack {
                Text("HOME VIEW")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    HomeView()
}
