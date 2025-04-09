//
//  AddBasicInformationRequest.swift
//  Nextlog
//
//  Created by Telha Wasim on 09/04/2025.
//

//MARK: - AddBasicInformationRequest -
struct AddBasicInformationRequest: Encodable {
    var name: String
    var designation: String
    var email: String
    var phone: String
    var git_link: String?
    var linked_in_link: String?
    var summary: String
}
