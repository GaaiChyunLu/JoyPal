import SwiftUI

struct CreateView: View {
    var body: some View {
        NavigationStack {
            BaseSubView {
                VStack {
                    NavigationLink {
                        CharacterGenerationView()
                    } label: {
                        Text("Finish")
                    }

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    CreateView()
}
