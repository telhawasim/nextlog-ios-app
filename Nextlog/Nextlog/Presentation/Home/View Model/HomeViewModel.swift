//
//  HomeViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import Combine

extension HomeView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        private var cancellables = Set<AnyCancellable>()
        //Published
        @Published var page: Int? = 1
        @Published var limit: Int? = 9
        @Published var model: GetAllEmployeeResponse?
        @Published var isShowErrorAlert: Bool = false
        @Published var errorMessage: String = ""
        @Published var isUnauthorized: Bool = false
        
        //MARK: - INITIALIZER -
        override init() {
            super.init()
            self.getAllEmployees()
            self.getDesignations()
            self.getDepartments()
        }
    }
}

//MARK: - FUNCTIONS -
extension HomeView.ViewModel {
    
    //MARK: - GET ALL EMPLOYEES -
    func getAllEmployees() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getEmployees(page: 1, limit: 5), responseType: GetAllEmployeeResponse.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.handleError(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.model = response
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - GET DESIGNATIONS -
    private func getDesignations() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getDesignations, responseType: GetDesignationsResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.handleError(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                AppStorage.designations = response.designations
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - GET DEPARTMENTS -
    private func getDepartments() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getDepartments, responseType: GetDesignationsResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.handleError(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                AppStorage.departments = response.departments
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - HANDLE ERROR -
    private func handleError(_ error: NetworkError) {
        let message: String
        
        switch error {
        case .unauthorized(_, _):
            self.isUnauthorized = true
            message = "Login session as expired. Please login again."
        case .serverError(_, let msg):
            message = msg
        default:
            message = "Something went wrong"
        }
        
        self.showErrorAlert(message)
    }
    
    //MARK: - SHOW ERROR ALERT -
    private func showErrorAlert(_ message: String) {
        self.errorMessage = message
        self.isShowErrorAlert = true
    }
}
