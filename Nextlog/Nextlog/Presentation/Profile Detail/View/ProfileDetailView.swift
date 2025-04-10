//
//  ProfileDetailView.swift
//  Nextlog
//
//  Created by Telha Wasim on 09/04/2025.
//

import SwiftUI
import ExpandableText

struct ProfileDetailView: View {
    
    //MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject private var router: Routing
    //StateObject
    @StateObject var viewModel: ProfileDetailView.ViewModel
    //State
    @State private var userImage: UIImage?
    
    //MARK: - VIEWS -
    var body: some View {
        // Main View
        VStack(alignment: .leading, spacing: 0) {
            // Header View
            HStack {
                // Title
                Text("Profile Overview")
                    .font(.getMedium(.h24))
                // Spacer
                Spacer()
                // Back Button
                Button(action: {
                    self.router.pop()
                }, label: {
                    Image(ImageEnum.icCross.rawValue)
                        .resizable()
                        .frame(width: 20, height: 20)
                })
            }
            // Picture and Options Buttons
            HStack {
                // Picture
                if let userImage = self.viewModel.userImage {
                    Image(uiImage: userImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                } else {
                    Image(ImageEnum.icUserPlaceholder.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                }
                // Spacer
                Spacer()
            }
            .padding(.top, 15)
            // Name and Designation
            VStack(alignment: .leading) {
                // Name
                Text(self.viewModel.model?.basicInformation?.name ?? "")
                    .font(.getBold(.h32))
                // Designation
                Text(self.viewModel.model?.basicInformation?.designation?.name ?? "")
                    .font(.getMedium(.h16))
            }
            .padding(.top, 10)
            // ScrollView
            ScrollView(.vertical, showsIndicators: false) {
                // Scroll Content View
                LazyVStack(alignment: .leading, spacing: 0) {
                    // Contact View
                    ProfileDetailContactView(
                        model: self.viewModel.model?.basicInformation
                    )
                    // Summary Title
                    ProfileDetailHeaderView(
                        title: "Summary"
                    )
                    // Summary
                    ExpandableText(self.viewModel.model?.basicInformation?.summary ?? "")
                        .font(.getRegular(.h16))
                        .lineLimit(3)
                        .moreButtonText("Read More")
                        .moreButtonFont(.getSemibold(.h16))
                        .moreButtonColor(Color.color808080)
                        .enableCollapse(true)
                        .expandAnimation(.easeInOut(duration: 0.2))
                        .trimMultipleNewlinesWhenTruncated(false)
                        .lineSpacing(5)
                        .padding(.top, 10)
                    // Work Experience Title
                    ProfileDetailHeaderView(
                        title: "Work Experience"
                    )
                    .padding(.top, 10)
                    // Current Experience
                    ProfileDetailExperienceView(
                        experience: self.viewModel.model?.experience?.currentExperience
                    )
                    // Only show in case previous experience is not nil and array is not empty
                    if let previousExperience = self.viewModel.model?.experience?.previousExperience {
                        ForEach(previousExperience, id: \.company) { experience in
                            ProfileDetailExperienceView(
                                experience: experience
                            )
                        }
                    }
                    // Education Header
                    ProfileDetailHeaderView(
                        title: "Education"
                    )
                    // Only show in case qualification is not nil and array is not empty
                    if let qualification = self.viewModel.model?.qualification {
                        ForEach(qualification, id: \.degree) { qualification in
                            ProfileDetailEducationView(
                                education: qualification
                            )
                        }
                    }
                    // Only show in case certification is not nil and array is not empty
                    if let certification = self.viewModel.model?.certification, !certification.isEmpty {
                        // Certification Title and Listing
                        VStack(spacing: 0) {
                            // Title
                            ProfileDetailHeaderView(
                                title: "Trainings & Certifications"
                            )
                            // Listing
                            ForEach(certification, id: \.courseName) { certification in
                                ProfileDetailEducationView(
                                    certification: certification
                                )
                            }
                        }
                    }
                    // Only show in case technical skills is not nil
                    if let technicalSkills = self.viewModel.model?.skill?.technicalSkills {
                        VStack {
                            ProfileDetailHeaderView(
                                title: "Technical Skills"
                            )
                            ProfileDetailSkillView(skill: technicalSkills)
                        }
                    }
                    // Only show in case non technical skills is not nil
                    if let nonTechnicalSkills = self.viewModel.model?.skill?.nonTechnicalSkills {
                        VStack {
                            ProfileDetailHeaderView(
                                title: "Non Technical Skills"
                            )
                            ProfileDetailSkillView(skill: nonTechnicalSkills)
                        }
                        .padding(.top, 10)
                    }
                    // Only show in case tools is not nil
                    if let tools = self.viewModel.model?.tool {
                        VStack {
                            ProfileDetailHeaderView(
                                title: "Tools"
                            )
                            ProfileDetailSkillView(skill: tools)
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .padding(.top, 10)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
    }
}

#Preview {
    ProfileDetailView(
        viewModel: ProfileDetailView.ViewModel(profileID: "")
    )
}
