import SwiftUI

private enum QuestionType: Int, CaseIterable {
    case strength = 0
    case weakness
    case hobby
    
    var title: String {
        switch self {
        case .strength:
            "What is your character's greatest strength?"
        case .weakness:
            "What is your character's greatest weakness?"
        case .hobby:
            "What is your character's favorite hobby?"
        }
    }
    
    var choices: [String] {
        switch self {
        case .strength:
            return ["Adventurous", "Cautious", "Friendly", "Generous"]
        case .weakness:
            return ["Impulsive", "Lazy", "Shy", "Stubborn"]
        case .hobby:
            return ["Cooking", "Gardening", "Reading", "Traveling"]
        }
    }
}

struct PersonalizationSettingsView: View {
    @State private var questionType = QuestionType.strength
    let questionCount = QuestionType.allCases.count
    @State private var selectedChoices = [String].init(repeating: "", count: QuestionType.allCases.count)
    
    var body: some View {
        BaseSubView(title: "Personalization Settings") {
            VStack {
                Text("Character Personality Questionnaire")
                
                Text(questionType.title)
                    
                ForEach(questionType.choices, id: \.self) { choice in
                    let selectedChoice = selectedChoices[questionType.rawValue]
                    
                    Button(action: {
                        selectedChoices[questionType.rawValue] = choice
                    }) {
                        Text(choice)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedChoice == choice ? Color.black : Color.gray)
                            .foregroundStyle(selectedChoice == choice ? Color.white : Color.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                HStack {
                    Button(action: {
                        questionType = QuestionType(rawValue: questionType.rawValue - 1) ?? QuestionType(rawValue: 0)!
                    }) {
                        Text("Previous")
                    }
                    .disabled(questionType.rawValue == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        questionType = QuestionType(rawValue: questionType.rawValue + 1) ?? QuestionType(rawValue: questionCount - 1)!
                    }) {
                        Text("Next")
                    }
                    .disabled(questionType.rawValue + 1 == questionCount)
                }
                
                Text("Question \(questionType.rawValue + 1) of \(questionCount)")
                
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
    
    private func randomize() {
        for i in 0..<selectedChoices.count {
            selectedChoices[i] = QuestionType.allCases[i].choices.randomElement() ?? ""
        }
    }
}

#Preview {
    PersonalizationSettingsView()
}
