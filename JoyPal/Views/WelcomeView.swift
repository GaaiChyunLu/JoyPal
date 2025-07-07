import SwiftUI

struct WelcomeView: View {
    @State var showLoginView = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                
                Text("JoyPal")
                    .font(.EBGaramond_Bold, size: 40)
                    .foregroundStyle(.vampireGrey)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                    .padding(.bottom, 10)
                
                Image(.welcomeIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 206, height: 206)
                    .padding(.bottom, 14)
                
                Text("Character Creator")
                    .font(.OtomanopeeOne_Regular, size: 22)
                    .foregroundStyle(.vampireGrey)
                    .padding(.bottom, 10)
                
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
                            RoundedRectangle(cornerRadius: .infinity)
                                .foregroundStyle(.deluge)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 5)
                        )
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 47.5)
            .ignoresSafeArea()
            .background(.white)
            
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
