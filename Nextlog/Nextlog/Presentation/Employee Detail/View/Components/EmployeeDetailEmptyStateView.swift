//
//  EmployeeDetailEmptyStateView.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct EmployeeDetailEmptyStateView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var role: String
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(spacing: 0) {
            // Title and Description
            VStack(spacing: 8) {
                // Title
                Text(self.handleTitle())
                    .font(.getSemibold(.h20))
                // Description
                Text(self.handleDescription())
                    .font(.getRegular(.h16))
            }
            // In case user is logged in as 'admin'
            if (self.role == RoleType.admin.rawValue) {
                // Create Profile Button
                AppCustomButton(
                    title: "Create Profile",
                    onPress: {
                        self.onPress?()
                    }
                )
                .frame(width: 170)
                .padding(.top, 35)
            }
        }
    }
}

//MARK: - FUNCTIONS -
extension EmployeeDetailEmptyStateView {
    
    //MARK: - HANDLE TITLE -
    private func handleTitle() -> String {
        if (self.role == RoleType.admin.rawValue) {
            return "You have added this employee"
        } else {
            return "You are added by the admin"
        }
    }
    
    //MARK: - HANDLE DESCRIPTION -
    private func handleDescription() -> String {
        if (self.role == RoleType.admin.rawValue) {
            return "Click below to create profile"
        } else {
            return "Ask admin to create profile"
        }
    }
}

#Preview {
    EmployeeDetailEmptyStateView(
        role: "admin"
    )
}
