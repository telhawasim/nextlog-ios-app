//
//  AddEmployeeDobTextField.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AddEmployeeDobTextField: View {
    
    //MARK: - PROPERTIES -
    
    @Binding var value: String
    var isDOB: Bool = true
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(alignment: .leading, spacing: 5) {
            // Title and Aesterisk
            HStack(alignment: .lastTextBaseline, spacing: 3) {
                // Title
                Text(self.isDOB ? "Date of Birth" : "Date of Joining")
                    .font(.getSemibold(.h16))
                // Aesterisk
                Text("*")
                    .foregroundStyle(Color.red)
            }
            // Text and Logo
            HStack {
                // Text
                Text(self.value == "" ? (self.isDOB ? "Select date of birth" : "Select date of joining") : self.value)
                .font(.getRegular(.h16))
                .foregroundStyle(self.value == "" ? Color.gray.opacity(0.5) : Color.black)
                // Spacer
                Spacer()
                // Logo
                ZStack {
                    // Background
                    Circle()
                        .frame(width: 24)
                        .foregroundStyle(Color.color808080)
                    // Image
                    Image(ImageEnum.icCalendar.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                        .foregroundStyle(Color.white)
                }
            }
            // Divider
            Divider()
        }
    }
}

#Preview {
    AddEmployeeDobTextField(
        value: Binding.constant("")
    )
}
