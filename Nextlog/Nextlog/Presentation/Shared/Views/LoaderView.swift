//
//  LoaderView.swift
//  Nextlog
//
//  Created by Telha Wasim on 03/04/2025.
//

import SwiftUI

struct LoaderView: View {
    
    //MARK: - VARIABLES -
    
    //State
    @State private var degree: Int = 270
    @State private var spinnerLength = 0.6
    
    //MARK: - VIEWS -
    var body: some View {
        // Parent View
        ZStack {
            // Background
            Color(.black)
                .opacity(0.1)
                .ignoresSafeArea()
            // Main View
            VStack {
                // Loader
                Circle()
                    .trim(from: 0.0,to: self.spinnerLength)
                    .stroke(
                        LinearGradient(
                            colors: [.color808080],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(
                            lineWidth: 9.0,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                    .animation(
                        Animation.easeIn(
                            duration: 1.5
                        )
                        .repeatForever(autoreverses: true)
                    )
                    .frame(width: 60,height: 60)
                    .rotationEffect(Angle(degrees: Double(self.degree)))
                    .animation(
                        Animation.linear(
                            duration: 1
                        )
                        .repeatForever(autoreverses: false)
                    )
                    .onAppear{
                        self.degree = 270 + 360
                        self.spinnerLength = 0
                    }
            }
        }
    }
}

#Preview {
    LoaderView()
}
