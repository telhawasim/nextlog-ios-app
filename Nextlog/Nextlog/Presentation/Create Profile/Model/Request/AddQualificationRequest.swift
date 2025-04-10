//
//  AddQualificationRequest.swift
//  Nextlog
//
//  Created by Telha Wasim on 10/04/2025.
//

import Foundation

//MARK: - AddExperienceRequest -
struct AddQualificationRequest: Encodable {
    var qualification: [AddQualification]
    var certification: [AddCertification]?
}

//MARK: - AddQualification -
struct AddQualification: Encodable {
    var degree: String
    var institution: String
    var start_date: String
    var end_date: String
}

//MARK: - AddCertification
struct AddCertification: Encodable {
    var course_name: String
    var institution: String
    var start_date: String
    var end_date: String
}
