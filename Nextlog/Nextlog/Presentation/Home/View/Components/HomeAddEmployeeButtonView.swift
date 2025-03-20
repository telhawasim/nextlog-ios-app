//
//  HomeAddEmployeeButtonView.swift
//  Nextlog
//
//  Created by Telha Wasim on 20/03/2025.
//

import SwiftUI

struct HomeAddEmployeeButtonView: View {
    
    //MARK: - PROPERTIES -
    
    //Normal
    var onPress: (() -> Void)?
    
    //MARK: - VIEWS -
    var body: some View {
        Button(action: {
            self.onPress?()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6.0)
                    .stroke(Color.black, lineWidth: 1.25)
                    .frame(width: 31, height: 31)
                    .foregroundStyle(Color.white)
                Image(ImageEnum.icAddEmployee.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
            }
        })
    }
}

#Preview {
    HomeAddEmployeeButtonView()
}
