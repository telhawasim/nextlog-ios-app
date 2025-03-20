//
//  CustomTabbarButtonView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct CustomTabbarButtonView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var tabType: TabbarType
    var isSelected: Bool = false
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        Button(action: {
            self.onPress?()
        }, label: {
            ZStack {
                Circle()
                    .frame(width: 48)
                    .foregroundStyle(self.isSelected ? Color.color808080 : .clear)
                Image(self.tabType.getImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(self.isSelected ? .white : .black)
                    .frame(width: 24, height: 24)
            }
        })
    }
}

#Preview {
    CustomTabbarButtonView(
        tabType: .home
    )
}
