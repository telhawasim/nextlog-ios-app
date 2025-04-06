//
//  CreateProfileViewModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import Foundation

extension CreateProfileView {
    
    //MARK: - VIEW MODEL -
    class ViewModel: BaseViewModel {
        
        //MARK: - PROPERTIES -
        
        //Published
        @Published var basicInfo: BasicInfoUserModel = BasicInfoUserModel.setInitialData()
        @Published var currentCompany: ExperienceInfoUserModel = ExperienceInfoUserModel.setInitialData()
        @Published var previousExperience: [ExperienceInfoUserModel] = []
        @Published var education: [EducationInfoUserModel] = [EducationInfoUserModel.setIntialData()]
        @Published var certificates: [CertificateInfoUserModel] = []
        @Published var awards: [AwardsInfoUserModel] = []
    }
}

//MARK: - FUNCTIONS -
extension CreateProfileView.ViewModel {
    
    //MARK: = ADD PREVIOUS EXPERIENCE -
    func addPreviousExperience() {
        self.previousExperience.append(ExperienceInfoUserModel.setInitialData())
    }
    
    //MARK: - ADD EDUCATION -
    func addEducation() {
        self.education.append(EducationInfoUserModel.setIntialData())
    }
    
    //MARK: - ADD CERTIFICATES -
    func addCertificates() {
        self.certificates.append(CertificateInfoUserModel.setInitialData())
    }
    
    //MARK: - ADD AWARDS -
    func addAwards() {
        self.awards.append(AwardsInfoUserModel.setInitialData())
    }
}
