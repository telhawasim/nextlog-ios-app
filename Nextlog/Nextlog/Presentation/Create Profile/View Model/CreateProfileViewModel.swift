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
        @Published var technicalSkills: [SkillInfoUserModel] = []
        @Published var nonTechnicalSkills: [SkillInfoUserModel] = []
        @Published var tools: [SkillInfoUserModel] = []
    }
}

//MARK: - FUNCTIONS -
extension CreateProfileView.ViewModel {
    
    
}
