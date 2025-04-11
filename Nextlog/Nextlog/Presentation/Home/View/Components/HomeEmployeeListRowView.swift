//
//  HomeEmployeeListRowView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct HomeEmployeeListRowView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var employee: EmployeeListRowResponse
    //State
    @State var userImage: UIImage? = nil
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        HStack(spacing: 15) {
            // User Image
            if let image = self.userImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 73, height: 73)
                    .clipShape(Circle())
            } else {
                Circle()
                    .foregroundStyle(Color.colorF7F7F7)
                    .frame(width: 73)
                    .overlay(
                        ProgressView()
                    )
            }
            // Name, Designation and Email
            VStack(alignment: .leading, spacing: 8) {
                // Name
                Text(self.employee.name ?? "")
                    .font(.getBold(.h18))
                // Designation
                Text(self.employee.designation?.name ?? "")
                    .font(.getMedium())
                    .foregroundStyle(Color.color808080)
                // Email
                Text(verbatim: self.employee.email ?? "")
                    .font(.getMedium())
            }
            // Spacer
            Spacer()
            Image(systemName: ImageEnum.icChevronRight.rawValue)
        }
        .padding(.horizontal, 4)
        .contentShape(Rectangle())
        .task {
            let url = APIEndpoint.baseURL + (self.employee.avatar ?? "")
            Utilities.shared.fetchImage(from: url) { image in
                if let userImage = image {
                    self.userImage = userImage
                } else {
                    self.userImage = UIImage(named: ImageEnum.icUserPlaceholder.rawValue)
                }
            }
        }
    }
}

#Preview {
    HomeEmployeeListRowView(
        employee: EmployeeListRowResponse()
    )
}
