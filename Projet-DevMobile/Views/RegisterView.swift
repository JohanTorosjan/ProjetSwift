import SwiftUI
import Foundation

struct RegisterView: View {
    @State private var prenom = ""
    @State private var nom = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("First Name", text: $prenom)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Last Name", text: $nom)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                // handle register button tap
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}
