//
//  AddExperienceRequest.swift
//  Nextlog
//
//  Created by Telha Wasim on 08/04/2025.
//

import Foundation

//MARK: - AddExperienceRequest -
struct AddExperienceRequest: Encodable {
    var current_experience: AddExperience
    var previous_experience: [AddExperience]?
}

struct AddExperience: Encodable {
    var company: String
    var designation: String
    var start_date: String
    var end_date: String
    var description: String
}
