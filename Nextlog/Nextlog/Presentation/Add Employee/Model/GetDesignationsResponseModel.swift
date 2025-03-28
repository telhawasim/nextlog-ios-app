//
//  GetDesignationsModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 28/03/2025.
//

struct GetDesignationsResponseModel: Codable {
    var designations: [DesignationModel]?
    var departments: [DesignationModel]?
}
