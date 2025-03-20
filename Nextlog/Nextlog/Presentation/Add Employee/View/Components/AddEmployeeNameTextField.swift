//
//  AddEmployeeNameTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeeNameTextField: View {
    
    //MARK: - PROPERTIES -
    
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(alignment: .leading, spacing: 8) {
            // Title and Aesterisk
            HStack(alignment: .lastTextBaseline, spacing: 3) {
                // Title
                Text("Name")
                    .font(.getSemibold(.h16))
                // Aesterisk
                Text("*")
                    .foregroundStyle(Color.red)
            }
            // Textfield
            TextField(text: self.$value, label: {
                Text("Enter name")
            })
            .font(.getRegular(.h16))
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.words)
            // Divider
            Divider()
        }
    }
}

#Preview {
    AddEmployeeNameTextField(
        value: Binding.constant("")
    )
}
