//
//  APIEndpoint.swift
//  Nextlog
//
//  Created by Telha Wasim on 28/03/2025.
//

import Alamofire

enum APIEndpoint {
    
    private static let baseURL = "http://127.0.0.1:8000/"
    
    // AUTHENTICATION
    case login(email: String, password: String, role: String)
    // EMPLOYEE
    case getEmployees(page: Int = 1, limit: Int = 10)
    
    //MARK: - URL -
    var url: String {
        switch self {
        case .login:
            return APIEndpoint.baseURL + "login"
        case .getEmployees:
            return APIEndpoint.baseURL + "employee/all"
        }
    }
    
    //MARK: - METHOD -
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .getEmployees:
            return .get
        }
    }
    
    //MARK: - HEADER -
    var headers: HTTPHeaders {
        return HTTPHeaders([
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Accept", value: "application/json")
        ])
    }
    
    //MARK: - PARAMETERS -
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password, let role):
            return [
                "email": email,
                "password": password,
                "role": role
            ]
        case .getEmployees:
            return nil
        }
    }
}
