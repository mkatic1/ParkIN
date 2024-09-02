//
//  PopupVIew.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//

import SwiftUI
import SwiftData
import AVFoundation
import UIKit

struct PopupView: View {
    @Binding var isShowingPopup: Bool

    var body: some View {
        VStack {
            Spacer()
            Text("Pop-up sa slikom")
            Image("image2.pgn")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Button(action: {
                self.isShowingPopup = false
            }) {
                Text("Zatvori")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.purple)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .padding()
        .onTapGesture {
            self.isShowingPopup = false
        }
    }
}

//missing picture of a parking lot with marked parking spot app found for the user
