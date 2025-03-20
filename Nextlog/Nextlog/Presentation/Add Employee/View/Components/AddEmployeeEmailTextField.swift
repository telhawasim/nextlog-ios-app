//
//  AddEmployeeEmailTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeeEmailTextField: View {
    
    //MARK: - PROPERTIES -
    
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(alignment: .leading, spacing: 8) {
            // Title and Aesterisk
            HStack(alignment: .lastTextBaseline, spacing: 3) {
                // Title
                Text("Email Address")
                    .font(.getSemibold(.h16))
                // Aesterisk
                Text("*")
                    .foregroundStyle(Color.red)
            }
            // Textfield
            TextField(text: self.$value, label: {
                Text("Enter email address")
            })
            .font(.getRegular(.h16))
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            // Divider
            Divider()
        }
    }
}

#Preview {
    AddEmployeeEmailTextField(
        value: Binding.constant("")
    )
}
