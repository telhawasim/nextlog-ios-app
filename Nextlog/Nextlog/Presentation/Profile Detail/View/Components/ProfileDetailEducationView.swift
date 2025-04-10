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
    
    //MARK: - VIEWS -
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.education?.degree ?? "")
                    .font(.getSemibold(.h16))
                Spacer()
                Text(self.handleEducationDate())
                    .font(.getMedium(.h16))
            }
            Text(self.education?.institution ?? "")
                .font(.getMedium(.h16))
        }
        .padding(.vertical, 10)
    }
}

//MARK: - FUNCTIONS -
extension ProfileDetailEducationView {
    
    //MARK: - HANDLE EDUCATION DATE -
    private func handleEducationDate() -> String {
        guard let startDateStr = self.education?.startDate,
              let endDateStr = self.education?.endDate,
              let startDate = Utilities.shared.convertStringToDate(startDateStr, formate: .dd_MMM_yyyy),
              let endDate = Utilities.shared.convertStringToDate(endDateStr, formate: .dd_MMM_yyyy) else {
            return ""
        }
        
        let formattedStart = Utilities.shared.formatDateIntoString(startDate, formate: .mmm_yyyy)
        let formattedEnd = Utilities.shared.formatDateIntoString(endDate, formate: .mmm_yyyy)
        
        return "\(formattedStart) - \(formattedEnd)"
    }
}

#Preview {
    ProfileDetailEducationView()
}
