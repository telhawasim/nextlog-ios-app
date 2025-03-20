//
//  EmployeeDetailCVListView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct EmployeeDetailCVListView: View {
    
    //MARK: - PROPERTIES -
    
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
                Text("Resume # 1")
                    .font(.getBold(.h20))
                // Profile
                Text("iOS Developer")
                    .font(.getSemibold(.h18))
                // Date
                Text("Thursday, 12th March 2025")
                    .font(.getRegular(.h16))
            }
            // Spacer
            Spacer()
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .overlay(
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(Color.black.opacity(0.5))
        )
    }
}

#Preview {
    EmployeeDetailCVListView()
}
