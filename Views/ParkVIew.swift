//
//  ParkVIew.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//

import SwiftUI
import SwiftData
import AVFoundation
import UIKit


struct ParkView: View {
    @Binding var parkingLot: Int?
    @State private var isShowingPopup = false
    @State private var isNavigationActiveScan = false
    @State private var isNavigationActiveInturder = false
    @State private var isNavigationActiveFindPark = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if let parkingLot = parkingLot {
                    Text("Nearest available parking spot is: \(parkingLot)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Button(action: {self.isShowingPopup.toggle()}) {
                        Text("Where is my parking spot?")
                            .frame(width: 120, height: 60)
                            .padding()
                            .fontWeight(.bold)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .gray, radius: 20, x: 0, y: 2)
                    }
                    .sheet(isPresented: $isShowingPopup){
                        PopupView(isShowingPopup: self.$isShowingPopup)
                        
                    }
                    Button(action: {
                        self.isNavigationActiveScan = true
                    }, label: {
                        Text("I have parked.")
                    }).frame(width: 120, height: 60)
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 20, x: 0, y: 2)
                    Button(action: {
                        self.isNavigationActiveInturder = true
                    }, label: {
                        Text("Someone is already parked here.")
                    }).frame(width: 120, height: 80)
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 20, x: 0, y: 2)
                    Button(action: {}, label: {
                        Text("Find me another one.")
                    }).frame(width: 120, height: 70)
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 20, x: 0, y: 2)
                }else {
                    Text("There's no available parking lot.")
                }
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationDestination(isPresented: $isNavigationActiveScan){ScanView()}
        .navigationDestination(isPresented: $isNavigationActiveInturder){ReportIntruderView()}
        
    }
}



