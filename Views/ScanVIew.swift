//
//  ScanVIew.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//
import Foundation
import SwiftUI

struct ScanView: View{
    @ObservedObject var viewModel = ScanViewModel()
    @ObservedObject var loginViewModel = LoginViewModel()
    @State private var isNavigationParkedView = false
    
    var body: some View{
        NavigationStack {
            VStack {
                TextField("Parking index", text: $viewModel.occupiedLot)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                Button(action: {
                    viewModel.occupylot(){
                        result in
                        switch result{
                        case .success(let data):
                            
                            print("data: \(data)")
                            
                        case .failure(let error):
                            print("Error: \(error)")
                            
                        }
                    }
                    self.isNavigationParkedView = true
                    
                }) {
                    Text("Park here")
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
        .navigationDestination(isPresented: $isNavigationParkedView) {
            
            ParkedView(occupiedLot: $viewModel.occupiedLot)
        }
    }
}


//there is textfield where the user should type index of parking spot they occupy
//instead of that textfield, camera should appear and the user should scan QR-code of a parking spot where they parked (that QRcode contains index of a parking spot)

