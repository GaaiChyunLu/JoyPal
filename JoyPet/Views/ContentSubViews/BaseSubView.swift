import SwiftUI

struct BaseSubView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    var isFirstView: Bool = false
    var content: () -> Content
    
    var body: some View {
        VStack {
            content()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.butteryWhite)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if !isFirstView {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.backward.circle")
                            .bold()
                            .foregroundStyle(.vampireGrey)
                    }
                }
            }
        }
    }
}

#Preview {
    BaseSubView {
        Text("Test Content")
    }
}
