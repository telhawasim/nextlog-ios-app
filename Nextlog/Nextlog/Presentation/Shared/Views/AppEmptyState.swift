//
//  AppEmptyState.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct AppEmptyState: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var emptyState: EmptyStateType
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(spacing: 0) {
            // Logo
            Image(ImageEnum.icEmployeeEmptyState.rawValue)
                .foregroundStyle(Color.color808080)
            // Title and Description
            VStack(spacing: 8) {
                Text(self.handleTitle())
                    .font(.getBold(.h22))
                Text(self.handleDescription())
                    .font(.getRegular())
            }
            .padding(.top, 28)
            // Only show Button if empty state is not 'employeeListing'
            if (self.emptyState != .employeeListing) {
                // Add Here Button
                Button(action: {
                    self.onPress?()
                }, label: {
                    Text("Add Here")
                        .font(.getBold())
                        .foregroundStyle(Color.white)
                        .frame(width: 130, height: 40)
                        .background(Color.color808080)
                        .clipShape(Capsule())
                })
                .padding(.top, 32)
            }
        }
        .padding(.vertical, 30)
    }
}

//MARK: - FUNCTIONS -
extension AppEmptyState {
    
    //MARK: - HANDLE TITLE -
    func handleTitle() -> String {
        switch self.emptyState {
        case .employeeListing:
            return "No Data Available"
        default:
            return ""
        }
    }
    
    //MARK: - HANDLE DESCRIPTION -
    func handleDescription() -> String {
        switch self.emptyState {
        case .employeeListing:
            return "The information is not available for the moment"
        default:
            return ""
        }
    }
}

#Preview {
    AppEmptyState(
        emptyState: .employeeListing
    )
}
