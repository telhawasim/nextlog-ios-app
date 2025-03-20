//
//  APIService.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Foundation

enum APIService: APIEndpoint {
    case loginAsAdmin(email: String, password: String)
    case addEmployee(name: String, email: String)
    
    //MARK: - BASE URL -
    var baseURL: URL {
        return URL(string: "http://192.168.31.221:8080/")!
    }
    
    //MARK: - PATH -
    var path: String {
        switch self {
        case .loginAsAdmin:
            return "admin/login"
        case .addEmployee:
            return "employee/add"
        }
    }
    
    //MARK: - METHOD -
    var method: HTTPMethod {
        switch self {
        case .loginAsAdmin:
            return .POST
        case .addEmployee:
            return .POST
        }
    }
    
    //MARK: - HEADERS -
    var headers: [String : String]? {
        switch self {
        case .addEmployee:
            return [
                "Content-Type": "multipart/form-data",
                "Authorization": "Bearer \(AppStorage.accessToken ?? "")"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(AppStorage.accessToken ?? "")"
            ]
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
        case .addEmployee(let name, let email):
            return [
                "name": name,
                "email": email
            ]
        }
    }
}
