//
//  UserRepository.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Combine

protocol UserRepository {
    func loginAsAdmin(email: String, password: String) -> AnyPublisher<LoginResponseModel?, APIError>
    func getAllEmployees(page: Int?, limit: Int?) -> AnyPublisher<GetAllEmployeeResponse?, APIError>
    func getEmployeeDetail(id: String) -> AnyPublisher<GetEmployeeDetailResponse?, APIError>
}

class UserService: UserRepository {
    let apiClient = URLSessionAPIClient<APIService>()
    
    //MARK: - LOGIN AS ADMIN -
    func loginAsAdmin(email: String, password: String) -> AnyPublisher<LoginResponseModel?, APIError> {
        return self.apiClient.request(.loginAsAdmin(email: email, password: password))
    }
    
    //MARK: - GET ALL EMPLOYEES -
    func getAllEmployees(page: Int?, limit: Int?) -> AnyPublisher<GetAllEmployeeResponse?, APIError> {
        return self.apiClient.request(.getAllEmployees(page: page, limit: limit))
    }
    
    //MARK: - GET EMPLOYEE DETAIL -
    func getEmployeeDetail(id: String) -> AnyPublisher<GetEmployeeDetailResponse?, APIError> {
        return self.apiClient.request(.getEmployeeDetail(id: id))
    }
}
