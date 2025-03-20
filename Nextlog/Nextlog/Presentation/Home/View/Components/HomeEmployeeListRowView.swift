//
//  HomeEmployeeListRowView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct HomeEmployeeListRowView: View {
    
    //MARK: - PROPERTIES -
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        HStack(spacing: 15) {
            // User Image
            Circle()
                .frame(width: 73)
            // Name, Designation and Email
            VStack(alignment: .leading, spacing: 8) {
                // Name
                Text("Telha Wasim")
                    .font(.getBold(.h18))
                // Designation
                Text("iOS Developer")
                    .font(.getMedium())
                    .foregroundStyle(Color.color808080)
                // Email
                Text(verbatim: "telha.wasim@nxb.com.pk")
                    .font(.getMedium())
            }
            // Spacer
            Spacer()
            Image(systemName: ImageEnum.icChevronRight.rawValue)
        }
        .padding(.horizontal, 4)
        .contentShape(Rectangle())
    }
}

#Preview {
    HomeEmployeeListRowView()
}
