//
//  CustomTabbarView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct CustomTabbarView: View {
    
    //MARK: - PROPERTIES -
    
    //Binding
    @Binding var selectedTab: TabbarType
    
    //MARK: - VIEW -
    var body: some View {
        // Parent View
        HStack {
            // Home Tabbar
            CustomTabbarButtonView(
                tabType: .home,
                isSelected: self.selectedTab == .home,
                onPress: {
                    self.selectedTab = .home
                }
            )
            // Spacer
            Spacer()
            // Employees Tabbar
            CustomTabbarButtonView(
                tabType: .employees,
                isSelected: self.selectedTab == .employees,
                onPress: {
                    self.selectedTab = .employees
                }
            )
            // Spacer
            Spacer()
            // Logout Tabbar
            CustomTabbarButtonView(
                tabType: .logout,
                isSelected: self.selectedTab == .logout,
                onPress: {
                    self.selectedTab = .logout
                }
            )
        }
        .padding(.horizontal, 40)
        .frame(height: 65)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(radius: 8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    CustomTabbarView(
        selectedTab: Binding.constant(.employees)
    )
}
