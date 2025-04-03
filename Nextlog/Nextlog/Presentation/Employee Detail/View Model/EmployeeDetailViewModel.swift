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
        let employeeId: String
        //Published
        @Published var model: EmployeeDetailModel?
        
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
        NetworkManager.shared.request(endPoint: APIEndpoint.getEmployeeDetails(id: id), responseType: GetEmployeeDetailResponse.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.model = response.employee
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - DELETE EMPLOYEE API -
    func deleteEmployeeAPI(completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.request(endPoint: APIEndpoint.deleteEmployee(id: self.employeeId), responseType: DeleteEmployeeResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                case .finished:
                    break
                }
            } receiveValue: { _ in
                completion(true)
            }
            .store(in: &self.cancellables)
    }
}
