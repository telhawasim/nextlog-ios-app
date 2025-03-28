//
//  LoginView.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: - PROPERTIES -
    
    //Environment
    @Environment(\.colorScheme) var colorScheme
    //EnvironmentObject
    @EnvironmentObject var router: Routing
    //StateObject
    @StateObject var viewModel: LoginView.ViewModel
    
    //MARK: - VIEWS -
    var body: some View {
        //Parent View
        VStack(alignment: .leading, spacing: 0) {
            // Logo
            Image(ImageEnum.icLogo.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .foregroundStyle(self.colorScheme == .dark ? Color.white : Color.black)
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
                LoginEmailTextField(value: self.$viewModel.email)
                // Check which textfield to show according to user type
                if (self.viewModel.isAdmin) {
                    // Password Textfield
                    LoginPasswordTextField(value: self.$viewModel.password)
                } else {
                    // ID Textfield
                    LoginIDTextField(value: self.$viewModel.id)
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
                        if (self.viewModel.isAdmin) {
                            if (self.viewModel.validationForLoginAsAdmin()) {
                                self.viewModel.loginAsAdmin { isSuccess in
                                    if (isSuccess) {
                                        self.navigateToTabbarScreen()
                                    }
                                }
                            }
                        } else {
                            
                        }
                    }
                )
                // Continue Button
                Button(action: {
                    self.viewModel.isAdmin.toggle()
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
        .animation(.default, value: self.viewModel.isAdmin)
        .alert(isPresented: self.$viewModel.isShowErrorAlert) {
            Alert(title: Text("Error"), message: Text(self.viewModel.errorMessage))
        }
    }
}

//MARK: - FUNCTIONS -
extension LoginView {
    
    //MARK: - HANDLE CONTINUE BUTTON TITLE -
    private func handleContinueButtonTitle() -> String {
        if (self.viewModel.isAdmin) {
            return "Continue as Employee"
        } else {
            return "Continue as Admin"
        }
    }
    
    //MARK: - NAVIGATE TO TABBAR SCREEN -
    private func navigateToTabbarScreen() {
        let viewModel = TabbarView.ViewModel()
        self.router.push(.tabbar(viewModel))
    }
}

#Preview {
    LoginView(
        viewModel: LoginView.ViewModel()
    )
}
