import SwiftUI

struct BaseSubView<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        VStack {
            content()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.butteryWhite)
    }
}

#Preview {
    BaseSubView {
        Text("Test Content")
    }
}
