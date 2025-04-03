//
//  EmployeeDetailButtonView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct EmployeeDetailButtonView: View {
    
    //MARK: - PROPERTIES -
    
    var image: String = ""
    var color: Color = .black
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        Button(action: {
            self.onPress?()
        }, label: {
            Image(self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundStyle(self.color)
        })
        .frame(width: 40, height: 40)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
    }
}

#Preview {
    EmployeeDetailButtonView()
}
