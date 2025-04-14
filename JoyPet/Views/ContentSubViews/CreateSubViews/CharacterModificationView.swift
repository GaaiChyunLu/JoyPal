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
    
    @State private var currentPicker: PickerType? = nil
    
    var body: some View {
        BaseSubView {
            VStack {
                Text("Let's set your pet's personality!")
                
                PersonalityPicker(type: .gender, selection: $gender, currentPicker: $currentPicker)
                
                PersonalityPicker(type: .personality, selection: $personality, currentPicker: $currentPicker)
                
                PersonalityPicker(type: .sound, selection: $sound, currentPicker: $currentPicker)
                
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
        .animation(.easeInOut(duration: 0.2), value: currentPicker)
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
    @Binding var currentPicker: PickerType?
    
    var body: some View {
        VStack {
            HStack {
                Text(selection.isEmpty ? type.title : selection)
                
                Spacer()
                
                Image(systemName: "chevron.up")
                    .rotationEffect(.degrees(isPicking() ? 180 : 0))
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            .foregroundColor(selection.isEmpty ? .secondary : .primary)
            .scaleEffect(isPicking() ? 1.05 : 1)
            .onTapGesture {
                currentPicker = currentPicker == type ? nil : type
            }
            
            if isPicking() {
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
                                currentPicker = nil
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                            
                            if choice != type.choices.last {
                                Divider()
                            }
                        }
                    }
                }
                .frame(height: 120)
                .padding(.vertical, 10)
                .scrollIndicators(.never)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
            }
        }
    }
    
    private func isPicking() -> Bool {
        currentPicker == type
    }
}

#Preview {
    CharacterModificationView()
}
