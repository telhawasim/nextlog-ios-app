//
//  EmployeeDetailOptionsView.swift
//  Nextlog
//
//  Created by Telha Wasim on 08/04/2025.
//

import SwiftUI

struct EmployeeDetailOptionsView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var index: Int
    //Normal
    var onPressEdit: (() -> Void)?
    var onPressDelete: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        VStack(spacing: 10) {
            // Edit Profile
            EmployeeDetailOptionButtonView(
                title: "Edit Profile",
                image: ImageEnum.icEditProfile.rawValue,
                onPress: {
                    self.onPressEdit?()
                }
            )
            // Delete Profile
            EmployeeDetailOptionButtonView(
                title: "Delete Profile",
                image: ImageEnum.icDelete.rawValue,
                onPress: {
                    self.onPressDelete?()
                }
            )
        }
        .padding(.horizontal, 16)
        .padding(.top, 30)
        .background(Color.white)
    }
}

#Preview {
    EmployeeDetailOptionsView(
        index: Binding.constant(1)
    )
}
