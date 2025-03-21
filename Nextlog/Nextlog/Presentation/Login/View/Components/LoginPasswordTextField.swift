//
//  LoginPasswordTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct LoginPasswordTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Environment
    @Environment(\.colorScheme) var colorScheme
    //State
    @State private var isShowPassword: Bool = false
    //Binding
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text("Password")
                .font(.getSemibold(.h16))
            // TextField and Show Password Button
            HStack {
                // Check whether to show or hide password textfield
                if (self.isShowPassword) {
                    // Textfield
                    TextField(text: self.$value, label: {
                        Text("Please enter password")
                    })
                    .font(.getRegular(.h16))
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                } else {
                    SecureField(text: self.$value, label: {
                        Text("Please enter password")
                    })
                    .font(.getRegular(.h16))
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                }
                // Spacer
                Spacer()
                // Show and Hide Password
                Button(action: {
                    self.isShowPassword.toggle()
                }, label: {
                    Image(self.isShowPassword ? ImageEnum.icShowPassword.rawValue : ImageEnum.icHidePassword.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(self.colorScheme == .dark ? Color.white : Color.black)
                        .frame(width: 24, height: 24)
                })
            }
            // Divider
            Divider()
        }
    }
}

#Preview {
    LoginPasswordTextField(
        value: Binding.constant("")
    )
}
