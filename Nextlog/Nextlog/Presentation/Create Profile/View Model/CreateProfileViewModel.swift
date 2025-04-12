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
        //Education
        @Published var isShowEducationStartDatePicker: Bool = false
        @Published var isShowEducationEndDatePicker: Bool = false
        @Published var selectedEducationIndex: Int? = nil // For Education
        @Published var selectedEducationStartDate: Date = Date()
        @Published var selectedEducationEndDate: Date = Date()
        @Published var education: [EducationInfoUserModel] = [EducationInfoUserModel.setIntialData()]
        //Certification
        @Published var isShowCertificationStartDatePicker: Bool = false
        @Published var isShowCertificationEndDatePicker: Bool = false
        @Published var selectedCertificationIndex: Int? = nil // For Certification
        @Published var selectedCertificationStartDate: Date = Date()
        @Published var selectedCertificationEndDate: Date = Date()
        @Published var certificates: [CertificateInfoUserModel] = []
        //Technical Skills
        @Published var technicalSkills: [SkillInfoUserModel] = []
        //Non-Technical Skills
        @Published var nonTechnicalSkills: [SkillInfoUserModel] = []
        //Tools
        @Published var tools: [SkillInfoUserModel] = []
        
        @Published var isLoading: Bool = false
        @Published var isShowErrorAlert: Bool = false
        @Published var errorMessage: String = ""
        
        @Published var model: GetProfileDetailResponseModel?
        @Published var awards: [AwardsInfoUserModel] = []
        
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
                self.setQualification()
                self.setCertification()
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
    
    //MARK: - ADD QUALIFICATION API -
    func addQualificationAPI(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        let qualifications = self.education.map {
            self.mapToAddQualification(from: $0)
        }
        let certifications = self.certificates.map {
            self.mapToAddCertification(from: $0)
        }
        let params = AddQualificationRequest(
            qualification: qualifications,
            certification: certifications
        )
        
        NetworkManager.shared.request(
            endPoint: APIEndpoint.addQualification(id: self.profileID),
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
            self.isLoading = false
            
            completion(true)
        }
        .store(in: &self.cancellables)
    }
    
    //MARK: - ADD SKILL API -
    func addSkillAPI(completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        
        let technicalSkills = self.technicalSkills.map {
            self.mapToAddSkills(from: $0)
        }
        let nonTechnicalSkills = self.nonTechnicalSkills.map {
            self.mapToAddSkills(from: $0)
        }
        let tools = self.tools.map {
            self.mapToAddSkills(from: $0)
        }
        let params = AddSkillRequest(
            technical_skills: technicalSkills,
            non_technical_skills: nonTechnicalSkills,
            tools: tools
        )
        
        NetworkManager.shared.request(
            endPoint: APIEndpoint.addSkill(id: self.profileID),
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
    
    //MARK: - VALIDATION FOR EXPERIENCE -
    func validationForQualification() -> Bool {
        var errorMessage: String?
        
        // Validate education
        if (self.education.count > 0) {
            for education in self.education {
                if education.degree.isEmpty {
                    errorMessage = "Degree is required in qualification"
                    break
                } else if education.institution.isEmpty {
                    errorMessage = "Institution is required in qualification"
                    break
                } else if education.startDate.isEmpty {
                    errorMessage = "Start date is required for previous experience"
                    break
                } else if education.endDate.isEmpty {
                    errorMessage = "End date is required for previous experience"
                    break
                }
            }
        }
        
        // Validate the certificates
        if errorMessage == nil && self.certificates.count > 0 {
            for certificate in self.certificates {
                if certificate.name.isEmpty {
                    errorMessage = "Course name is required in certificate"
                    break
                } else if certificate.institution.isEmpty {
                    errorMessage = "Institution is required in certificate"
                    break
                } else if certificate.startDate.isEmpty {
                    errorMessage = "Start date is required in certificate"
                    break
                } else if certificate.endDate.isEmpty {
                    errorMessage = "End date is required in certificate"
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
    
    //MARK: - VALIDATE FOR SKILLS -
    func validationForSkills() -> Bool {
        var errorMessage: String?
        
        if (self.technicalSkills.count > 0) {
            for technicalSkill in self.technicalSkills {
                if technicalSkill.name.isEmpty {
                    errorMessage = "Technical skill is required"
                }
            }
        }
        
        if (errorMessage == nil) && (self.nonTechnicalSkills.count > 0) {
            for nonTechnicalSkill in self.nonTechnicalSkills {
                if nonTechnicalSkill.name.isEmpty {
                    errorMessage = "Non-Technical skill is required"
                }
            }
        }
        
        if (errorMessage == nil) && (self.tools.count > 0) {
            for tool in self.tools {
                if tool.name.isEmpty {
                    errorMessage = "Tool is required"
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
    
    //MARK: - SET QUALIFICATION -
    private func setQualification() {
        if let qualification = self.model?.qualification, !qualification.isEmpty {
            self.education = []
            for qualificationData in qualification {
                self.education.append(EducationInfoUserModel(
                    degree: qualificationData.degree ?? "",
                    institution: qualificationData.institution ?? "",
                    startDate: qualificationData.startDate ?? "",
                    endDate: qualificationData.endDate ?? ""
                ))
            }
        } else {
            self.education = [EducationInfoUserModel.setIntialData()]
        }
    }
    
    //MARK: - SET CERTIFICATION -
    private func setCertification() {
        if let certification = self.model?.certification, !certification.isEmpty {
            for certificate in certification {
                self.certificates.append(CertificateInfoUserModel(
                    name: certificate.courseName ?? "",
                    institution: certificate.institution ?? "",
                    startDate: certificate.startDate ?? "",
                    endDate: certificate.endDate ?? ""
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
    
    //MARK: - SHOW EDUCATION START DATE PICKER -
    func showEducationStartDatePicker(for index: Int?) {
        self.selectedEducationIndex = index
        self.isShowEducationStartDatePicker = true
    }
    
    //MARK: - SHOW EDUCATION END DATE PICKER -
    func showEducationEndDatePicker(for index: Int?) {
        self.selectedExperienceIndex = index
        self.isShowEducationEndDatePicker = true
    }
    
    //MARK: - SHOW CERTIFICATE START DATE PICKER -
    func showCertificationStartDatePicker(for index: Int?) {
        self.selectedCertificationIndex = index
        self.isShowCertificationStartDatePicker = true
    }
    
    //MARK: - SHOW CERTIFICATE END DATE PICKER -
    func showCertificateEndDatePicker(for index: Int?) {
        self.selectedCertificationIndex = index
        self.isShowCertificationEndDatePicker = true
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
        
    //MARK: - MAP TO ADD QUALIFICATION -
    private func mapToAddQualification(from model: EducationInfoUserModel) -> AddQualification {
        return AddQualification(
            degree: model.degree,
            institution: model.institution,
            start_date: model.startDate,
            end_date: model.endDate
        )
    }
    
    //MARK: - MAP TO ADD CERTIFICATION -
    private func mapToAddCertification(from model: CertificateInfoUserModel) -> AddCertification {
        return AddCertification(
            course_name: model.name,
            institution: model.institution,
            start_date: model.startDate,
            end_date: model.endDate
        )
    }
    
    //MARK: - MAP TO ADD SKILLS -
    private func mapToAddSkills(from model: SkillInfoUserModel) -> AddSkill {
        return AddSkill(
            name: model.name
        )
    }
    
    //MARK: - SHOW ERROR ALERT -
    private func showErrorAlert(_ message: String) {
        self.errorMessage = message
        self.isShowErrorAlert = true
    }
}
