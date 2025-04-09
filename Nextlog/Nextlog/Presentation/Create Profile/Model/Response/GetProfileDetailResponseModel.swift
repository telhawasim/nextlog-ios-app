//
//  GetProfileDetailResponseModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 07/04/2025.
//

struct GetProfileDetailResponseModel: Codable {
    var id, employeeID, title, createdAt: String?
    var basicInformation: BasicInformation?
    var experience: ExperienceResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeID = "employee_id"
        case title
        case createdAt = "created_at"
        case basicInformation = "basic_information"
        case experience
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

struct ExperienceResponse: Codable {
    var currentExperience: Experience?
    var previousExperience: [Experience]?
    
    private enum CodingKeys : String, CodingKey {
        case currentExperience = "current_experience"
        case previousExperience = "previous_experience"
    }
}

//MARK: - Experience
struct Experience: Codable {
    var company: String?
    var designation: DesignationModel?
    var startDate: String?
    var endDate: String?
    var description: String?
    
    private enum CodingKeys : String, CodingKey {
        case company
        case designation
        case startDate = "start_date"
        case endDate = "end_date"
        case description
    }
}
