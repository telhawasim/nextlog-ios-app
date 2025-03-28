//
//  GetEmployeeResponse.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import Foundation

//MARK: - GetAllEmployeeResponse -
struct GetAllEmployeeResponse: Codable {
    var message: String?
    var status: Int?
    var employees: [EmployeeListRowResponse]?
    var current_page: Int?
    var limit: Int?
    var total_count: Int?
    var total_pages: Int?
}

//MARK: - GetEmployeeDetailResponse -
struct GetEmployeeDetailResponse: Codable {
    var message: String
    var status: Int
    var employee: EmployeeResponse?
}

//MARK: - EmployeeListRowResponse -
struct EmployeeListRowResponse: Codable {
    var id: String?
    var name: String?
    var designation: DesignationModel?
    var email: String?
//    var avatar: String?
}

//MARK: - EmployeeResponse -
struct EmployeeResponse: Codable {
    var name: String?
    var email: String?
    var id: String?
    var designation: DesignationModel?
    var department: DesignationModel?
    var avatar: String?
    var created_at: String?
    var updated_at: String?
    var emp_id: Int?
    var dob: String?
    var date_of_joining: String?
    var phone: String?
//    var profiles: [GetProfileResponse]?
}

struct DesignationModel: Codable {
    var id: String?
    var name: String?
}
