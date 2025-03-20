//
//  AddEmployeePhoneTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeePhoneTextField: View {
    
    //MARK: - PROPERTIES -
    
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(alignment: .leading, spacing: 8) {
            // Title and Aesterisk
            HStack(alignment: .lastTextBaseline, spacing: 3) {
                // Title
                Text("Phone Number")
                    .font(.getSemibold(.h16))
                // Aesterisk
                Text("*")
                    .foregroundStyle(Color.red)
            }
            // Country code and Phone
            HStack(spacing: 10) {
                // Country Code
                Text("+92")
                    .font(.getRegular(.h16))
                // Phone Textfield
                TextField(text: self.$value, label: {
                    Text("Enter phone number")
                })
                .font(.getRegular(.h16))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.numberPad)
            }
            // Divider
            Divider()
        }
    }
}

#Preview {
    AddEmployeePhoneTextField(
        value: Binding.constant("")
    )
}
