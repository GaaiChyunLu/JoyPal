import SwiftUI
import SwiftData
import DotLottie

struct HomeView: View {
    @EnvironmentObject private var envManager: EnvManager
    
    @Query private var profiles: [Profile]
    
    @State private var isNext: Bool = true
    
    var body: some View {
        BaseSubView {
            VStack(spacing: 0) {
                Spacer()
                
                if profiles.isEmpty {
                    Text("Create JoyPal")
                        .font(.EBGaramond_Bold, size: 40)
                        .foregroundStyle(.vampireGrey)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                        .padding(.bottom, 66)
                    
                    Image(.homeIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 132.94, height: 161)
                        .padding(.bottom, 55)
                    
                    Text("Create your first JoyPal!")
                        .font(.Commissioner_Bold, size: 16)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 25)
                    
                    Button(action: {
                        envManager.selectedTab = .create
                    }) {
                        Text("Create JoyPal")
                            .frame(width: 220, height: 52)
                            .font(.OtomanopeeOne_Regular, size: 22)
                            .foregroundStyle(.whiteSmoke)
                            .background(
                                RoundedRectangle(cornerRadius: .infinity)
                                    .fill(
                                        .shadow(.drop(color: .black.opacity(0.25), radius: 2, x: 0, y: 5))
                                    )
                                    .foregroundStyle(.deluge)
                            )
                    }
                    .padding(.bottom, 111)
                } else {
                    Text(profiles[envManager.profileIndex.home].name)
                        .font(.FreckleFace_Regular, size: 32)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 58)
                    
                    HStack(spacing: 30) {
                        Button(action: {
                            isNext = false
                            withAnimation(.easeInOut(duration: 0.3)) {
                                envManager.profileIndex.home -= 1
                            }
                        }, label: {
                            Image(.homeLeft)
                        })
                        .disabled(envManager.profileIndex.home == profiles.startIndex)
                        .opacity(envManager.profileIndex.home == profiles.startIndex ? 0.3 : 1)
                        
                        Image(uiImage: profiles[envManager.profileIndex.home].image ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 204, height: 265)
                            .id(envManager.profileIndex.home)
                            .transition(
                                .asymmetric(
                                    insertion: .move(edge: isNext ? .trailing : .leading),
                                    removal: .move(edge: isNext ? .leading : .trailing)
                                )
                                .combined(with: .opacity)
                            )
                            .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        if value.translation.width < -50, envManager.profileIndex.home < profiles.endIndex - 1 {
                                            isNext = true
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                envManager.profileIndex.home += 1
                                            }
                                        } else if value.translation.width > 50, envManager.profileIndex.home > profiles.startIndex {
                                            isNext = false
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                envManager.profileIndex.home -= 1
                                            }
                                        }
                                    }
                            )
                        
                        Button(action: {
                            isNext = true
                            withAnimation(.easeInOut(duration: 0.3)) {
                                envManager.profileIndex.home += 1
                            }
                        }, label: {
                            Image(.homeLeft)
                                .rotationEffect(.degrees(180))
                        })
                        .disabled(envManager.profileIndex.home == profiles.endIndex - 1)
                        .opacity(envManager.profileIndex.home == profiles.endIndex - 1 ? 0.3 : 1)
                    }
                    .padding(.bottom, 62)
                    
                    Text("Talk with this JoyPal!")
                        .font(.Commissioner_Bold, size: 16)
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
                                RoundedRectangle(cornerRadius: .infinity)
                                    .foregroundStyle(.deluge)
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
