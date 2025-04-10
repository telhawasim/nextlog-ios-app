//
//  APIEndpoint.swift
//  Nextlog
//
//  Created by Telha Wasim on 28/03/2025.
//

import Alamofire

enum APIEndpoint {
    
    static let baseURL = "http://127.0.0.1:8000/"
    
    // AUTHENTICATION
    case login
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
    case getProfileDetail(id: String)
    case addProfile
    case deleteProfile(id: String)
    case addBasicInformation(id: String)
    case addExperience(id: String)
    case addQualification(id: String)
    case addSkill(id: String)
    
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
        case .getProfileDetail(let id):
            return APIEndpoint.baseURL + "profile/detail/\(id)"
        case .addProfile:
            return APIEndpoint.baseURL + "profile/add"
        case .deleteProfile(let id):
            return APIEndpoint.baseURL + "profile/delete/\(id)"
        case .addBasicInformation(let id):
            return APIEndpoint.baseURL + "profile/\(id)/basic-information"
        case .addExperience(let id):
            return APIEndpoint.baseURL + "profile/\(id)/experience"
        case .addQualification(let id):
            return APIEndpoint.baseURL + "profile/\(id)/qualification"
        case .addSkill(let id):
            return APIEndpoint.baseURL + "profile/\(id)/skill"
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
        case .getProfileDetail:
            return .get
        case .addProfile:
            return .post
        case .deleteProfile:
            return .delete
        case .addBasicInformation:
            return .put
        case .addExperience:
            return .put
        case .addQualification:
            return .put
        case .addSkill:
            return .put
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
}
