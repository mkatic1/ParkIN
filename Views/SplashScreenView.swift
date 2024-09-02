//
//  SplashView.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 30.06.2024..
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack {
            if isActive {
                LoginView()
            } else {
                VStack {
                    Image("ParkIn_logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                    ProgressView()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

//view that appears when the app is started
//it needs to be fixed
//add picture logo
//problem with assets
