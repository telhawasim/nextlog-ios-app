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
    
    //MARK: - SET INITIAL DATA FOR CURRENT EXPERIENCE -
    static func setInitialDataForCurrentExperience() -> ExperienceInfoUserModel {
        return ExperienceInfoUserModel(
            companyName: "NextBridge", startDate: "", endDate: "Present", description: ""
        )
    }
}
