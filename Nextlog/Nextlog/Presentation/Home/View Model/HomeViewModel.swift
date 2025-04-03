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
        
        //MARK: - INITIALIZER -
        override init() {
            super.init()
            self.getAllEmployees()
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
