//
//  APIService.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Foundation

enum APIService: APIEndpoint {
    case loginAsAdmin(email: String, password: String)
    case getAllEmployees(page: Int?, limit: Int?)
    case getEmployeeDetail(id: String)
    case addEmployee(name: String, email: String)
    
    //MARK: - BASE URL -
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8080/")!
    }
    
    //MARK: - PATH -
    var path: String {
        switch self {
        case .loginAsAdmin:
            return "admin/login"
        case .getAllEmployees(let page, let limit):
            var components = URLComponents()
            
            components.path = "employee/getAll"
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page ?? 1)"),
                URLQueryItem(name: "limit", value: "\(limit ?? 9)")
            ]
            return components.url?.path ?? "/employee/getAll"
        case .getEmployeeDetail(let id):
            return "employee/detail/\(id)"
        case .addEmployee:
            return "employee/add"
        }
    }
    
    //MARK: - METHOD -
    var method: HTTPMethod {
        switch self {
        case .loginAsAdmin:
            return .POST
        case .getAllEmployees:
            return .GET
        case .getEmployeeDetail:
            return .GET
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
        case .getAllEmployees:
            return nil
        case .getEmployeeDetail:
            return nil
        case .addEmployee(let name, let email):
            return [
                "name": name,
                "email": email
            ]
        }
    }
}
