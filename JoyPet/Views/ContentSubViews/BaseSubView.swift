import SwiftUI

struct BaseSubView<Content: View>: View {
    var title: String
    var content: () -> Content
    
    var body: some View {
        VStack {
            Text(title)
            
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    BaseSubView(title: "Test Title") {
        Text("Test Content")
    }
}
