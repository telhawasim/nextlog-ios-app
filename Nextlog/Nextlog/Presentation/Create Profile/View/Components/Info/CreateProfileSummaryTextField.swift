//
//  CreateProfileSummaryTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileSummaryTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    //Normal
    var placeholder: String = ""
    
    //MARK: - VIEWS -
    var body: some View {
        ZStack {
            TextField(text: self.$value, axis: .vertical, label: {
                Text(self.placeholder)
            })
            .padding()
            .font(.getRegular(.h16))
            .lineLimit(6...6)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(Color.gray.opacity(0.3))
        )
        .padding(.all, 1)
    }
}

#Preview {
    CreateProfileSummaryTextField(
        value: Binding.constant("")
    )
}
