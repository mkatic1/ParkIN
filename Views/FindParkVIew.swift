//
//  FindParkVIew.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//

import SwiftUI
import SwiftData
import AVFoundation
import UIKit
import Alamofire
import Foundation


struct FindParkView: View {
    @ObservedObject var viewModel = FindParkViewModel()
    @State private var parkingLot: Int? = nil
    @State private var isNavigationActivePark = false
    @State private var isNavigationActiveSchedule = false
    @State private var isNavigationLoginView = false
    @Binding var parkLotOwner: Bool
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all) // Pozadina
                
                VStack {
                    
                    if parkLotOwner{
                        Button(action: {
                            self.isNavigationActiveSchedule = true
                            
                        }) {
                            Text("Schedule")
                                .padding()
                                .font(.title)
                                .fontWeight(.bold)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .shadow(color: .gray, radius: 20, x: 0, y: 2)
                        }
                        .frame(width: 200, height: 70)
                        .padding(50)
                        
                    }
                    Button(action: {
                        viewModel.findPark() { result in
                            switch result {
                            case .success(let data):
                                print(data)
                                if let json = data as? [String: Any],
                                   let itemsArray = json["items"] as? [[String: Any]] {
                                    print(itemsArray)
                                    var sortedItems: [[String: Any]] {
                                        return itemsArray.sorted {
                                            guard let index1 = $0["index"] as? Int, let index2 = $1["index"] as? Int else {
                                                return false
                                            }
                                            return index1 < index2
                                        }
                                    }
                                    print(sortedItems)
                                    if sortedItems.isEmpty{
                                        print("there is no available parking spot for you")
                                        self.isNavigationLoginView = true
                                    }else{
                                        let closestAvailableLot = sortedItems[0]
                                        print("ClosestAvailableLot is:\(closestAvailableLot)")
                                        self.parkingLot = closestAvailableLot["number"] as? Int
                                    }
                                } else {
                                    print("Error: Items not found or invalid JSON format")
                                }
                                self.isNavigationActivePark = true
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    }) {
                        Text("Find me a parking spot!")
                            .padding()
                            .font(.title)
                            .fontWeight(.bold)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(color: .gray, radius: 20, x: 0, y: 2)

                    }
                    .padding()
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .navigationDestination(isPresented: $isNavigationActivePark) {
                ParkView(parkingLot: $parkingLot)
            }
            .navigationDestination(isPresented: $isNavigationActiveSchedule) {
                ScheduleView()
            }
            .navigationDestination(isPresented: $isNavigationLoginView) {
                LoginView()
            }
        }
    }
    
    
}

//if parklotowner is true button schedule appears

