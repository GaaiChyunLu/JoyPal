import SwiftUI

struct ExploreView: View {
    var body: some View {
        BaseSubView(title: "Explore") {
            VStack {
                Text("EXPLORE VIEW")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ExploreView()
}
