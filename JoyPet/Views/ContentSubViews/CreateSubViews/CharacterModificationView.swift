import SwiftUI

private enum PickerType: CaseIterable {
    case gender
    case personality
    case sound
    
    var title: String {
        switch self {
        case .gender:
            "What's pet's gender?"
        case .personality:
            "What's pet's personality like?"
        case .sound:
            "What's pet sounds like?"
        }
    }
    
    var choices: [String] {
        switch self {
        case .gender:
            return ["Male", "Female", "Wallmart bag"]
        case .personality:
            return ["Friendly", "Shy", "Adventurous"]
        case .sound:
            return ["Bark", "Meow", "Squeak"]
        }
    }
}

struct CharacterModificationView: View {
    @State var gender = ""
    @State var personality = ""
    @State var sound = ""
    
    var body: some View {
        BaseSubView(title: "Character Modification") {
            VStack {
                Text("Let's set your pet's personality!")
                
                PersonalityPicker(type: .gender, selection: $gender)
                
                PersonalityPicker(type: .personality, selection: $personality)
                
                PersonalityPicker(type: .sound, selection: $sound)
                
                Button(action: {
                    
                }) {
                    Text("All done!")
                        .frame(width: 150)
                        .padding(.vertical, 10)
                        .background(isAllSelected() ? Color.secondary : Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.white)
                }
                .disabled(isAllSelected())
                
                Text("Don't want to set personality?")
                    
                Button(action: {
                    randomize()
                }) {
                    Text("Skip this step")
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
    
    private func isAllSelected() -> Bool {
        gender.isEmpty || personality.isEmpty || sound.isEmpty
    }
    
    private func randomize() {
        gender = PickerType.gender.choices.randomElement() ?? ""
        personality = PickerType.personality.choices.randomElement() ?? ""
        sound = PickerType.sound.choices.randomElement() ?? ""
    }
}

private struct PersonalityPicker: View {
    var type: PickerType
    @Binding var selection: String
    @State var isPicking = false
    
    var body: some View {
        HStack {
            Text(selection.isEmpty ? type.title : selection)
            
            Spacer()
            
            Image(systemName: "chevron.up.chevron.down")
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        .foregroundColor(selection.isEmpty ? .secondary : .primary)
        .scaleEffect(isPicking ? 1.1 : 1)
        .onTapGesture {
            isPicking.toggle()
        }
        .popover(isPresented: $isPicking, attachmentAnchor: .point(.bottomTrailing), arrowEdge: .top) {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(type.choices, id: \.self) { choice in
                        HStack {
                            Text(choice)
                            
                            Spacer()
                            
                            if choice == selection {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selection = choice
                            isPicking.toggle()
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        
                        if choice != type.choices.last {
                            Divider()
                        }
                    }
                }
            }
            .frame(width: 200)
            .padding(.vertical, 10)
            .scrollIndicators(.never)
            .presentationCompactAdaptation(.popover)
        }
        .animation(.easeInOut(duration: 0.2), value: isPicking)
    }
}

#Preview {
    CharacterModificationView()
}
