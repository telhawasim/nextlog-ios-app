//
//  AwardsInfoUserModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

struct AwardsInfoUserModel {
    var title: String
    var description: String
    
    //MARK: - SET INITIAL DATA -
    static func setInitialData() -> AwardsInfoUserModel {
        return AwardsInfoUserModel(title: "", description: "")
    }
}
