import SwiftUI
import PhotosUI
import Photos

struct CreateView: View {
    @StateObject private var profileParam = ProfileParam()
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedData: Data?
    @State private var imageName: String = ""
//    @State private var useOriginalImage: Bool = false
    
    var body: some View {
        NavigationStack {
            BaseSubView {
                VStack(spacing: 0) {
                    Spacer()
                    
                    Text("PERSONALITY")
                        .font(.EBGaramond_Bold, size: 40)
                        .foregroundStyle(.vampireGrey)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                        .padding(.bottom, 6)
                    
                    Text("Let's set JoyPal's personality!")
                        .font(.Commissioner_Bold, size: 16)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 16)
                    
                    ForEach(TextFieldType.allCases, id: \.self) { type in
                        CustomTextField(type: type, text: $profileParam[type])
                            .padding(.bottom, type != TextFieldType.allCases.last ? 20 : 16)
                    }
                    
                    if selectedItem == nil {
                        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                            Text("Upload a reference image (optional)​")
                                .underline()
                                .font(.Commissioner_Bold, size: 16)
                                .foregroundStyle(.curiousBlue)
                        }
                        .padding(.bottom, 32)
                    } else {
                        HStack(spacing: 20) {
                            Button(action: {
                                selectedItem = nil
                                //                                useOriginalImage = false
                            }, label: {
                                Image(.createTrash)
                            })
                            
                            Text(imageName)
                                .font(.Commissioner_Regular, size: 16)
                                .foregroundStyle(.vampireGrey)
                            
                            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                                Text("Change image")
                                    .underline()
                                    .font(.Commissioner_Bold, size: 16)
                                    .foregroundStyle(.curiousBlue)
                            }
                        }
                        //                        .padding(.bottom, 12.5)
                        //                        
                        //                        HStack(spacing: 10) {
                        //                            Button(action: {
                        //                                useOriginalImage.toggle()
                        //                            }, label: {
                        //                                Image(systemName: "checkmark")
                        //                                    .resizable()
                        //                                    .aspectRatio(contentMode: .fit)
                        //                                    .bold()
                        //                                    .padding(4)
                        //                                    .frame(width: 20, height: 20)
                        //                                    .foregroundStyle(.white)
                        //                                    .background(
                        //                                        RoundedRectangle(cornerRadius: 5)
                        //                                            .foregroundStyle(useOriginalImage ? .deluge : .fog)
                        //                                    )
                        //                            })
                        //                            
                        //                            Text("Use this image directly")
                        //                                .font(.Commissioner_Bold, size: 16)
                        //                                .foregroundStyle(.vampireGrey)
                        //                        }
                        .padding(.bottom, 32)
                    }
                    
                    NavigationLink {
                        CharacterGenerationView(profileParam: profileParam, imgData: selectedData)
                    } label: {
                        Text("Next")
                            .font(.OtomanopeeOne_Regular, size: 22)
                            .padding(.horizontal, 54)
                            .padding(.vertical, 12)
                            .foregroundStyle(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(profileParam.isComplete ? .deluge : .fog)
                            )
                    }
                    .disabled(!profileParam.isComplete)
                    .padding(.bottom, 30)
                    .animation(.linear(duration: 0.1), value: profileParam.isComplete)
                    
                    Text("Don't want to set personality?")
                        .font(.Commissioner_Bold, size: 16)
                        .foregroundStyle(.vampireGrey)
                        .padding(.bottom, 30)
                    
                    NavigationLink {
                        CharacterGenerationView(profileParam: ProfileParam())
                    } label: {
                        Text("Skip")
                            .font(.OtomanopeeOne_Regular, size: 22)
                            .padding(.horizontal, 54)
                            .padding(.vertical, 12)
                            .foregroundStyle(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.deluge)
                            )
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 45)
            }
        }
        .onChange(of: selectedItem) { oldItem, newItem in
            guard let item = newItem, let localID = item.itemIdentifier else { return }
            
            let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
            if let asset = result.firstObject, let resource = PHAssetResource.assetResources(for: asset).first {
                imageName = resource.originalFilename
            }
            
            Task {
                if let loaded = try? await item.loadTransferable(type: Data.self) {
                    selectedData = loaded
                }
            }
        }
        .animation(.linear(duration: 0.25), value: selectedItem)
    }
}

private extension ProfileParam {
    subscript(type: TextFieldType) -> String {
        get {
            switch type {
            case .name: return name
            case .appearance: return appearance
            case .gender: return gender
            case .personality: return personality
            }
        }
        set {
            switch type {
            case .name: name = newValue
            case .appearance: appearance = newValue
            case .gender: gender = newValue
            case .personality: personality = newValue
            }
        }
    }
}

private enum TextFieldType: CaseIterable, Hashable {
    case name
    case appearance
    case gender
    case personality
    
    var placeholder: String {
        switch self {
        case .name: "What's JoyPal's Name?"
        case .appearance: "What does JoyPal look like?"
        case .gender: "What's JoyPal's Gender?"
        case .personality: "What's JoyPal's Personality?"
        }
    }
}

private struct CustomTextField: View {
    let type: TextFieldType
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text(type.placeholder).foregroundStyle(.black.opacity(0.25)))
                .font(size: 16)
            
            Spacer()
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundStyle(.black)
                    .bold()
                    .frame(width: 8, height: 8)
                    .padding(8)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12.5)
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundStyle(.white)
                .overlay(RoundedRectangle(cornerRadius: .infinity)
                    .stroke(.black.opacity(0.25), lineWidth: 1))
        )
    }
}

#Preview {
    CreateView()
        .environmentObject(EnvManager())
}
