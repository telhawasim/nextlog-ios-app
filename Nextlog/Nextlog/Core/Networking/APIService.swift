//
//  APIService.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Foundation

enum APIService: APIEndpoint {
    case loginAsAdmin(email: String, password: String)
    
    //MARK: - BASE URL -
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8080/")!
    }
    
    //MARK: - PATH -
    var path: String {
        switch self {
        case .loginAsAdmin:
            return "admin/login"
        }
    }
    
    //MARK: - METHOD -
    var method: HTTPMethod {
        switch self {
        case .loginAsAdmin:
            return .POST
        }
    }
    
    //MARK: - HEADERS -
    var headers: [String : String]? {
        switch self {
        case .loginAsAdmin:
            return ["Content-Type": "application/json"]
        }
    }
    
    //MARK: - PARAMETERS -
    var parameters: [String : Any]? {
        switch self {
        case .loginAsAdmin(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        }
    }
}
