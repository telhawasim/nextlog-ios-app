//
//  EmployeeDetailCVListShimmerView.swift
//  Nextlog
//
//  Created by Telha Wasim on 01/04/2025.
//

import SwiftUI

struct EmployeeDetailCVListShimmerView: View {
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        HStack(spacing: 15) {
            // Background and Logo
            ShimmerEffect()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            // Information
            VStack(alignment: .leading, spacing: 10) {
                // Title
                ShimmerEffect()
                    .frame(width: 100, height: 17)
                    .clipShape(Capsule())
                // Profile
                ShimmerEffect()
                    .frame(width: 100, height: 17)
                    .clipShape(Capsule())
                // Date
                ShimmerEffect()
                    .frame(width: 150, height: 17)
                    .clipShape(Capsule())
            }
            // Spacer
            Spacer()
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .overlay(
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(Color.black.opacity(0.1))
        )
    }
}

#Preview {
    EmployeeDetailCVListShimmerView()
}
