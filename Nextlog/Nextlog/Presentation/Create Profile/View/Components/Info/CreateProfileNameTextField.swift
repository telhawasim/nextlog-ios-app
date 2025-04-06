//
//  CreateProfileEmailTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileNameTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    
    //MARK: - VIES -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 10) {
            // Title and Asterisk
            HStack(spacing: 3) {
                // Title
                Text("Name")
                    .font(.getSemibold(.h16))
                // Asterisk
                Text("*")
                    .font(.getSemibold(.h16))
                    .foregroundStyle(Color.red)
            }
            // TextField
            TextField(text: self.$value, label: {
                Text("Enter name")
            })
            .font(.getRegular(.h16))
            // Divider
            Divider()
        }
    }
}

#Preview {
    CreateProfileNameTextField(
        value: Binding.constant("")
    )
}
