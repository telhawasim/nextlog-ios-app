//
//  LoginViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 19/03/2025.
//

import Foundation
import Combine

extension LoginView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        let container: DependencyContainer
        private var cancellables = Set<AnyCancellable>()
        //Published
        @Published var isAdmin: Bool = true
        @Published var email: String = ""
        @Published var password: String = ""
        @Published var id: String = ""
        @Published var isLoginSuccessfully: Bool = false
        
        //MARK: - INITIALIZER -
        init(container: DependencyContainer) {
            self.container = container
        }
    }
}

//MARK: - FUNCTIONS -
extension LoginView.ViewModel {
    
    //MARK: - LOGIN AS ADMIN -
    func loginAsAdmin() {
        self.container
            .userService
            .loginAsAdmin(email: self.email, password: self.password)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.errorDescription ?? "")
                    print(error.errorStatus ?? 0)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                print(response)
                self.isLoginSuccessfully = true
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
        
        if let _ = errorMessage {
            return false
        } else {
            return true
        }
    }
}
