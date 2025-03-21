//
//  HomeEmployeeListRowShimmerView.swift
//  Nextlog
//
//  Created by Telha Wasim on 21/03/2025.
//

import SwiftUI

struct HomeEmployeeListRowShimmerView: View {
    
    //MARK: - VIEWS -
    var body: some View {
        HStack(spacing: 15) {
            // User Image Shimmer
            ShimmerEffect()
                .frame(width: 73, height: 73)
                .clipShape(Circle())
            // Name, Designation and Email Shimmer
            VStack(alignment: .leading, spacing: 8) {
                // Name Shimmer
                ShimmerEffect()
                    .frame(width: 100, height: 17)
                    .clipShape(Capsule())
                // Designation Shimmer
                ShimmerEffect()
                    .frame(width: 100, height: 17)
                    .clipShape(Capsule())
                // Email Shimmer
                ShimmerEffect()
                    .frame(width: 150, height: 17)
                    .clipShape(Capsule())
            }
            // Spacer
            Spacer()
            // Icon Shimmer
            ShimmerEffect()
                .frame(width: 20, height: 17)
                .clipShape(Capsule())
        }
        .padding(.horizontal, 4)
        .contentShape(Rectangle())
    }
}

#Preview {
    HomeEmployeeListRowShimmerView()
}
