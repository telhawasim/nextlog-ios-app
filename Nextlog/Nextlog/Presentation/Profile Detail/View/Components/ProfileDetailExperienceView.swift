//
//  ProfileDetailExperienceView.swift
//  Nextlog
//
//  Created by Telha Wasim on 09/04/2025.
//

import SwiftUI
import ExpandableText

struct ProfileDetailExperienceView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var experience: Experience?
    
    //MARK: - VIEWS -
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading) {
                HStack {
                    Text(self.experience?.company ?? "")
                        .font(.getSemibold(.h16))
                    Spacer()
                    Text(self.handleExperienceDate())
                        .font(.getMedium(.h16))
                }
                Text("SSE")
                    .font(.getMedium(.h16))
            }
            ExpandableText(self.experience?.description ?? "")
                .font(.getRegular(.h16))
                .lineLimit(3)
                .moreButtonText("Read More")
                .moreButtonFont(.getSemibold(.h16))
                .moreButtonColor(Color.color808080)
                .enableCollapse(true)
                .expandAnimation(.easeInOut(duration: 0.2))
                .trimMultipleNewlinesWhenTruncated(false)
                .lineSpacing(5)
        }
        .padding(.vertical, 10)

    }
}

//MARK: - FUNCTIONS -
extension ProfileDetailExperienceView {
    
    //MARK: - HANDLE EXPERIENCE DATE -
    private func handleExperienceDate() -> String {
        if self.experience?.endDate == "Present" {
            guard let startDateStr = self.experience?.startDate,
                  let endDateStr = self.experience?.endDate,
                  let startDate = Utilities.shared.convertStringToDate(startDateStr, formate: .dd_MMM_yyyy) else {
                return ""
            }
            
            let formattedStart = Utilities.shared.formatDateIntoString(startDate, formate: .mmm_yyyy)
            
            return "\(formattedStart) - \(endDateStr)"
        } else {
            guard let startDateStr = self.experience?.startDate,
                  let endDateStr = self.experience?.endDate,
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
    ProfileDetailExperienceView()
}
