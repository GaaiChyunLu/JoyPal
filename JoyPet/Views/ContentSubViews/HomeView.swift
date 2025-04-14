import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var tabManager: TabManager
    
    var body: some View {
        BaseSubView {
            VStack(spacing: 0) {
                Text("Create JoyPet")
                    .font(.FreckleFace_Regular, size: 32)
                    .foregroundStyle(.vampireGrey)
                    .padding(.bottom, 5)
                
                VStack(spacing: 28) {
                    Button(action: {
                        tabManager.selectedTab = .create
                    }) {
                        ButtonLabel(label: "Design JoyPet")
                    }
                    
                    Button(action: {
                        
                    }) {
                        ButtonLabel(label: "Import File")
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 33)
                .background(
                    Rectangle()
                        .fill(
                            .shadow(.drop(color: .black.opacity(0.25), radius: 3, x: 0, y: 6))
                        )
                        .foregroundStyle(.summerGreen, opacity: 0.5)
                )
                
                Spacer()
                
                Text("JoyPet Gallery")
                    .font(.FreckleFace_Regular, size: 32)
                    .foregroundStyle(.vampireGrey)
                    .padding(.bottom, 5)
                
                HStack(spacing: 18) {
                    ForEach(0..<3) { _ in
                        GalleryView()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 26)
                .background(
                    Rectangle()
                        .fill(
                            .shadow(.drop(color: .black.opacity(0.25), radius: 3, x: 0, y: 6))
                        )
                        .foregroundStyle(.summerGreen, opacity: 0.5)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 35)
            .padding(.top, 108)
            .padding(.bottom, 90)
        }
    }
}

private struct ButtonLabel: View {
    var label: String
    
    var body: some View {
        Text(label)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .font(.OtomanopeeOne_Regular, size: 22)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        .shadow(.drop(color: .black.opacity(0.25), radius: 2, x: 0, y: 5))
                    )
                    .foregroundStyle(.apricot, opacity: 0.8)
            )
    }
}

private struct GalleryView: View {
    var body: some View {
        Circle()
            .fill(.white)
            .scaleEffect(x: 1.0, y: 95.0 / 80.0)
            .frame(width: 80, height: 95)
    }
}

#Preview {
    HomeView()
        .environmentObject(TabManager())
}
