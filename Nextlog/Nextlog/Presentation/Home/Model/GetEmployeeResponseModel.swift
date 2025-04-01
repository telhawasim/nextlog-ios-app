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

//MARK: - EmployeeListRowResponse -
struct EmployeeListRowResponse: Codable {
    var id: String?
    var name: String?
    var designation: DesignationModel?
    var email: String?
    var avatar: String?
}

struct DesignationModel: Codable {
    var id: String?
    var name: String?
}
