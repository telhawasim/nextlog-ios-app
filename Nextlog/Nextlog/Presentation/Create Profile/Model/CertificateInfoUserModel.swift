//
//  CertificateInfoUserModel.swift
//  Nextlog
//
//  Created by Telha Wasim on 06/04/2025.
//

struct CertificateInfoUserModel {
    var name: String
    var institution: String
    var startDate: String
    var endDate: String
    
    //MARK: - SET INITIAL DATA -
    static func setInitialData() -> CertificateInfoUserModel {
        return CertificateInfoUserModel(name: "", institution: "", startDate: "", endDate: "")
    }
}
