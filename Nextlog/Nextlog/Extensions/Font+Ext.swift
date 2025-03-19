//
//  Font+Ext.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import SwiftUI

extension Font {
    
    //MARK: - GET REGULAR -
    static func getRegular(_ size: FontSize = .h14) -> Font {
        return Font.custom("Gilroy-Regular", size: size.rawValue)
    }
    
    //MARK: - GET MEDIUM -
    static func getMedium(_ size: FontSize = .h14) -> Font {
        return Font.custom("Gilroy-Medium", size: size.rawValue)
    }
    
    //MARK: - GET SEMIBOLD -
    static func getSemibold(_ size: FontSize = .h14) -> Font {
        return Font.custom("Gilroy-SemiBold", size: size.rawValue)
    }
    
    //MARK: - GET BOLD -
    static func getBold(_ size: FontSize = .h14) -> Font {
        return Font.custom("Gilroy-Bold", size: size.rawValue)
    }
}
