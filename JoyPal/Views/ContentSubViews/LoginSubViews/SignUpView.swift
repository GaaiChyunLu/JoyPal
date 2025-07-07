import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var message: String = ""
    @State private var isProcessing: Bool = false
    @State private var shake: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Sign Up")
                .font(.EBGaramond_Bold, size: 40)
                .foregroundStyle(.vampireGrey)
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                .padding(.bottom, 23)
            
            VStack(spacing: 34) {
                SignUpTextField(type: .username, text: $username)
                
                SignUpTextField(type: .password, text: $password)
                
                SignUpTextField(type: .confirmPassword, text: $confirmPassword)
            }
            .padding(.horizontal, 27)
            .padding(.vertical, 38)
            .background(
                Rectangle()
                    .fill(
                        .shadow(.drop(color: .black.opacity(0.25), radius: 3, x: 0, y: 6))
                    )
                    .foregroundStyle(.fog)
            )
            .padding(.bottom, 23)
            .disabled(isProcessing)
            
            Text(message)
                .foregroundStyle(.cornellRed)
                .font(size: 12)
                .offset(x: shake ? 30 : 0)
                .padding(.bottom, 44)
            
            Button(action: {
                if username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                    message = "Please fill in all required fields"
                    shakeMessage()
                } else if !message.isEmpty {
                    shakeMessage()
                } else {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    isProcessing = true
                    NetworkManager.signUp(username: username, password: password) { result in
                        switch result {
                        case .success(let json):
                            if let resError = json["error"] as? String {
                                if !resError.isEmpty {
                                    message = resError
                                    shakeMessage()
                                    print("Error: \(resError)")
                                }
                                break
                            }
                            
                            if let resMessage = json["message"] as? String {
                                if resMessage == "User registered successfully" {
                                    dismiss()
                                }
                            }
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                        isProcessing = false
                    }
                }
            }) {
                Text("Submit")
                    .padding(.vertical, 11)
                    .padding(.horizontal, 55.5)
                    .font(.OtomanopeeOne_Regular, size: 22)
                    .foregroundStyle(.whiteSmoke)
                    .background(
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(isProcessing ? .amethystSmoke : .deluge)
                    )
            }
            .disabled(isProcessing)
            .padding(.bottom, 44)
            
            Button(action: {
                dismiss()
            }) {
                Text("Back to Login")
                    .foregroundStyle(isProcessing ? .vampireGrey : .curiousBlue, opacity: isProcessing ? 0.5 : 1)
                    .font(size: 12)
            }
            .disabled(isProcessing)
            
            Spacer()
        }
        .padding(.top, 88)
        .padding(.bottom, 81)
        .padding(.horizontal, 34.5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .ignoresSafeArea()
        .onChange(of: [username, password, confirmPassword]) {
            checkValid()
        }
    }
    
    private func checkValid() {
        if username.contains(" ") {
            message = "Username contains invalid characters"
            return
        }
        if password.contains(" ") {
            message = "Password contains invalid characters"
            return
        }
        if username.weightedCount > 14 {
            message = "Username must be under 14 characters (7 Chinese characters)"
            return
        }
        if password.count < 6 || password.count > 18 {
            message = "Password must be 6-18 characters"
            return
        }
        if password != confirmPassword {
            message = "Passwords do not match"
            return
        }
        message = ""
    }
    
    private func shakeMessage() {
        shake = true
        withAnimation(.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
            shake = false
        }
    }
}

private enum TextFieldType {
    case username
    case password
    case confirmPassword
    
    var placeholder: String {
        switch self {
        case .username:
            "Username"
        case .password:
            "Password"
        case .confirmPassword:
            "Confirm Password"
        }
    }
    
    var imageName: ImageResource {
        switch self {
        case .username:
            .logInPerson
        default:
            .logInLock
        }
    }
}

private struct SignUpTextField: View {
    var type: TextFieldType
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(type.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
            
            switch type {
            case .username:
                TextField("", text: $text, prompt: Text(type.placeholder).foregroundStyle(.black.opacity(0.25)))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .frame(height: 40)
            default:
                SecureField("", text: $text, prompt: Text(type.placeholder).foregroundStyle(.black.opacity(0.25)))
                    .frame(height: 40)
            }
        }
        .font(size: 16)
        .foregroundStyle(.vampireGrey)
        .frame(height: 53)
        .padding(.horizontal, 11)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .overlay(alignment: .leading) {
                    Color.black
                        .frame(width: 10)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 3)
                        .offset(x: -10)
                }
                .overlay(alignment: .trailing) {
                    Color.black
                        .frame(width: 10)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: -3)
                        .offset(x: 10)
                }
                .overlay(alignment: .top) {
                    Color.black
                        .frame(height: 10)
                        .shadow(color: .black.opacity(0.25), radius: 2, y: 6)
                        .offset(y: -10)
                }
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        )
    }
}

#Preview {
    SignUpView()
}
