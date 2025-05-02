import SwiftUI

struct WelcomeView: View {
    @State var showLoginView = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                
                Text("JoyPal")
                    .font(.FreckleFace_Regular, size: 32)
                    .foregroundStyle(.vampireGrey)
                    .padding(.bottom, 10)
                
                Image(.welcomeIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 136, height: 136)
                    .background(.summerGreen, opacity: 0.5)
                    .clipShape(Circle())
                    .padding(.bottom, 20)
                
                Text("Character Creator")
                    .font(.OtomanopeeOne_Regular, size: 22)
                    .foregroundStyle(.vampireGrey)
                    .padding(.bottom, 15)
                
                Text("Enter the world of character creation")
                    .font(.Jura_Regular, size: 16)
                    .foregroundStyle(.vampireGrey)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring) {
                        showLoginView = true
                    }
                }) {
                    Text("Get Start")
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .font(.OtomanopeeOne_Regular, size: 22)
                        .foregroundStyle(.whiteSmoke)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(.sherwoodGreen)
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.heavyMetal, lineWidth: 1))
                        )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 39)
            .padding(.bottom, 82)
            .ignoresSafeArea()
            .background(.butteryWhite)
            
            if showLoginView {
                LoginView()
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(EnvManager())
}
