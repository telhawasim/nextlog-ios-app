//
//  CreateProfileView.swift
//  Nextlog
//
//  Created by Telha Wasim on 05/04/2025.
//

import SwiftUI

struct CreateProfileView: View {
    
    //MARK: - PROPERTIES -
    
    //EnvironmentObject
    @EnvironmentObject private var router: Routing
    //StateObject
    @StateObject var viewModel: CreateProfileView.ViewModel
    //State
    @State var selectedCategory: CategoryType = .education
    @State var currentCompany: String = ""
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        VStack(spacing: 0) {
            // Title and Button
            HStack {
                // Title
                Text("Create Profile")
                    .font(.getMedium(.h24))
                // Spacer
                Spacer()
                // Back Button
                Button(action: {
                    
                }, label: {
                    Image(ImageEnum.icCross.rawValue)
                        .resizable()
                        .frame(width: 20, height: 20)
                })
            }
            // Categories
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(CategoryType.allCases, id: \.self) { category in
                            CreateProfileCategoryView(
                                title: category.rawValue,
                                isSelected: self.selectedCategory == category
                            )
                            .id(category)
                        }
                    }
                }
                .disabled(true)
                .frame(height: 37)
                .padding(.top, 25)
                .onChange(of: self.selectedCategory) { (oldValue, newValue) in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
            // Main Content
            ScrollViewReader { proxy in
                // Scroll View
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        switch self.selectedCategory {
                        case .info:
                            // Title
                            CreateProfileHeaderView(
                                title: "Basic Info"
                            )
                            // TextFields
                            LazyVStack(spacing: 20) {
                                // Name Textfield
                                CreateProfileNameTextField(
                                    value: self.$viewModel.basicInfo.name
                                )
                                // Designation Textfield
                                AddEmployeeDesignationTextField(
                                    value: self.$viewModel.basicInfo.designation,
                                    isDesignation: true,
                                    onPress: {
                                        
                                    }
                                )
                                // Email Textfield
                                CreateProfileEmailTextField(
                                    value: self.$viewModel.basicInfo.email
                                )
                                // Phone Textfield
                                AddEmployeePhoneTextField(
                                    value: self.$viewModel.basicInfo.phone
                                )
                                // GitHub Textfield
                                CreateProfileLinkTextField(
                                    value: self.$viewModel.basicInfo.github,
                                    isGit: true
                                )
                                // LinkedIn Textfield
                                CreateProfileLinkTextField(
                                    value: self.$viewModel.basicInfo.linkedin,
                                    isGit: false
                                )
                            }
                            .padding(.top, 20)
                            CreateProfileHeaderView(
                                title: "Summary"
                            )
                            .padding(.top, 20)
                            CreateProfileSummaryTextField(
                                value: self.$viewModel.basicInfo.summary,
                                placeholder: "Write Here..."
                            )
                            .padding(.top, 30)
                        case .experience:
                            // Current Experience Header
                            CreateProfileHeaderView(
                                title: "Current Experience"
                            )
                            // Current Experience
                            CreateProfileExperienceView(
                                experience: self.$viewModel.currentCompany,
                                isCurrentExperience: true, index: 0
                            )
                            .padding(.top, 20)
                            // Previous Experience Header
                            CreateProfileHeaderView(
                                title: "Previous Experience"
                            )
                            .padding(.top, 20)
                            // In case previous experience is empty
                            if (self.viewModel.previousExperience.isEmpty) {
                                // Empty State
                                AppEmptyState(
                                    emptyState: .previousExperience,
                                    onPress: {
                                        self.scrollViewToNewlyAddedExperience(proxy)
                                    }
                                )
                            } else {
                                LazyVStack(spacing: 20) {
                                    // Previous Experience Listing
                                    ForEach(self.viewModel.previousExperience.indices, id: \.self) { index in
                                        CreateProfileExperienceView(
                                            experience: self.$viewModel.previousExperience[index],
                                            index: index,
                                            onPressDelete: {
                                                self.deleteTheExperience(index)
                                            }
                                        )
                                        .id("education_\(index)")
                                    }
                                    // Only show add more button when '0...2' previous experience
                                    if (self.viewModel.previousExperience.count <= 2) {
                                        // Add More Button
                                        CreateProfileAddMoreView(
                                            onPress: {
                                                self.scrollViewToNewlyAddedExperience(proxy)
                                            }
                                        )
                                        .padding(.vertical, 10)
                                    }
                                }
                                .padding(.top, 15)
                            }
                        case .education:
                            // Qualification Header
                            CreateProfileHeaderView(
                                title: "Qualifications"
                            )
                            // Education Listing
                            LazyVStack(spacing: 20) {
                                ForEach(self.viewModel.education.indices, id: \.self) { index in
                                    CreateProfileEducationView(
                                        education: self.$viewModel.education[index],
                                        isFirst: index == 0,
                                        index: index,
                                        onPressDelete: {
                                            self.deleteTheEducation(index)
                                        }
                                    )
                                    .id("qualification_\(index)")
                                }
                            }
                            .padding(.top, 20)
                            // Only show Add more Button if count is '<=2'
                            if (self.viewModel.education.count <= 2) {
                                // Add More Button
                                CreateProfileAddMoreView(
                                    onPress: {
                                        self.scrollToNewlyAddedEducation(proxy)
                                    }
                                )
                                    .padding(.top, 20)
                            }
                            // Certificates Header
                            CreateProfileHeaderView(
                                title: "Training & Certifications"
                            )
                            .padding(.top, 20)
                            // In case certificates is empty
                            if (self.viewModel.certificates.isEmpty) {
                                // Empty State
                                AppEmptyState(
                                    emptyState: .certificate,
                                    onPress: {
                                        self.scrollToNewlyAddedCertificates(proxy)
                                    }
                                )
                            } else {
                                LazyVStack(spacing: 20) {
                                    // Certificates Listing
                                    ForEach(self.viewModel.certificates.indices, id: \.self) { index in
                                        CreateProfileCertificateView(
                                            certificate: self.$viewModel.certificates[index],
                                            index: index,
                                            onPressDelete: {
                                                self.deleteTheCertificates(index)
                                            }
                                        )
                                        .id("certificate_\(index)")
                                    }
                                    // Only show add more button when '0...2' certificates
                                    if (self.viewModel.certificates.count <= 2) {
                                        // Add More Button
                                        CreateProfileAddMoreView(
                                            onPress: {
                                                self.scrollToNewlyAddedCertificates(proxy)
                                            }
                                        )
                                        .padding(.vertical, 10)
                                    }
                                }
                                .padding(.top, 15)
                            }
                            // Awards Header
                            CreateProfileHeaderView(title: "Awards & Honors")
                                .padding(.top, 20)
                            // In case awards are empty
                            if (self.viewModel.awards.isEmpty) {
                                // Empty State
                                AppEmptyState(
                                    emptyState: .awards,
                                    onPress: {
                                        self.scrollToNewlyAddedAwards(proxy)
                                    }
                                )
                            } else {
                                LazyVStack(spacing: 20) {
                                    // Awards Listing
                                    ForEach(self.viewModel.awards.indices, id: \.self) { index in
                                        CreateProfileAwardView(
                                            awards: self.$viewModel.awards[index],
                                            index: index,
                                            onPressDelete: {
                                                self.deleteTheAwards(index)
                                            }
                                        )
                                        .id("award_\(index)")
                                    }
                                    // Only show add more button when '0...2' awards
                                    if (self.viewModel.awards.count <= 2) {
                                        // Add More Button
                                        CreateProfileAddMoreView(
                                            onPress: {
                                                self.scrollToNewlyAddedAwards(proxy)
                                            }
                                        )
                                        .padding(.vertical, 10)
                                    }
                                }
                                .padding(.top, 15)
                            }
                        case .skills:
                            EmptyView()
                        case .projects:
                            EmptyView()
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.top, 10)
            }
            // Buttons
            HStack(spacing: 15) {
                if !(self.selectedCategory == .info) {
                    // Previous Button
                    Button(action: {
                        self.previousButtonAction()
                    }, label: {
                        Text("Previous")
                            .font(.getMedium(.h18))
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.black)
                            )
                    })
                }
                // Save Button
                AppCustomButton(
                    title: "Save & Continue",
                    onPress: {
                        self.saveButtonAction()
                    }
                )
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .animation(.default, value: self.selectedCategory)
        .animation(.default, value: self.viewModel.previousExperience.count)
        .animation(.default, value: self.viewModel.education.count)
        .animation(.default, value: self.viewModel.certificates.count)
        .animation(.default, value: self.viewModel.awards.count)
    }
}

