//
//  LoginIDTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

struct LoginIDTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 11) {
            // Title
            Text("ID")
                .font(.getSemibold(.h16))
            // Textfield
            TextField(text: self.$value, label: {
                Text("Please enter ID")
            })
            .font(.getRegular(.h16))
            // Divider
            Divider()
        }
    }
}

#Preview {
    LoginIDTextField(
        value: Binding.constant("3251")
    )
}
