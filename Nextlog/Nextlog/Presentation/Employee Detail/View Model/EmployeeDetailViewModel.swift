//
//  EmployeeDetailViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import Combine

extension EmployeeDetailView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        private var cancellables = Set<AnyCancellable>()
        
        @Published var model: GetEmployeeDetailResponse?
        
        //MARK: - INITIALZER -
        override init() {
            super.init()
            self.fetchEmployeeDetails()
        }
    }
}

//MARK: - FUNCTIONS -
extension EmployeeDetailView.ViewModel {
    
    //MARK: - FETCH EMPLOYEE DETAILS -
    func fetchEmployeeDetails() {
//        self.container
//            .userService
//            .getEmployeeDetail(id: self.employeeID)
//            .sink { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .finished:
//                    break
//                }
//            } receiveValue: { response in
//                self.model = response
//            }
//            .store(in: &self.cancellables)
    }
}
