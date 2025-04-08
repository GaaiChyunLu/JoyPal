import SwiftUI

struct JoyPetView: View {
    var body: some View {
        BaseSubView(title: "JoyPet Name") {
            VStack {
                Image(systemName: "dog")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Date:")
                
                Text("Schedule:")
                
                Text("Mood:")
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    JoyPetView()
}
