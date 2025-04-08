//
//  EmployeeDetailViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import Foundation
import Combine

extension EmployeeDetailView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        private var cancellables = Set<AnyCancellable>()
        let employeeId: String
        //Published
        @Published var profileName: String = ""
        @Published var model: EmployeeDetailModel?
        @Published var isShowProfilePopup: Bool = false
        @Published var isShowDeleteProfilePopup: Bool = false
        @Published var isLoading: Bool = false
        @Published var isShowErrorAlert: Bool = false
        @Published var errorMessage: String = ""
        @Published var isUnauthorized: Bool = false
        @Published var isShowOptionSheet: Bool = false
        @Published var sheetHeight: CGFloat = .zero
        @Published var selectedIndex: Int = -1
        
        //MARK: - INITIALZER -
        init(employeeId: String) {
            self.employeeId = employeeId
            super.init()
            self.fetchEmployeeDetails(id: employeeId)
        }
    }
}

//MARK: - FUNCTIONS -
extension EmployeeDetailView.ViewModel {
    
    //MARK: - FETCH EMPLOYEE DETAILS -
    func fetchEmployeeDetails(id: String) {
        self.isLoading = true
        
        NetworkManager.shared.request(endPoint: APIEndpoint.getEmployeeDetails(id: id), responseType: GetEmployeeDetailResponse.self)
            .sink { result in
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.handleError(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.isLoading = false
                
                self.model = response.employee
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - DELETE EMPLOYEE API -
    func deleteEmployeeAPI(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        NetworkManager.shared.request(endPoint: APIEndpoint.deleteEmployee(id: self.employeeId), responseType: DeleteEmployeeResponseModel.self)
            .sink { result in
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    self.handleError(error)
                    completion(false)
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.isLoading = false
                
                NotificationCenter.default.post(name: .employeeDidDelete, object: nil)
                completion(true)
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - ADD PROFILE API -
    func addProfileAPI() {
        self.isLoading = true
        
        let params = AddProfileRequestModel(
            id: self.employeeId,
            name: self.profileName
        )
        
        NetworkManager.shared.request(
            endPoint: APIEndpoint.addProfile,
            responseType: AddProfileResponseModel.self,
            encodableParameters: params
        )
        .sink { result in
            self.isLoading = false
            
            switch result {
            case .failure(let error):
                self.handleError(error)
            case .finished:
                break
            }
        } receiveValue: { _ in
            self.isLoading = false
            
            self.profileName = ""
            self.isShowProfilePopup = false
            self.fetchEmployeeDetails(id: self.employeeId)
        }
        .store(in: &self.cancellables)
    }
    
    //MARK: - DELETE PROFILE API -
    func deleteProfileAPI(id: String) {
        self.isLoading = true
        
        NetworkManager.shared.request(endPoint: APIEndpoint.deleteProfile(id: id), responseType: DeleteProfileResponseModel.self)
            .sink { result in
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.isShowOptionSheet = false
                self.fetchEmployeeDetails(id: self.employeeId)
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
        case .serverError(_ , let msg):
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
