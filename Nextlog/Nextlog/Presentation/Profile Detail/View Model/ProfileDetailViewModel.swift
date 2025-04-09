//
//  ProfileDetailViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 09/04/2025.
//

import Combine

extension ProfileDetailView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        let profileID: String
        private var cancellables = Set<AnyCancellable>()
        @Published var isLoading = false
        @Published var model: GetProfileDetailResponseModel?
        
        //MARK: - INITIALIZER -
        init(profileID: String) {
            self.profileID = profileID
            
            super.init()
            self.fetchProfileAPI()
        }
    }
}

//MARK: - FUNCTIONS -
extension ProfileDetailView.ViewModel {
    
    //MARK: - FETCH PROFILE API -
    func fetchProfileAPI() {
        self.isLoading = true
        
        NetworkManager.shared.request(
            endPoint: APIEndpoint.getProfileDetail(id: self.profileID),
            responseType: GetProfileDetailResponseModel.self
        )
        .sink { result in
            self.isLoading = false
            
            switch result {
            case .failure(let error):
                print(error)
            case .finished:
                break
            }
        } receiveValue: { response in
            self.isLoading = false
            
            self.model = response
        }
        .store(in: &self.cancellables)
    }
}
