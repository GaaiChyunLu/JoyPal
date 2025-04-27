import SwiftUI

struct CreateView: View {
    @StateObject private var profileParam = ProfileParam()
    
    var body: some View {
        NavigationStack {
            BaseSubView {
                VStack(spacing: 0) {
                    Spacer()
                    
                    Text("Let's set JoyPal's personality!")
                        .font(.CarterOne_Regular, size: 20)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 30)
                    
                    ForEach(TextFieldType.allCases, id: \.self) { type in
                        CustomTextField(type: type, text: $profileParam[type])
                            .padding(.bottom, type != TextFieldType.allCases.last ? 20 : 30)
                    }
                    
                    NavigationLink {
                        CharacterGenerationView(profileParam: profileParam)
                    } label: {
                        Text("Next")
                            .font(.OtomanopeeOne_Regular, size: 22)
                            .padding(.horizontal, 54)
                            .padding(.vertical, 12)
                            .foregroundStyle(.butteryWhite)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(profileParam.isComplete ? .sherwoodGreen : .heavyMetal, opacity: profileParam.isComplete ? 1 : 0.5)
                            )
                    }
                    .disabled(!profileParam.isComplete)
                    .padding(.bottom, 30)
                    .animation(.linear(duration: 0.1), value: profileParam.isComplete)
                    
                    Text("Don't want to set personality?")
                        .font(.Commissioner_Bold, size: 16)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 30)
                    
                    Button(action: {
                    }) {
                        Text("Skip")
                            .font(.OtomanopeeOne_Regular, size: 22)
                            .padding(.horizontal, 54)
                            .padding(.vertical, 12)
                            .foregroundStyle(.butteryWhite)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.sherwoodGreen)
                            )
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 45)
            }
        }
        .background(
            Color.init(hex: 0xFFFDEE)
                .ignoresSafeArea(.keyboard)
        )
    }
}

private extension ProfileParam {
    subscript(type: TextFieldType) -> String {
        get {
            switch type {
            case .name: return name
            case .appearance: return appearance
            case .gender: return gender
            case .personality: return personality
            }
        }
        set {
            switch type {
            case .name: name = newValue
            case .appearance: appearance = newValue
            case .gender: gender = newValue
            case .personality: personality = newValue
            }
        }
    }
}

private enum TextFieldType: CaseIterable, Hashable {
    case name
    case appearance
    case gender
    case personality
    
    var placeHolder: String {
        switch self {
        case .name: "What's JoyPal's Name?"
        case .appearance: "What does JoyPal look like?"
        case .gender: "What's JoyPal's Gender?"
        case .personality: "What's JoyPal's Personality?"
        }
    }
}

private struct CustomTextField: View {
    let type: TextFieldType
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField(type.placeHolder, text: $text)
                .font(size: 16)
//                .onChange(of: text) {
//                    if text.count > 10 {
//                        text = String(text.prefix(10))
//                    }
//                }
            
            Spacer()
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundStyle(.black)
                    .bold()
                    .frame(width: 8, height: 8)
                    .padding(8)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12.5)
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundStyle(.white)
                .overlay(RoundedRectangle(cornerRadius: .infinity)
                    .stroke(.black.opacity(0.25), lineWidth: 1))
        )
    }
}

#Preview {
    CreateView()
        .environmentObject(EnvManager())
}
