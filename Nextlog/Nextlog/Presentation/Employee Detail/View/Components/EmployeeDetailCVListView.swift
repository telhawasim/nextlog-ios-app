//
//  EmployeeDetailCVListView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct EmployeeDetailCVListView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var index: Int
    var profile: EmployeeDetailProfileResponse
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        HStack(spacing: 15) {
            // Background and Logo
            ZStack {
                // Background
                Circle()
                    .frame(width: 60)
                    .foregroundStyle(Color.color808080)
                // Logo
                Image(ImageEnum.icResume.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 27, height: 27)
                    .foregroundStyle(Color.white)
            }
            // Information
            VStack(alignment: .leading, spacing: 10) {
                // Title
                Text("Resume # \(self.index + 1)")
                    .font(.getSemibold(.h20))
                // Profile
                Text(self.profile.title ?? "")
                    .font(.getMedium(.h18))
                // Date
                Text(self.formatDate(self.profile.createdAt ?? "") ?? "")
                    .font(.getRegular(.h16))
            }
            // Spacer
            Spacer()
            // Options Button
            Button(action: {
                
            }, label: {
                Image(ImageEnum.icOptions.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 25)
            })
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .overlay(
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(Color.black.opacity(0.5))
        )
    }
}

//MARK: - FUNCTIONS -
extension EmployeeDetailCVListView {
    
    //MARK: - FORMAT DATE -
    func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from: dateString)!
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        return outputFormatter.string(from: date)
    }
}

#Preview {
    EmployeeDetailCVListView(
        index: 0,
        profile: EmployeeDetailProfileResponse()
    )
}
