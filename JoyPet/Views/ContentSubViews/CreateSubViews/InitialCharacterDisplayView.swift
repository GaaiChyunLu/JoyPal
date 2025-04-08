import SwiftUI

struct InitialCharacterDisplayView: View {
    var body: some View {
        BaseSubView(title: "Initial Character Display") {
            VStack {
                Text("Character Name")
                
                Image(systemName: "dog")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Great! That's my JoyPet!")
                
                Button(action: {
                    
                }) {
                    Text("Next Step")
                        .frame(width: 150)
                        .padding(.vertical, 10)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.white)
                }
                
                Text("Not satisfied? Maybe you want to")
                
                Button(action: {
                
                }) {
                    Text("Further Adjust")
                        .frame(width: 150)
                        .padding(.vertical, 10)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.white)
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    InitialCharacterDisplayView()
}
