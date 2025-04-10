//
//  ProfileDetailSkillView.swift
//  Nextlog
//
//  Created by Telha Wasim on 10/04/2025.
//

import SwiftUI

struct ProfileDetailSkillView: View {
    
    //MARK: - PROPERTIES -
    var skill: [Skill]?
    
    //MARK: - VIEWS -
    var body: some View {
        Text(self.handleSkills())
            .font(.getRegular(.h16))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//MARK: - FUNCTIONS -
extension ProfileDetailSkillView {
    
    //MARK: - HANDLE SKILLS -
    private func handleSkills() -> String {
        if let skills = self.skill?.compactMap({ $0.name }).joined(separator: ", ") {
            return skills
        } else {
            return ""
        }
    }
}

#Preview {
    ProfileDetailSkillView()
}
