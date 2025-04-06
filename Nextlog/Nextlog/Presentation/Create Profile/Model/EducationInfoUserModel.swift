//
//  EducationInfoUserModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

struct EducationInfoUserModel {
    var degree: String
    var institution: String
    var startDate: String
    var endDate: String
    
    //MARK: - SET INITIAL DATA -
    static func setIntialData() -> EducationInfoUserModel {
        return EducationInfoUserModel(
            degree: "", institution: "", startDate: "", endDate: ""
        )
    }
}
