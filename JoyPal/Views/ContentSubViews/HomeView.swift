import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject private var envManager: EnvManager
    
    @Query private var profiles: [Profile]
    
    var body: some View {
        BaseSubView {
            VStack(spacing: 0) {
                Spacer()
                
                if profiles.isEmpty {
                    Text("Create JoyPal")
                        .font(.FreckleFace_Regular, size: 32)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 50)
                    
                    Text("Create your first JoyPal!")
                        .font(.CarterOne_Regular, size: 20)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 50)
                    
                    Button(action: {
                        envManager.selectedTab = .create
                    }) {
                        Text("Create JoyPal")
                            .frame(width: 250, height: 52)
                            .font(.OtomanopeeOne_Regular, size: 22)
                            .foregroundStyle(.whiteSmoke)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        .shadow(.drop(color: .black.opacity(0.25), radius: 2, x: 0, y: 5))
                                    )
                                    .foregroundStyle(.apricot, opacity: 0.8)
                            )
                    }
                    .padding(.bottom, profiles.isEmpty ? 0 : 20)
                } else {
                    Text(profiles[envManager.profileIndex.home].name)
                        .font(.FreckleFace_Regular, size: 32)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 58)
                        .animation(.linear(duration: 0.3), value: envManager.profileIndex.home)
                    
                    HStack(spacing: 30) {
                        Button(action: {
                            envManager.profileIndex.home -= 1
                        }, label: {
                            Image(.homeLeft)
                        })
                        .disabled(envManager.profileIndex.home == profiles.startIndex)
                        .opacity(envManager.profileIndex.home == profiles.startIndex ? 0.3 : 1)
                        
                        Image(uiImage: profiles[envManager.profileIndex.home].image ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 204, height: 265)
                            .animation(.linear(duration: 0.3), value: envManager.profileIndex.home)
                        
                        Button(action: {
                            envManager.profileIndex.home += 1
                        }, label: {
                            Image(.homeLeft)
                                .rotationEffect(.degrees(180))
                        })
                        .disabled(envManager.profileIndex.home == profiles.endIndex - 1)
                        .opacity(envManager.profileIndex.home == profiles.endIndex - 1 ? 0.3 : 1)
                        
                    }
                    .padding(.bottom, 62)
                    
                    Text("Talk with this JoyPal!")
                        .font(.CarterOne_Regular, size: 20)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 30)
                    
                    Button(action: {
                        envManager.profileIndex.joyPal = envManager.profileIndex.home
                        envManager.selectedTab = .joyPal
                    }) {
                        Text("Begin")
                            .frame(width: 189, height: 50)
                            .font(.OtomanopeeOne_Regular, size: 22)
                            .foregroundStyle(.whiteSmoke)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.sherwoodGreen)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.heavyMetal, lineWidth: 1))
                            )
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(EnvManager())
}
