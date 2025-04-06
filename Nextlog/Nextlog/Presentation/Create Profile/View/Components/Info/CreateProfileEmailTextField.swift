//
//  CreateProfileEmailTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileEmailTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 10) {
            // Title and Asterisk
            HStack(spacing: 3) {
                // Title
                Text("Email Address")
                    .font(.getSemibold(.h16))
                // Asterisk
                Text("*")
                    .font(.getSemibold(.h16))
                    .foregroundStyle(Color.red)
            }
            // TextField
            TextField(text: self.$value, label: {
                Text("Enter email address")
            })
            .font(.getRegular(.h16))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .keyboardType(.emailAddress)
            // Divider
            Divider()
        }
    }
}

#Preview {
    CreateProfileEmailTextField(
        value: Binding.constant("")
    )
}
