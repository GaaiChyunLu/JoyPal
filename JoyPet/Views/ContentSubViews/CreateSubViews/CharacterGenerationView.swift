import SwiftUI

private enum CardType: Int, CaseIterable {
    case viewGallery = 0
    case littleGames
    case aboutUs
    
    var title: String {
        switch self {
        case .viewGallery:
            "View Gallery"
        case .littleGames:
            "Little Games"
        case .aboutUs:
            "About Us"
        }
    }
    
    var description: String {
        switch self {
        case .viewGallery:
            "Come and see others' interesting JoyPets!"
        case .littleGames:
            "Come and play few interesting games while waiting!"
        case .aboutUs:
            "Maybe you would like to know more about us!"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .viewGallery:
            "Go to Gallery"
        case .littleGames:
            "Start Play"
        case .aboutUs:
            "Enter"
        }
    }
}

struct CharacterGenerationView: View {
    @State private var progressValue = 0.0
    
    var body: some View {
        BaseSubView(title: "Character Generation") {
            VStack {
                ProgressView(value: progressValue, total: 100) {
                    Text(progressValue / 100, format: .percent)
                }
                .padding(.horizontal, 60)
                .progressViewStyle(BarProgressStyle(height: 20.0))
                
                Button("add") {
                    progressValue += 10
                }
                
                CardView(cardType: .viewGallery)
                
                CardView(cardType: .littleGames)
                
                CardView(cardType: .aboutUs)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

private struct CardView: View {
    var cardType: CardType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cardType.title)
                    .bold()
                
                Text(cardType.description)
                
                Button(action: {
                    
                }) {
                    Text(cardType.buttonTitle)
                        .padding(10)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.white)
                }
            }
            
            Spacer()
            
            Image(systemName: "dog")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
    }
}

#Preview {
    CharacterGenerationView()
}
