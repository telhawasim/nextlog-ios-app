//
//  EmployeeDetailOptionButtonView.swift
//  Nextlog
//
//  Created by Telha Wasim on 08/04/2025.
//

import SwiftUI

struct EmployeeDetailOptionButtonView: View {
    
    //MARK: - PROPERTIES -
    
    var title: String = ""
    var image: String = ""
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        Button(action: {
            self.onPress?()
        }, label: {
            HStack(spacing: 12) {
                ZStack {
                    Image(self.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: 17)
                        .foregroundStyle(Color.color808080)
                }
                .frame(width: 37, height: 37)
                .background(Color.colorF7F7F7)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                Text(self.title)
                    .font(.getMedium(.h18))
                    .foregroundStyle(Color.black)
                Spacer()
            }
            .contentShape(Rectangle())
        })
    }
}

#Preview {
    EmployeeDetailOptionButtonView()
}
