//
//  ExperienceInfoUserModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

struct ExperienceInfoUserModel {
    var companyName: String
    var startDate: String
    var endDate: String
    var description: String
    
    //MARK: - SET INITIAL DATA -
    static func setInitialData() -> ExperienceInfoUserModel {
        return ExperienceInfoUserModel(
            companyName: "", startDate: "", endDate: "", description: ""
        )
    }
}
