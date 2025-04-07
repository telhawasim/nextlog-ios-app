//
//  BasicInfoUserModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

struct BasicInfoUserModel {
    var name: String
    var designation: String
    var email: String
    var phone: String
    var github: String
    var linkedin: String
    var summary: String
    
    //MARK: - SET INTIAL DATA -
    static func setInitialData() -> BasicInfoUserModel {
        return .init(
            name: "",
            designation: "",
            email: "",
            phone: "",
            github: "",
            linkedin: "",
            summary: ""
        )
    }
}
