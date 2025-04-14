import SwiftUI

struct ExploreView: View {
    var body: some View {
        BaseSubView {
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
