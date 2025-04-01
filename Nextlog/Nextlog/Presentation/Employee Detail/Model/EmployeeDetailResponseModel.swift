//
//  EmployeeDetailResponseModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 01/04/2025.
//

//MARK: - GetEmployeeDetailResponse -
struct GetEmployeeDetailResponse: Codable {
    var message: String
    var status: Int
    var employee: EmployeeDetailModel?
}

//MARK: - EmployeeDetailModel -
struct EmployeeDetailModel: Codable {
    var id, name, email: String?
    var empID: Int?
    var designation, department: DesignationModel?
    var avatar, createdAt: String?
    var profiles: [Profile]?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case empID = "emp_id"
        case designation, department, avatar
        case createdAt = "created_at"
        case profiles
    }
}

// MARK: - Profile -
struct Profile: Codable {
    var id, title, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
    }
}
