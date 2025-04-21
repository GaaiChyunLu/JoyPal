import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Access Account")
                .font(.FreckleFace_Regular, size: 32)
                .foregroundStyle(.vampireGrey)
                .padding(.bottom, 20)
            
            VStack(spacing: 34) {
                LoginTextField(type: .username, text: $username)
                
                LoginTextField(type: .password, text: $password)
            }
            .padding(.horizontal, 29)
            .padding(.vertical, 42)
            .background(
                Rectangle()
                    .fill(
                        .shadow(.drop(color: .black.opacity(0.25), radius: 3, x: 0, y: 6))
                    )
                    .foregroundStyle(.butteryWhite)
            )
            .padding(.bottom, 30)
            
            Button(action: {
                // TODO: Retrieve password
            }) {
                HStack {
                    Text("Forget your password?")
                        .font(Font.system(size: 12))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.bottom, 25)
            
            Button(action: {
                // TODO: Log in
            }) {
                Text("Log In")
                    .padding(.vertical, 11)
                    .padding(.horizontal, 58)
                    .font(.OtomanopeeOne_Regular, size: 22)
                    .foregroundStyle(.whiteSmoke)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.sherwoodGreen)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.heavyMetal, lineWidth: 1))
                    )
            }
            .padding(.bottom, 16)
            
            Button(action: {
                // TODO: Sign up
            }) {
                Text("Sign Up")
                    .font(Font.system(size: 12))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 142)
        .padding(.horizontal, 35)
        .ignoresSafeArea()
        .background(.butteryWhite)
    }
}

private enum TextFieldType {
    case username
    case password
    
    var placeholder: String {
        switch self {
        case .username:
            "Username"
        case .password:
            "Password"
        }
    }
    
    var imageName: ImageResource {
        switch self {
        case .username:
            .logInPerson
        case .password:
            .logInLock
        }
    }
}

private struct LoginTextField: View {
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
                TextField(type.placeholder, text: $text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            case .password:
                SecureField(type.placeholder, text: $text)
            }
        }
        .font(.Commissioner_Bold, size: 16)
        .foregroundStyle(.white)
        .frame(height: 53)
        .padding(.horizontal, 11)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    .shadow(.inner(color: .black.opacity(0.25), radius: 2, x: 0, y: 5))
                )
                .foregroundStyle(.apricot, opacity: 0.8)
        )
    }
}

#Preview {
    LoginView()
}
