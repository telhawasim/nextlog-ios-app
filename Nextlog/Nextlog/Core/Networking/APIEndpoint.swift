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
    case login(email: String, password: String? = "", emp_id: Int? = 0, role: String)
    // EMPLOYEE
    case getEmployees(page: Int = 1, limit: Int = 10)
    case getEmployeeDetails(id: String)
    case addEmployee
    case deleteEmployee(id: String)
    // DESIGNATION
    case getDesignations
    // DEPARTMENT
    case getDepartments
    // PROFILE
    case addProfile(id: Int, name: String)
    
    //MARK: - URL -
    var url: String {
        switch self {
        case .login:
            return APIEndpoint.baseURL + "login"
        case .getEmployees:
            return APIEndpoint.baseURL + "employee/all"
        case .getEmployeeDetails(let id):
            return APIEndpoint.baseURL + "employee/detail/\(id)"
        case .addEmployee:
            return APIEndpoint.baseURL + "employee/add"
        case .deleteEmployee(let id):
            return APIEndpoint.baseURL + "employee/delete/\(id)"
        case .getDesignations:
            return APIEndpoint.baseURL + "designation/all"
        case .getDepartments:
            return APIEndpoint.baseURL + "department/all"
        case .addProfile:
            return APIEndpoint.baseURL + "profile/add"
        }
    }
    
    //MARK: - METHOD -
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .getEmployees:
            return .get
        case .getEmployeeDetails:
            return .get
        case .addEmployee:
            return .post
        case .deleteEmployee:
            return .delete
        case .getDesignations:
            return .get
        case .getDepartments:
            return .get
        case .addProfile:
            return .post
        }
    }
    
    //MARK: - HEADER -
    var headers: HTTPHeaders {
        switch self {
        case .addEmployee:
            return HTTPHeaders([
                HTTPHeader(name: "Content-Type", value: "multipart/form-data"),
                HTTPHeader(name: "Accept", value: "application/json")
            ])
        default:
            return HTTPHeaders([
                HTTPHeader(name: "Content-Type", value: "application/json"),
                HTTPHeader(name: "Accept", value: "application/json")
            ])
        }
    }
    
    //MARK: - PARAMETERS -
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password, let emp_id, let role):
            if role == "admin" {
                return [
                    "email": email,
                    "password": password ?? "",
                    "role": role
                ]
            } else {
                return [
                    "email": email,
                    "emp_id": emp_id ?? 0,
                    "role": role
                ]
            }
        case .getEmployees:
            return nil
        case .getEmployeeDetails:
            return nil
        case .addEmployee:
            return nil
        case .deleteEmployee:
            return nil
        case .getDesignations:
            return nil
        case .getDepartments:
            return nil
        case .addProfile(let id, let name):
            return [
                "id": id,
                "name": name
            ]
        }
    }
}
