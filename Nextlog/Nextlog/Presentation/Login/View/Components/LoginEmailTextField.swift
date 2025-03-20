//
//  LoginEmailTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct LoginEmailTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 10) {
            // Title
            Text("Email")
                .font(.getSemibold(.h16))
            // Textfield
            TextField(text: self.$value, label: {
                Text("Please enter email")
            })
            .font(.getRegular(.h16))
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            // Divider
            Divider()
        }
    }
}

#Preview {
    LoginEmailTextField(
        value: Binding.constant("")
    )
}
