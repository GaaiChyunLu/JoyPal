import SwiftUI
import SwiftData

struct CharacterGenerationView: View {
    var profileParam: ProfileParam
    var imgData: Data? = nil
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var envManager: EnvManager
    
    @Query private var profiles: [Profile]
    
    @State var doNavigation: Bool = false
    @State var isGenerating: Bool = false
    
    var body: some View {
        BaseSubView {
            VStack {
                Spacer()
                
                ProgressView() {
                    Text("JoyPal Generating...")
                }
                .progressViewStyle(LinearProgressStyle())
                .padding(.bottom, 43)
                
                Image(.homeIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 132.94, height: 161)
                
                Spacer()
            }
            .padding(.horizontal, 55)
        }
        .task(id: doNavigation) {
            guard doNavigation else { return }
            envManager.selectedTab = .joyPal
            envManager.profileIndex.joyPal = profiles.endIndex - 1
            try? await Task.sleep(for: .milliseconds(700))
            dismiss()
        }
        .onAppear {
            if !isGenerating {
                isGenerating = true
                NetworkManager.generateCharacter(imgData: imgData, profileParam: profileParam) { result in
                    switch result {
                    case .success(let json):
                        if let resName = json["character_name"] as? String,
                           let imageUrlString = json["image_url"] as? String {
                            DispatchQueue.main.async {
                                NetworkManager.fetchImage(from: imageUrlString) { result in
                                    switch result {
                                    case .success(let resImage):
                                        modelContext.insert(Profile(id: UUID(), name: resName, profileParam: profileParam, image: resImage))
                                        try? modelContext.save()
                                        doNavigation = true
                                    case .failure(let error):
                                        print("Error: \(error)")
                                    }
                                }
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}

private struct LinearProgressStyle: ProgressViewStyle {
    @State private var animationOffset: CGFloat = 0
    let barWidth: CGFloat = 50

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 12) {
            configuration.label
                .font(.Commissioner_Bold, size: 16)
                .foregroundStyle(.black)

            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.summerGreen, opacity: 0.5)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.vampireGrey)
                            .frame(width: barWidth)
                            .offset(x: animationOffset)
                            .onAppear {
                                animationOffset = geometry.size.width - barWidth
                            }
                    }
            }
            .frame(height: 4)
            .animation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true), value: animationOffset)
        }
    }
}

#Preview {
    CharacterGenerationView(profileParam: ProfileParam())
}
