//
//  UserRepository.swift
//  Todo
//
//  Created by Telha Wasim on 17/03/2025.
//

import Combine

protocol UserRepository {
    func loginAsAdmin(email: String, password: String) -> AnyPublisher<LoginResponseModel?, APIError>
}

class UserService: UserRepository {
    let apiClient = URLSessionAPIClient<APIService>()
    
    //MARK: - LOGIN AS ADMIN -
    func loginAsAdmin(email: String, password: String) -> AnyPublisher<LoginResponseModel?, APIError> {
        return self.apiClient.request(.loginAsAdmin(email: email, password: password))
    }
}
