//
//  ParkedView.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 25.06.2024..
//

import Foundation
import SwiftUI

struct ParkedView: View{
    @Binding var occupiedLot: String
    @ObservedObject var loginViewModel = LoginViewModel()
    @ObservedObject var viewModel = ParkedViewModel()
    @State private var isNavigationFindParkView = false
    var body: some View{
        NavigationStack {
            VStack {
                Text("Your parking lot number is: \(occupiedLot)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    viewModel.endoccupation(occupiedLot: occupiedLot) { result in
                        switch result {
                        case .success(let data):
                            print("data: \(data)")
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                    self.isNavigationFindParkView = true
                }) {
                    Text("End Occupation")
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
        .navigationDestination(isPresented: $isNavigationFindParkView) {
            
            FindParkView(parkLotOwner: $loginViewModel.parkingLotOwner)
        }
    }
    
    
}
//this view appears only when user occupies parking spot and index is sent from the scanview
//what if user occupies parking spot and enters app again later? Information about occupation is not stored. It should appear on finparkview and there should be available button for ending already existing occupation
