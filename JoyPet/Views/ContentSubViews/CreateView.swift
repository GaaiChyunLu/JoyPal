import SwiftUI

struct CreateView: View {
    var body: some View {
        BaseSubView(title: "Create") {
            VStack {
                Text("CREATE VIEW")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    CreateView()
}
