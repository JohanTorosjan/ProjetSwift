import SwiftUI
import Foundation

struct ContentView: View {
    @State private var isShowingLogin = true
    
    var body: some View {
        if isShowingLogin {
            LoginView()
            VStack {
                Spacer()
                Button("Don't have an account? Create new account.") {
                    isShowingLogin = false
                }
                .padding()
            }
        } else {
            RegisterView()
            VStack {
                Spacer()
                Button("Already have an account? Sign in.") {
                    isShowingLogin = true
                }
                .padding()
            }
        }
    }
}
