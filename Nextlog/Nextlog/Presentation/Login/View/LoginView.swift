//
//  LoginView.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - PROPERTIES -
    
    //State
    @State private var isAdmin: Bool = true
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var id: String = ""
    
    //MARK: - VIEWS -
    var body: some View {
        //Parent View
        VStack(alignment: .leading, spacing: 0) {
            // Logo
            Image(ImageEnum.icLogo.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .foregroundStyle(Color.black)
            // Title and Description
            VStack(alignment: .leading, spacing: 8) {
                Text("Login")
                    .font(.getBold(.h32))
                Text("Welcome back. Login to continue.")
                    .font(.getMedium(.h16))
            }
            .padding(.top, 34)
            // TextFields
            VStack(spacing: 35) {
                // Email Textfield
                LoginEmailTextField(value: self.$email)
                // Check which textfield to show according to user type
                if (self.isAdmin) {
                    // Password Textfield
                    LoginPasswordTextField(value: self.$password)
                } else {
                    // ID Textfield
                    LoginIDTextField(value: self.$id)
                }
            }
            .padding(.top, 80)
            // Spacer
            Spacer()
            // Login and Continue as Button
            VStack(spacing: 12) {
                // Login Button
                AppCustomButton(
                    title: "Log In",
                    onPress: {
                        
                    }
                )
                // Continue Button
                Button(action: {
                    self.isAdmin.toggle()
                }, label: {
                    Text(self.handleContinueButtonTitle())
                        .font(.getSemibold(.h16))
                        .foregroundStyle(Color.black)
                })
            }
            // Spacer
            Spacer()
        }
        .padding(.top, 116)
        .padding(.horizontal, 16)
        .animation(.default, value: self.isAdmin)
    }
}

//MARK: - FUNCTIONS -
extension LoginView {
    
    //MARK: - HANDLE CONTINUE BUTTON TITLE -
    private func handleContinueButtonTitle() -> String {
        if (self.isAdmin) {
            return "Continue as Employee"
        } else {
            return "Continue as Admin"
        }
    }
}

#Preview {
    LoginView()
}
