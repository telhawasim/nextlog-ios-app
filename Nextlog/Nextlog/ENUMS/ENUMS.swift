//
//  ENUMS.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import Foundation

enum ScreenType: Hashable {
    case login(LoginView.ViewModel)
    case tabbar(TabbarView.ViewModel)
    case employeeDetails(EmployeeDetailView.ViewModel)
    case addEmployee(AddEmployeeView.ViewModel)
}

enum FontSize: CGFloat {
    case h14 = 14
    case h16 = 16
    case h18 = 18
    case h20 = 20
    case h22 = 22
    case h24 = 24
    case h26 = 26
    case h28 = 28
    case h30 = 30
    case h32 = 32
    case h40 = 40
}

enum EmptyStateType {
    case previousExperience
    case certificate
    case employeeListing
    case awards
    case technicalSkills
    case nonTechnicalSkills
    case tools
    case projects
}

enum TabbarType {
    case home
    case employees
    case logout
    
    //MARK: - GET IMAGE -
    var getImage: String {
        switch self {
        case .home:
            return ImageEnum.icTabbarHome.rawValue
        case .employees:
            return ImageEnum.icBrief.rawValue
        case .logout:
            return ImageEnum.icTabbarLogout.rawValue
        }
    }
}
