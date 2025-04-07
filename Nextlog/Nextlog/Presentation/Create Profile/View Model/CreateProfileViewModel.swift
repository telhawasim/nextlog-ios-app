//
//  CreateProfileViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import Foundation
import Combine

extension CreateProfileView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Normal
        let profileID: String
        let name: String
        let email: String
        let phone: String
        let designation: String
        let desigationID: String
        var cancellables = Set<AnyCancellable>()
        //Published
        @Published var isLoading: Bool = false
        @Published var isShowErrorAlert: Bool = false
        @Published var errorMessage: String = ""
        @Published var model: GetProfileDetailResponseModel?
        @Published var basicInfo: BasicInfoUserModel = BasicInfoUserModel.setInitialData()
        @Published var currentCompany: ExperienceInfoUserModel = ExperienceInfoUserModel.setInitialData()
        @Published var previousExperience: [ExperienceInfoUserModel] = []
        @Published var education: [EducationInfoUserModel] = [EducationInfoUserModel.setIntialData()]
        @Published var certificates: [CertificateInfoUserModel] = []
        @Published var awards: [AwardsInfoUserModel] = []
        @Published var technicalSkills: [SkillInfoUserModel] = []
        @Published var nonTechnicalSkills: [SkillInfoUserModel] = []
        @Published var tools: [SkillInfoUserModel] = []
        
        //MARK: - INITIALIZER -
        init(profileID: String, name: String, email: String, phone: String, designation: String, designationID: String) {
            self.profileID = profileID
            self.name = name
            self.email = email
            self.phone = phone
            self.designation = designation
            self.desigationID = designationID
            
            super.init()
            self.getProfileDetail()
        }
    }
}

//MARK: - FUNCTIONS -
extension CreateProfileView.ViewModel {
    
    //MARK: - GET PROFILE DETAIL -
    private func getProfileDetail() {
        self.isLoading = true
        
        NetworkManager.shared.request(endPoint: APIEndpoint.getProfileDetail(id: self.profileID), responseType: GetProfileDetailResponseModel.self)
            .sink { result in
                self.isLoading = false
                
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.model = response
                self.setBasicInfo()
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - ADD BASIC INFORMATION -
    func addBasicInformation(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        NetworkManager.shared.request(endPoint: APIEndpoint.addBasicInformation(
            id: self.profileID,
            name: self.basicInfo.name,
            designation: self.desigationID,
            email: self.basicInfo.email,
            phone: "+92" + self.basicInfo.phone,
            git: self.basicInfo.github,
            linkedin: self.basicInfo.linkedin,
            summary: self.basicInfo.summary
        ), responseType: AddInfomationResponseModel.self)
            .sink { result in
                self.isLoading = false
                
                switch result {
                case .failure(let error):
//                    self.handleError(error)
                    completion(false)
                case .finished:
                    break
                }
            } receiveValue: { _ in
                self.isLoading = false
                completion(true)
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - VALIDATION FOR BASIC INFORMATION -
    func validationForBasicInformation() -> Bool {
        var errorMessage: String?
        
        if (self.basicInfo.name == "") {
            errorMessage = "Name is required"
        } else if (self.basicInfo.email == "") {
            errorMessage = "Email is required"
        } else if !(self.basicInfo.email.isValidEmail()) {
            errorMessage = "Email must be valid"
        } else if (self.basicInfo.github != "") && !(Utilities.shared.verifyURL(self.basicInfo.github)) {
            errorMessage = "Github / Bit Bucket URL must be valid"
        } else if (self.basicInfo.linkedin != "") && !(Utilities.shared.verifyURL(self.basicInfo.linkedin)) {
            errorMessage = "LinkedIn URL must be valid"
        } else if (self.basicInfo.summary == "") {
            errorMessage = "Summary is required"
        }
        
        if let error = errorMessage {
            self.showErrorAlert(error)
            return false
        } else {
            return true
        }
    }
    
    //MARK: - SET BASIC INFO -
    private func setBasicInfo() {
        var basicInformation: BasicInfoUserModel
        
        if let basicInfo = self.model?.basicInformation {
            basicInformation = BasicInfoUserModel(
                name: basicInfo.name ?? "",
                designation: "SSE",
                email: basicInfo.email ?? "",
                phone: basicInfo.phone, github: <#T##String#>, linkedin: <#T##String#>, summary: <#T##String#>
            )
        }
        let basicInfo = BasicInfoUserModel(
            name: self.name,
            designation: self.designation,
            email: self.email,
            phone: self.phone,
            github: "",
            linkedin: "",
            summary: ""
        )
        
        self.basicInfo = basicInfo
    }
    
    //MARK: - SHOW ERROR ALERT -
    private func showErrorAlert(_ message: String) {
        self.errorMessage = message
        self.isShowErrorAlert = true
    }
}
