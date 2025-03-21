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
        let container: DependencyContainer
        private var cancellables = Set<AnyCancellable>()
        //Published
        @Published var page: Int? = 1
        @Published var limit: Int? = 9
        @Published var model: GetAllEmployeeResponse?
        
        //MARK: - INITIALIZER -
        init(container: DependencyContainer) {
            self.container = container
            super.init()
            self.getAllEmployees()
        }
    }
}

//MARK: - FUNCTIONS -
extension HomeView.ViewModel {
    
    //MARK: - GET ALL EMPLOYEES -
    private func getAllEmployees() {
        self.container
            .userService
            .getAllEmployees(page: self.page, limit: self.limit)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.model = response
            }
            .store(in: &self.cancellables)
    }
}
