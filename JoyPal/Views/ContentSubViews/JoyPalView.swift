import SwiftUI
import SwiftData
import DotLottie

struct JoyPalView: View {
    @EnvironmentObject private var envManager: EnvManager
    
    @Query private var profiles: [Profile]
    
    @State private var hasAppeared = false
    @State private var response: LocalizedStringKey = ""
    @State private var message: String = ""
    @State private var placeholder: String = ""
    @State private var isGenerating: Bool = false
    @State private var doAnimation: Bool = false
    @State private var isNext: Bool = true
    
    @FocusState private var focusing: Bool
    
    var body: some View {
        BaseSubView {
            VStack(spacing: 0) {
                if profiles.isEmpty {
                    Text("No JoyPals yet!")
                } else {
                    Text(profiles[envManager.profileIndex.joyPal].name)
                        .font(.FreckleFace_Regular, size: 25)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 13)
                    
                    HStack(spacing: 60) {
                        Button(action: {
                            doAnimation = true
                            isNext = false
                            withAnimation(.easeInOut(duration: 0.3)) {
                                envManager.profileIndex.joyPal -= 1
                            }
                        }, label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 12, height: 24)
                                .foregroundStyle(.vampireGrey)
                        })
                        .disabled(envManager.profileIndex.joyPal == profiles.startIndex)
                        .opacity(envManager.profileIndex.joyPal == profiles.startIndex ? 0.3 : 1)
                        
                        Image(uiImage: profiles[envManager.profileIndex.joyPal].image ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 200)
                            .id(envManager.profileIndex.joyPal)
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
                                        doAnimation = true
                                        if value.translation.width < -50, envManager.profileIndex.joyPal < profiles.endIndex - 1 {
                                            isNext = true
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                envManager.profileIndex.joyPal += 1
                                            }
                                        } else if value.translation.width > 50, envManager.profileIndex.joyPal > profiles.startIndex {
                                            isNext = false
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                envManager.profileIndex.joyPal -= 1
                                            }
                                        }
                                    }
                            )
                        
                        Button(action: {
                            doAnimation = true
                            isNext = true
                            withAnimation(.easeInOut(duration: 0.3)) {
                                envManager.profileIndex.joyPal += 1
                            }
                        }, label: {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 12, height: 24)
                                .foregroundStyle(.vampireGrey)
                        })
                        .disabled(isGenerating || envManager.profileIndex.joyPal == profiles.endIndex - 1)
                        .opacity(isGenerating || envManager.profileIndex.joyPal == profiles.endIndex - 1 ? 0.3 : 1)
                    }
                    .padding(.bottom, 28)
                    .onAppear {
                        guard !hasAppeared else {
                            hasAppeared = !profiles.isEmpty
                            return
                        }
                        hasAppeared = true
                        placeholder = focusing ? "" : "Chat with \(profiles[envManager.profileIndex.joyPal].name)..."
                    }
                    
                    ScrollView {
                        Text(response)
                            .font(.Commissioner_Regular, size: 16)
                            .foregroundStyle(isGenerating ? .black.opacity(0.3) : .black)
                            .padding(10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.white)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(.osloGrey, lineWidth: 1))
                    )
                    .overlay(alignment: .center) {
                        if isGenerating {
                            DotLottieAnimation(
                                fileName: "joyPalLoading",
                                config: AnimationConfig(autoplay: true, loop: true)
                            )
                            .view()
                            .frame(width: 149, height: 63)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 10)
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $message)
                            .focused($focusing)
                            .disabled(isGenerating)
                            .font(.Commissioner_Regular, size: 16)
                            .foregroundStyle(isGenerating ? .black.opacity(0.3) : .black)
                        
                        if message.isEmpty {
                            Text(placeholder)
                                .foregroundColor(Color(.placeholderText))
                                .font(.Commissioner_Bold, size: 16)
                                .onChange(of: focusing) {
                                    placeholder = focusing ? "" : "Chat with \(profiles[envManager.profileIndex.joyPal].name)..."
                                }
                                .onChange(of: envManager.profileIndex.joyPal) {
                                    placeholder = focusing ? "" : "Chat with \(profiles[envManager.profileIndex.joyPal].name)..."
                                }
                        }
                    }
                    .padding(10)
                    .frame(height: 87, alignment: .topLeading)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.white)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(.osloGrey, lineWidth: 1))
                    )
                    .overlay(alignment: .bottomTrailing) {
                        if !message.isEmpty {
                            Button(action: {
                                focusing = false
                                isGenerating = true
                                
                                NetworkManager.generateText(message: message, profile: profiles[envManager.profileIndex.joyPal]) { result in
                                    switch result {
                                    case .success(let json):
                                        if let resResult = json["result"] as? [String: String],
                                           let resResponse = resResult["SampleSpeech"] {
                                            response = LocalizedStringKey(stringLiteral: resResponse)
                                            isGenerating = false
                                        }
                                    case .failure(let error):
                                        isGenerating = false
                                        print("Error: \(error)")
                                    }
                                }
                            }, label: {
                                Image(isGenerating ? .joyPalGenerating : .joyPalSend)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(5)
                            })
                            .disabled(isGenerating)
                        }
                    }
                    .padding(.horizontal, 18)
                    .animation(.easeInOut(duration: 0.3), value: message)
                    .animation(.easeInOut(duration: 0.3), value: focusing)
                }
            }
            .onDisappear {
                doAnimation = false
            }
            .animation(.easeInOut(duration: doAnimation ? 0.3 : 0), value: envManager.profileIndex.joyPal)
            .padding(.horizontal, 12)
            .padding(.top, 23)
            .padding(.bottom, 28)
        }
        .onTapGesture {
            focusing = false
        }
        .background(
            Color.init(hex: 0xFFFDEE)
                .ignoresSafeArea(.keyboard)
        )
    }
}

#Preview {
    JoyPalView()
        .environmentObject(EnvManager())
}
