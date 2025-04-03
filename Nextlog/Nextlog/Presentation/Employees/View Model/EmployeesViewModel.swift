//
//  EmployeesViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 03/04/2025.
//

import Foundation
import Combine

extension EmployeesView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        var cancellables = Set<AnyCancellable>()
        //Published
        @Published var model: GetAllEmployeeResponse?
        
        //MARK: - INITIALIZER -
        override init() {
            super.init()
            self.getAllEmployees()
        }
    }
}

//MARK: - FUNCTIONS -
extension EmployeesView.ViewModel {
    
    //MARK: - GET ALL EMPLOYEES -
    func getAllEmployees() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getEmployees(page: 1, limit: 9), responseType: GetAllEmployeeResponse.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.model = response
            }
            .store(in: &self.cancellables)
    }
}
