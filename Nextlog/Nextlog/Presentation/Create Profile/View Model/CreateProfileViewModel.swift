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
        var desigationID: String
        var cancellables = Set<AnyCancellable>()
        //Published
        
        //Info
        @Published var isShowDesignationPicker: Bool = false
        @Published var basicInfo: BasicInfoUserModel = BasicInfoUserModel.setInitialData()
        //Experience
        @Published var isShowStartDatePicker: Bool = false // For Start Date Picker
        @Published var isShowEndDatePicker: Bool = false // For End Date Picker
        @Published var isShowExperienceDesignationPicker: Bool = false
        @Published var selectedStartDate: Date = Date()
        @Published var selectedEndDate: Date = Date()
        @Published var selectedExperienceIndex: Int? = nil // For Previous Experience
        @Published var currentExperience: ExperienceInfoUserModel = ExperienceInfoUserModel.setInitialDataForCurrentExperience()
        @Published var previousExperience: [ExperienceInfoUserModel] = []
        @Published var currentExperienceDesignation: DesignationModel
        
        @Published var isLoading: Bool = false
        @Published var isShowErrorAlert: Bool = false
        @Published var errorMessage: String = ""
        
        @Published var model: GetProfileDetailResponseModel?
        
        
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
            self.currentExperienceDesignation = DesignationModel(id: self.desigationID, name: self.designation)
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
                self.setExperience()
            }
            .store(in: &self.cancellables)
    }
    
    //MARK: - ADD BASIC INFORMATION -
    func addBasicInformation(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        let params = AddBasicInformationRequest(
            name: self.basicInfo.name,
            designation: self.desigationID,
            email: self.basicInfo.email,
            phone: "+92" + self.basicInfo.phone,
            git_link: self.basicInfo.github,
            linked_in_link: self.basicInfo.linkedin,
            summary: self.basicInfo.summary
        )
        
        NetworkManager.shared.request(
            endPoint: APIEndpoint.addBasicInformation(id: self.profileID),
            responseType: AddInfomationResponseModel.self,
            encodableParameters: params
        )
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
    
    //MARK: - ADD EXPERIENCE API -
    func addExperienceAPI(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        let currentExperience = self.mapToAddExperience(from: self.currentExperience)
        let previousExperience = self.previousExperience.map {
            self.mapToAddExperience(from: $0)
        }
        let params = AddExperienceRequest(
            current_experience: currentExperience,
            previous_experience: previousExperience
        )
        
        NetworkManager.shared.request(
            endPoint: APIEndpoint.addExperience(id: self.profileID),
            responseType: AddInfomationResponseModel.self,
            encodableParameters: params
        )
        .sink { result in
            self.isLoading = false
            
            switch result {
            case .failure(let error):
                print(error)
                completion(false)
            case .finished:
                break
            }
        } receiveValue: { _ in
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
    
    //MARK: - VALIDATION FOR EXPERIENCE -
    func validationForExperience() -> Bool {
        var errorMessage: String?
        
        // Validate current experience
        if currentExperience.companyName.isEmpty {
            errorMessage = "Company name is required for current experience"
        } else if currentExperience.startDate.isEmpty {
            errorMessage = "Start date is required for current experience"
        } else if currentExperience.endDate.isEmpty {
            errorMessage = "End date is required for current experience"
        } else if currentExperience.designationName.isEmpty {
            errorMessage = "Designation name is required for current experience"
        } else if currentExperience.designationID.isEmpty {
            errorMessage = "Designation ID is required for current experience"
        } else if currentExperience.description.isEmpty {
            errorMessage = "Description is required for current experience"
        }
        
        // Validate previous experience
        if errorMessage == nil && self.previousExperience.count > 0 {
            for experience in previousExperience {
                if experience.companyName.isEmpty {
                    errorMessage = "Company name is required for previous experience"
                    break
                } else if experience.startDate.isEmpty {
                    errorMessage = "Start date is required for previous experience"
                    break
                } else if experience.endDate.isEmpty {
                    errorMessage = "End date is required for previous experience"
                    break
                } else if experience.designationName.isEmpty {
                    errorMessage = "Designation name is required for previous experience"
                    break
                } else if experience.designationID.isEmpty {
                    errorMessage = "Designation ID is required for previous experience"
                    break
                } else if experience.description.isEmpty {
                    errorMessage = "Description is required for previous experience"
                    break
                }
            }
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
                designation: basicInfo.designation?.name ?? "",
                email: basicInfo.email ?? "",
                phone: Utilities.shared.removeThePrefixFromPhoneNumber("+92", basicInfo.phone),
                github: basicInfo.gitLink ?? "",
                linkedin: basicInfo.linkedInLink ?? "", 
                summary: basicInfo.summary ?? ""
            )
        } else {
            basicInformation = BasicInfoUserModel(
                name: self.name,
                designation: self.designation,
                email: self.email,
                phone: self.phone,
                github: "",
                linkedin: "",
                summary: ""
            )
        }
        
        self.basicInfo = basicInformation
    }
    
    //MARK: - SET EXPERIENCE -
    private func setExperience() {
        self.setCurrentExperience()
        self.setPreviousExperience()
    }
    
    //MARK: - SET CURRENT EXPERIENCE -
    private func setCurrentExperience() {
        var currentExperience: ExperienceInfoUserModel
        
        if let current = self.model?.experience?.currentExperience {
            currentExperience = ExperienceInfoUserModel(
                companyName: current.company ?? "",
                startDate: current.startDate ?? "",
                endDate: current.endDate ?? "",
                designationName: current.designation?.name ?? "",
                designationID: current.designation?.id ?? "",
                description: current.description ?? ""
            )
        } else {
            currentExperience = ExperienceInfoUserModel(
                companyName: "NextBridge",
                startDate: "",
                endDate: "Present",
                designationName: self.designation,
                designationID: self.desigationID,
                description: ""
            )
        }
        
        self.currentExperience = currentExperience
    }
    
    //MARK: - SET PREVIOUS EXPERIENCE -
    private func setPreviousExperience() {
        if let previousExperiences = self.model?.experience?.previousExperience, !previousExperiences.isEmpty {
            for previousExperience in previousExperiences {
                self.previousExperience.append(ExperienceInfoUserModel(
                    companyName: previousExperience.company ?? "",
                    startDate: previousExperience.startDate ?? "",
                    endDate: previousExperience.endDate ?? "",
                    designationName: previousExperience.designation?.name ?? "",
                    designationID: previousExperience.designation?.id ?? "",
                    description: previousExperience.description ?? ""
                ))
            }
        }
    }
    
    //MARK: - SET DESIGNATION ID -
    func setDesignationID(_ designation: String) {
        if let designationID = AppStorage.designations?.first(where: { $0.name == designation }) {
            self.desigationID = designationID.id ?? ""
        }
    }
    
    //MARK: - SHOW START DATE PICKER -
    func showStartDatePicker(for index: Int?) {
        self.selectedExperienceIndex = index
        self.isShowStartDatePicker = true
    }
    
    //MARK: - SHOW END DATE PICKER -
    func showEndDatePicker(for index: Int?) {
        self.selectedExperienceIndex = index
        self.isShowEndDatePicker = true
    }
    
    //MARK: - SHOW EXPERIENCE DESIGNATION -
    func showExperienceDesignation(for index: Int) {
        self.selectedExperienceIndex = index
        self.isShowExperienceDesignationPicker = true
    }
    
    //MARK: - MAP TO ADD EXPERIENCE -
    private func mapToAddExperience(from model: ExperienceInfoUserModel) -> AddExperience {
        return AddExperience(
            company_name: model.companyName,
            designation: model.designationID,
            start_date: model.startDate,
            end_date: model.endDate,
            description: model.description
        )
    }
    
    //MARK: - SHOW ERROR ALERT -
    private func showErrorAlert(_ message: String) {
        self.errorMessage = message
        self.isShowErrorAlert = true
    }
}
