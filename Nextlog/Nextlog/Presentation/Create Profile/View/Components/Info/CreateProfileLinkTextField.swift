//
//  CreateProfileLinkTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileLinkTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    //Normal
    var isGit: Bool = true
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 10) {
            // Title
            Text(self.isGit ? "Git / Bit Bucket" : "LinkedIn")
                .font(.getSemibold(.h16))
            // TextField
            TextField(text: self.$value, label: {
                Text(self.isGit ? "Enter git/bit bucket url" : "Enter linkedin url")
            })
            .font(.getRegular(.h16))
            // Divider
            Divider()
        }
    }
}

#Preview {
    CreateProfileLinkTextField(
        value: Binding.constant("")
    )
}
