//
//  ReportIntruderView.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//


import Foundation
import SwiftUI

struct ReportIntruderView: View{
    
    var body: some View{
        NavigationStack {
            VStack {
                Button(action: {
                    
                }) {
                    Text("Send to admin")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            }
    }
}

//this view needs to have ability of taking picture that will be sent to admin
