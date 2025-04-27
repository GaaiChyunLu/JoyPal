import SwiftUI

struct BaseSubView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    
    var content: () -> Content
    
    var body: some View {
        VStack {
            content()
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.butteryWhite)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BaseSubView {
        Text("Test Content")
    }
}
