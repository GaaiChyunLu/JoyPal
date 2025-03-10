import SwiftUI

private enum TextFieldType {
    case username
    case password
    
    var placeholder: String {
        switch self {
        case .username:
            "Enter your username"
        case .password:
            "Enter your password"
        }
    }
    
    var imageName: String {
        switch self {
        case .username:
            "person"
        case .password:
            "lock"
        }
    }
}

// TODO: UI refines
struct LoginView: View {
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Text("Access Account")
            
            Text("Log in to access your personalized JoyPet")
            
            LoginTextField(type: .username, text: $username)
            
            LoginTextField(type: .password, text: $password)
            
            Button(action: {
                // TODO: Retrieve password
            }) {
                HStack {
                    Text("Forget your password?")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Button(action: {
                // TODO: Log in
            }) {
                Text("Log in")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Button(action: {
                // TODO: Sign up
            }) {
                Text("Sign up")
            }
        }
        .padding(.horizontal, 20)
    }
}

private struct LoginTextField: View {
    var type: TextFieldType
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: type.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            
            switch type {
            case .username:
                TextField(type.placeholder, text: $text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            case .password:
                SecureField(type.placeholder, text: $text)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LoginView()
}
