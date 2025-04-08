//
//  LoginRequestModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 08/04/2025.
//

struct LoginRequestModel: Encodable {
    var role: String
    var email: String
    var password: String?
    var emp_id: Int?
}
