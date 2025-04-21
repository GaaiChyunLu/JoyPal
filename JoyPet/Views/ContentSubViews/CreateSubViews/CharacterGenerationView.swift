import SwiftUI

struct CharacterGenerationView: View {
    @State private var progressValue = 0.0
    
    var body: some View {
        BaseSubView {
            VStack(spacing: 0) {
                ProgressView(value: progressValue, total: 100) {
                    Text(progressValue / 100, format: .percent)
                }
                .progressViewStyle(BarProgressStyle())
                .padding(.horizontal, 55)
                .padding(.bottom, 44)
                
                // MARK: - Test Button
//                HStack {
//                    Button("-") {
//                        progressValue -= 10
//                    }
//                    Button("+") {
//                        progressValue += 10
//                    }
//                }
                
                ForEach(CardType.allCases, id: \.self) { cardType in
                    CardView(cardType: cardType)
                    if cardType != CardType.allCases.last {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 57)
            .padding(.bottom, 36)
        }
    }
}

private enum CardType: Int, CaseIterable {
    case viewGallery = 0
    case littleGames
    case aboutUs
    
    var title: String {
        switch self {
        case .viewGallery: "Explore Gallery"
        case .littleGames: "Mini Games"
        case .aboutUs: "About Us"
        }
    }
    
    var description: String {
        switch self {
        case .viewGallery: "Come and see others’ interesting JoyPets!"
        case .littleGames: "Play some interesting games while waiting!"
        case .aboutUs: "You might want to know more about us!"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .viewGallery: "Go to Gallery"
        case .littleGames: "Start Games"
        case .aboutUs: "Enter"
        }
    }
}

private struct CardView: View {
    var cardType: CardType
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading, spacing: 0) {
                Text(cardType.title)
                    .font(.CarterOne_Regular, size: 20)
                    .foregroundStyle(.vampireGrey)
                
                Text(cardType.description)
                    .font(.Commissioner_Regular, size: 16)
                    .foregroundStyle(.butteryWhite)
                    .frame(width: 169, alignment: .leading)
                    .padding(.bottom, 15)
                
                Button(action: {
                    
                }) {
                    Text(cardType.buttonTitle)
                        .font(.Commissioner_Bold, size: 16)
                        .foregroundStyle(.butteryWhite)
                        .padding(.horizontal, 12.5)
                        .padding(.vertical, 8.5)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.sherwoodGreen)
                        )
                }
            }
            
            Image(systemName: "dog")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 16)
        .background(
            Rectangle()
                .fill(
                    .shadow(.drop(color: .black.opacity(0.25), radius: 2, x: 0, y: 6))
                )
                .foregroundStyle(.summerGreen, opacity: 0.5)
        )
    }
}

struct BarProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let progress = configuration.fractionCompleted ?? 0.0
        VStack(spacing: 12) {
            Text("JoyPet Generating...")
                .font(.Jura_Regular, size: 16)
                .foregroundStyle(.black)
            
            configuration.label
                .font(.Jura_Regular, size: 16)
                .foregroundStyle(.black)
            
            GeometryReader { geometry in
                HStack(spacing: progress > 0.0 && progress < 1.0 ? 6 : 0) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.vampireGrey)
                        .frame(width: geometry.size.width * progress)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.summerGreen, opacity: 0.5)
                        .frame(width: geometry.size.width * (1 - progress))
                }
            }
            .animation(.easeInOut(duration: 0.1), value: progress)
            .frame(height: 4)
        }
    }
}

#Preview {
    CharacterGenerationView()
}
