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
            Image(self.handleImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .foregroundStyle(Color.color808080)
            // Title and Description
            VStack(spacing: 8) {
                Text(self.handleTitle())
                    .font(.getBold(.h22))
                    .multilineTextAlignment(.center)
                Text(self.handleDescription())
                    .font(.getRegular())
            }
            .padding(.top, 20)
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
    
    //MARK: - HANDLE IMAGE -
    func handleImage() -> String {
        switch self.emptyState {
        case .employeeListing:
            return ImageEnum.icEmployeeEmptyState.rawValue
        default:
            return ImageEnum.icAddSection.rawValue
        }
    }
    
    //MARK: - HANDLE TITLE -
    func handleTitle() -> String {
        switch self.emptyState {
        case .employeeListing:
            return "No Data Available"
        case .previousExperience:
            return "Want to add past experience?"
        case .certificate:
            return "Want to add trainings & certifications?"
        case .awards:
            return "Want to add awards & honors?"
        case .technicalSkills:
            return "Want to add technical skills?"
        case .nonTechnicalSkills:
            return "Want to add non technical skills?"
        case .tools:
            return "Want to add tools?"
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
            return "Click below to add section here"
        }
    }
}

#Preview {
    AppEmptyState(
        emptyState: .employeeListing
    )
}
