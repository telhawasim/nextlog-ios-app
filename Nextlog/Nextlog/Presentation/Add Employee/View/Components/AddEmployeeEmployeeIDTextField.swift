//
//  AddEmployeeEmployeeIDTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 02/04/2025.
//

import SwiftUI

struct AddEmployeeEmployeeIDTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(alignment: .leading, spacing: 8) {
            // Title and Aesterisk
            HStack(alignment: .lastTextBaseline, spacing: 3) {
                // Title
                Text("Emp ID")
                    .font(.getSemibold(.h16))
                // Aesterisk
                Text("*")
                    .foregroundStyle(Color.red)
            }
            // EMP ID
            TextField(text: self.$value, label: {
                Text("Enter emp id")
            })
            .font(.getRegular(.h16))
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.numberPad)
            // Divider
            Divider()
        }
    }
}

#Preview {
    AddEmployeeEmployeeIDTextField(
        value: Binding.constant("")
    )
}
