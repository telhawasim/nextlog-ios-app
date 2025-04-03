//
//  AddEmployeeDesignationTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeeDesignationTextField: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var value: String
    //Normal
    var isDesignation: Bool = true
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(alignment: .leading, spacing: 8) {
            // Title and Aesterisk
            HStack(alignment: .lastTextBaseline, spacing: 3) {
                // Title
                Text(self.isDesignation ? "Designation" : "Department")
                    .font(.getSemibold(.h16))
                // Aesterisk
                Text("*")
                    .foregroundStyle(Color.red)
            }
            Button(action: {
                self.onPress?()
            }, label: {
                HStack {
                    // Text
                    Text(self.value == "" ? (self.isDesignation ? "Select Designation" : "Select Department") : self.value)
                    .font(.getRegular(.h16))
                    .foregroundStyle(self.value == "" ? Color.gray.opacity(0.5) : Color.black)
                    // Spacer
                    Spacer()
                    //Icon
                    Image(systemName: ImageEnum.icChevronDown.rawValue)
                        .foregroundStyle(Color.black)
                }
            })
            // Divider
            Divider()
        }
    }
}

#Preview {
    AddEmployeeDesignationTextField(
        value: Binding.constant("")
    )
}
