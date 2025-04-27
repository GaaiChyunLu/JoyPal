import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var envManager: EnvManager
    
    var body: some View {
        BaseSubView {
            VStack(alignment: .leading, spacing: 20) {
                Button(action: {
                    do {
                        envManager.profileIndex.reSet()
                        try modelContext.delete(model: Profile.self)
                    } catch {
                        print("Failed to delete students.")
                    }
                }) {
                    ButtonLabel(label: "Delete All Profiles")
                }
            }
            .padding(.horizontal, 35)
            .padding(.top, 50)
        }
    }
}

private struct ButtonLabel: View {
    var label: String
    
    var body: some View {
        Text(label)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.Commissioner_Bold, size: 18)
            .foregroundStyle(.butteryWhite)
            .padding(.leading, 10)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.sherwoodGreen)
            )
    }
}


#Preview {
    SettingsView()
        .environmentObject(EnvManager())
}