//MARK: - FUNCTIONS -
extension CreateProfileView {
    
    //MARK: - PREVIOUS BUTTON ACTION -
    private func previousButtonAction() {
        switch self.selectedCategory {
        case .info:
            break
        case .experience:
            self.selectedCategory = .info
        case .education:
            self.selectedCategory = .experience
        case .skills:
            self.selectedCategory = .education
        case .projects:
            self.selectedCategory = .skills
        }
    }
    
    //MARK: - SAVE BUTTON ACTION -
    private func saveButtonAction() {
        switch self.selectedCategory {
        case .info:
            self.selectedCategory = .experience
        case .experience:
            self.selectedCategory = .education
        case .education:
            self.selectedCategory = .skills
        case .skills:
            self.selectedCategory = .projects
        case .projects:
            break
        }
    }
    
    //MARK: - SCROLL VIEW TO NEWLY ADDED EXPERIENCE -
    private func scrollViewToNewlyAddedExperience(_ proxy: ScrollViewProxy) {
        var index: Int
        
        self.viewModel.addPreviousExperience()
        
        index = self.viewModel.previousExperience.count - 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                proxy.scrollTo("education_\(index)", anchor: .top)
            }
        }
    }
    
    //MARK: - SCROLL TO NEWLY ADDED EDUCATION -
    private func scrollToNewlyAddedEducation(_ proxy: ScrollViewProxy) {
        var index: Int
        
        self.viewModel.addEducation()
        
        index = self.viewModel.education.count - 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                proxy.scrollTo("qualification_\(index)", anchor: .top)
            }
        }
    }
    
    //MARK: - SCROLL TO NEWLY ADDED CERTIFICATES -
    private func scrollToNewlyAddedCertificates(_ proxy: ScrollViewProxy) {
        var index: Int
        
        self.viewModel.addCertificates()
        
        index = self.viewModel.certificates.count - 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                proxy.scrollTo("certificate_\(index)", anchor: .top)
            }
        }
    }
    
    //MARK: - SCROLL TO NEWLY ADDED AWARDS -
    private func scrollToNewlyAddedAwards(_ proxy: ScrollViewProxy) {
        var index: Int
        
        self.viewModel.addAwards()
        
        index = self.viewModel.awards.count - 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                proxy.scrollTo("award_\(index)", anchor: .top)
            }
        }
    }
    
    //MARK: - DELETE THE EXPERIENCE -
    private func deleteTheExperience(_ index: Int) {
        self.viewModel.previousExperience.remove(at: index)
    }
    
    //MARK: - DELETE THE EDUCATION -
    private func deleteTheEducation(_ index: Int) {
        self.viewModel.education.remove(at: index)
    }
    
    //MARK: - DELETE THE CERTIFICATES -
    private func deleteTheCertificates(_ index: Int) {
        self.viewModel.certificates.remove(at: index)
    }
    
    //MARK: - DELETE THE AWARDS -
    private func deleteTheAwards(_ index: Int) {
        self.viewModel.awards.remove(at: index)
    }
}

#Preview {
    CreateProfileView(
        viewModel: CreateProfileView.ViewModel()
    )
}
