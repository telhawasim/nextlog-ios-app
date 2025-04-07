//
//  GetProfileDetailResponseModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 07/04/2025.
//

struct GetProfileDetailResponseModel: Codable {
    var id, employeeID, title, createdAt: String?
    var basicInformation: BasicInformation?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case employeeID = "employee_id"
        case title
        case createdAt = "created_at"
        case basicInformation = "basic_information"
    }
}

// MARK: - BasicInformation
struct BasicInformation: Codable {
    var name: String?
    var designation: DesignationModel?
    var email, phone: String?
    var gitLink, linkedInLink: String?
    var summary: String?

    enum CodingKeys: String, CodingKey {
        case name, designation, email, phone
        case gitLink = "git_link"
        case linkedInLink = "linked_in_link"
        case summary
    }
}
