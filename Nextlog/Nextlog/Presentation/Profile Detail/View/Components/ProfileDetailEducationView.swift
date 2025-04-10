//
//  ProfileDetailEducationView.swift
//  Nextlog
//
//  Created by Telha Wasim on 10/04/2025.
//

import SwiftUI

struct ProfileDetailEducationView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var education: Qualification?
    var certification: Certificate?
    
    //MARK: - VIEWS -
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.handleTitle())
                    .font(.getSemibold(.h16))
                Spacer()
                Text(self.handleEducationDate())
                    .font(.getMedium(.h16))
            }
            Text(self.handleInstitution())
                .font(.getMedium(.h16))
        }
        .padding(.vertical, 10)
    }
}

//MARK: - FUNCTIONS -
extension ProfileDetailEducationView {
    
    //MARK: - HANDLE TITLE -
    private func handleTitle() -> String {
        if let education = self.education {
            return education.degree ?? ""
        } else {
            return self.certification?.courseName ?? ""
        }
    }
    
    //MARK: - HANDLE INSTITUTION -
    private func handleInstitution() -> String {
        if let education = self.education {
            return education.institution ?? ""
        } else {
            return self.certification?.institution ?? ""
        }
    }
    
    //MARK: - HANDLE EDUCATION DATE -
    private func handleEducationDate() -> String {
        if let education = self.education {
            guard let startDateStr = education.startDate,
                  let endDateStr = education.endDate,
                  let startDate = Utilities.shared.convertStringToDate(startDateStr, formate: .dd_MMM_yyyy),
                  let endDate = Utilities.shared.convertStringToDate(endDateStr, formate: .dd_MMM_yyyy) else {
                return ""
            }
            
            let formattedStart = Utilities.shared.formatDateIntoString(startDate, formate: .mmm_yyyy)
            let formattedEnd = Utilities.shared.formatDateIntoString(endDate, formate: .mmm_yyyy)
            
            return "\(formattedStart) - \(formattedEnd)"
        } else {
            guard let startDateStr = self.certification?.startDate,
                  let endDateStr = self.certification?.endDate,
                  let startDate = Utilities.shared.convertStringToDate(startDateStr, formate: .dd_MMM_yyyy),
                  let endDate = Utilities.shared.convertStringToDate(endDateStr, formate: .dd_MMM_yyyy) else {
                return ""
            }
            
            let formattedStart = Utilities.shared.formatDateIntoString(startDate, formate: .mmm_yyyy)
            let formattedEnd = Utilities.shared.formatDateIntoString(endDate, formate: .mmm_yyyy)
            
            return "\(formattedStart) - \(formattedEnd)"
        }
    }
}

#Preview {
    ProfileDetailEducationView()
}
