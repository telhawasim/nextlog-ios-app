//
//  ProfileDetailContactView.swift
//  Nextlog
//
//  Created by Telha Wasim on 09/04/2025.
//

import SwiftUI

struct ProfileDetailContactView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var model: BasicInformation?
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 0) {
            // Title
            Text("Contact")
                .font(.getSemibold(.h26))
            // Email, Phone, LinkedIn and Git
            VStack(alignment: .leading, spacing: 12) {
                // Email
                HStack(spacing: 10) {
                    Image(ImageEnum.icEmail.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text(verbatim: self.model?.email ?? "")
                        .font(.getMedium(.h14))
                }
                // Only show if there is Linkedin Link
                if let linkedInLink = self.model?.linkedInLink, linkedInLink != "" {
                    // LinkedIn
                    HStack(spacing: 10) {
                        Image(ImageEnum.icLinkedIn.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text(self.model?.linkedInLink ?? "")
                            .font(.getMedium(.h14))
                    }
                }
                // Phone
                HStack(spacing: 10) {
                    Image(ImageEnum.icPhone.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text(self.model?.phone ?? "")
                        .font(.getMedium(.h14))
                }
                // Only show if there is a Git Link
                if let git = self.model?.gitLink, git != "" {
                    // Git
                    HStack(spacing: 10) {
                        Image(ImageEnum.icGitLink.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text(self.model?.gitLink ?? "")
                            .font(.getMedium(.h14))
                    }
                }
            }
            .padding(.top, 17)
        }
        .padding(.vertical, 17)
    }
}

#Preview {
    ProfileDetailContactView()
}
