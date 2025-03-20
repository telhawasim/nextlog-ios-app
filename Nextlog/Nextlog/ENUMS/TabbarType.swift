//
//  TabbarType.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

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
