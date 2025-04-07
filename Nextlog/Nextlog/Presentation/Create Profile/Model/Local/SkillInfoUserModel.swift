//
//  SkillInfoUserModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

struct SkillInfoUserModel {
    var name: String
    
    //MARK: - SET INITIAL DATA -
    static func setInitialData() -> SkillInfoUserModel {
        return SkillInfoUserModel(name: "")
    }
}
