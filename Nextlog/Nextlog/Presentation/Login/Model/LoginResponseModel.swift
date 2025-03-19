//
//  LoginResponseModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import Foundation

//MARK: - LoginResponseModel -
struct LoginResponseModel: BaseServerModel {
    var error: Bool?
    var reason: String?
    var message: String
    var status: Int
    var data: LoginUserResponse?
    var accessToken: String?
    
    private enum CodingKeys: String, CodingKey {
        case message
        case status
        case data
        case accessToken = "access_token"
    }
}

//MARK: - LOGIN USER RESPONSE -
struct LoginUserResponse: Codable {
    var id: String?
    var email: String?
    var role: String?
}
