//
//  ProfileDetailViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 09/04/2025.
//

import SwiftUI
import Combine

extension ProfileDetailView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        let profileID: String
        private var cancellables = Set<AnyCancellable>()
        //Published
        @Published var isLoading = false
        @Published var model: GetProfileDetailResponseModel?
        @Published var userImage: UIImage?
        
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
            self.fetchUserImage()
        }
        .store(in: &self.cancellables)
    }
    
    //MARK: - FETCH USER IMAGE -
    private func fetchUserImage() {
        Utilities.shared.fetchImage(from: APIEndpoint.baseURL + (self.model?.employee?.avatar ?? "")) { image in
            DispatchQueue.main.async {
                self.userImage = image
            }
        }
    }
}
