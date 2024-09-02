//
//  ScheduleVIew.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//


import Foundation
import SwiftUI

struct ScheduleView: View{
    @ObservedObject var schedulemodel = ScheduleViewModel()
    @ObservedObject var loginViewModel = LoginViewModel()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State var isNavigationActiveFindPark = false

    var body: some View{
        NavigationStack {
            VStack {
                Text("Schedule")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                VStack{
                    DatePicker("Start Time", selection: $startTime)
                        .padding(10)
                        .font(.title2)
                        .foregroundColor(.black)
                        .accentColor(.purple)
                        
                }
                .background(.white)
                .padding()
                VStack{
                    DatePicker("End Time", selection: $endTime)
                        .padding(10)
                        .font(.title2)
                        .foregroundColor(.black)
                        .accentColor(.purple)
                }
                .background(.white)
                .padding()
                Button(action: {
                    schedulemodel.startTime = startTime
                    schedulemodel.endTime = endTime
                    schedulemodel.createschedule(){
                        result in
                        switch result{
                        case .success(let data):
                            
                            print("Scehdule prosa:\(data)")
                            self.isNavigationActiveFindPark = true
                            
                        case .failure(let error):
                            print("Error: \(error)")
                            
                        }
                    }
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 20, x: 0, y: 2)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            }
        
        .navigationDestination(isPresented: $isNavigationActiveFindPark) {
            
            FindParkView(parkLotOwner: $loginViewModel.parkingLotOwner)
        }
    }
}


