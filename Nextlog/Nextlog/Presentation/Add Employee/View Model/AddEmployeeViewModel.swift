//
//  AddEmployeeViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import Foundation
import SwiftUI
import Combine

extension AddEmployeeView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        var cancellables = Set<AnyCancellable>()
        //Published
        @Published var desigations: [DesignationModel]?
        @Published var departments: [DesignationModel]?
        @Published var isShowActionSheet: Bool = false
        @Published var isShowingImagePicker: Bool = false
        @Published var selectedImage: UIImage?
        @Published var sourceType: UIImagePickerController.SourceType = .camera
        @Published var isShowDOBDatePicker: Bool = false
        @Published var isShowDateOfJoiningPicker: Bool = false
        
        //MARK: - INITIALIZER -
        override init() {
            super.init()
            self.getDesignations()
            self.getDepartments()
        }
    }
}

//MARK: - FUNCTIONS -
extension AddEmployeeView.ViewModel {
    
    //MARK: - GET DESIGNATIONS -
    private func getDesignations() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getDesignations, responseType: GetDesignationsResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.desigations = response.designations
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - GET DEPARTMENTS -
    private func getDepartments() {
        NetworkManager.shared.request(endPoint: APIEndpoint.getDepartments, responseType: GetDesignationsResponseModel.self)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.departments = response.departments
            }
            .store(in: &self.cancellables)
    }
}
