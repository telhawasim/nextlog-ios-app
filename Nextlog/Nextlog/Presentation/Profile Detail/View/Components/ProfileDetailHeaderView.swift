//
//  ProfileDetailHeaderView.swift
//  Nextlog
//
//  Created by Telha Wasim on 09/04/2025.
//

import SwiftUI

struct ProfileDetailHeaderView: View {
    
    //MARK: - PROPERTIES -
    
    var title: String = "Work Experience"
    
    //MARK: - VIEWS -
    var body: some View {
        Text(self.title)
            .font(.getSemibold(.h26))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 7)
    }
}

#Preview {
    ProfileDetailHeaderView()
}
