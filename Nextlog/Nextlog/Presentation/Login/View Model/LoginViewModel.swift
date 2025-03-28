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
        
        //MARK: - INITIALIZER -
    }
}

//MARK: - FUNCTIONS -
extension LoginView.ViewModel {
    
    //MARK: - LOGIN AS ADMIN -
    func loginAsAdmin(completion: @escaping ((Bool) -> Void)) {
        NetworkManager.shared.request(endPoint: APIEndpoint.login(email: self.email, password: self.password, role: "admin"), responseType: LoginResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.handleErrorMessage(error.localizedDescription)
                    completion(false)
                case .finished:
                    break
                }
            } receiveValue: { response in
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
    
    //MARK: - HANDLE ERROR MESSAGE -
    private func handleErrorMessage(_ message: String) {
        self.errorMessage = message
        self.isShowErrorAlert = true
    }
}
