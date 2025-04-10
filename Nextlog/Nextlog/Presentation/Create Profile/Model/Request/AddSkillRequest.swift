//
//  AddSkillRequest.swift
//  Nextlog
//
//  Created by Telha Wasim on 10/04/2025.
//

//MARK: - AddSkillRequest -
struct AddSkillRequest: Encodable {
    var technical_skills: [AddSkill]?
    var non_technical_skills: [AddSkill]?
    var tools: [AddSkill]?
}

//MARK: - Skill -
struct AddSkill: Encodable {
    var name: String
}
