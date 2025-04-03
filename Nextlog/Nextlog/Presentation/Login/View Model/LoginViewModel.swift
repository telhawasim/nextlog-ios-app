//
//  LoginViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import Foundation
import Combine
import Alamofire

extension LoginView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        private var cancellables = Set<AnyCancellable>()
        //Published
        @Published var isAdmin: Bool = true
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var id: String = ""
        @Published var errorMessage: String = ""
        @Published var isShowErrorAlert: Bool = false
        @Published var isLoading: Bool = false
        
        //MARK: - INITIALIZER -
    }
}

//MARK: - FUNCTIONS -
extension LoginView.ViewModel {
    
    //MARK: - LOGIN AS ADMIN -
    func loginAsAdmin(completion: @escaping ((Bool) -> Void)) {
        self.isLoading = true
        
        NetworkManager.shared.request(endPoint: APIEndpoint.login(email: self.email, password: self.password, role: "admin"), responseType: LoginResponseModel.self)
            .sink { result in
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.handleError(error)
                    completion(false)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.isLoading = false
                
                AppStorage.user = response.data
                AppStorage.accessToken = response.accessToken
                
                completion(true)
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - LOGIN AS EMPLOYEE -
    func loginAsEmployee(completion: @escaping ((Bool) -> Void)) {
        self.isLoading = true
        
        NetworkManager.shared.request(endPoint: APIEndpoint.login(email: self.email, emp_id: Int(self.id), role: "employee"), responseType: LoginResponseModel.self)
            .sink { result in
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.handleError(error)
                    completion(false)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.isLoading = false
                
                AppStorage.user = response.data
                AppStorage.accessToken = response.accessToken
                
                completion(true)
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - VALIDATION FOR LOGIN AS ADMIN -
    func validationForLoginAsAdmin() -> Bool {
        var errorMessage: String?
        
        if (self.email.isEmpty) {
            errorMessage = "Email cannot be empty"
        } else if !(self.email.isValidEmail()) {
            errorMessage = "Email must be valid"
        } else if (self.password.isEmpty) {
            errorMessage = "Password cannot be empty"
        }
        
        if let error = errorMessage {
            self.handleErrorMessage(error)
            return false
        } else {
            return true
        }
    }
    
    //MARK: - VALIDATE FOR EMPLOYEE LOGIN -
    func validationForEmployeeLogin() -> Bool {
        var errorMessage: String?
        
        if (self.email.isEmpty) {
            errorMessage = "Email cannot be empty"
        } else if !(self.email.isValidEmail()) {
            errorMessage = "Email must be valid"
        } else if (self.id.isEmpty) {
            errorMessage = "ID cannot me empty"
        }
        
        if let error = errorMessage {
            self.handleErrorMessage(error)
            return false
        } else {
            return true
        }
    }
    
    //MARK: - HANDLE ERROR -
    private func handleError(_ error: NetworkError) {
        let message: String
        
        switch error {
        case .unauthorized(_, let msg), .serverError(_, let msg):
            message = msg
        default:
            message = "Something went wrong"
        }
        
        self.handleErrorMessage(message)
    }
    
    //MARK: - HANDLE ERROR MESSAGE -
    private func handleErrorMessage(_ message: String) {
        self.errorMessage = message
        self.isShowErrorAlert = true
    }
    
    //MARK: - RESET TEXTFIELDS -
    func resetTextfields() {
        self.email = ""
        self.id = ""
        self.password = ""
    }
}
