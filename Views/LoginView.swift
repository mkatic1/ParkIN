//
//  LoginView.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//


import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State private var isNavigationActive = false
    @State var parkLotOwner = false
    

    var body: some View {
        NavigationStack {
            VStack {
                Text("Log in")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                        viewModel.login() { result in
                            switch result{
                            case .success(let data):
                                if let json = data as? [String: Any],
                                    let token = json["access_token"] as? String {
                                    self.viewModel.saveToken(token: token)
                                    if let decodePayload = viewModel.JWTDecode(token: viewModel.retrieveToken()!){
                                        if viewModel.hasRole(decodePayload, role: "PARKING_LOT_OWNER"){
                                            parkLotOwner = true
                                            viewModel.parkingLotOwner = true
                                        }else{
                                            parkLotOwner = false
                                            viewModel.parkingLotOwner = false

                                        }
                                    }else{
                                        print("Failed to decode JWT")
                                    }
                                    self.viewModel.isLoggedIn = true
                                    if viewModel.isLoggedIn{
                                        self.isNavigationActive = true
                                    }
                                    
                                    
                                }
                                
                            case .failure(let error):
                                print("Error: \(error)")
                                viewModel.isLoggedIn = false
                                
                            }
                        }
                    }) {
                    Text("Log in")
                        .padding()
                        .fontWeight(.bold)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(color: .gray, radius: 20, x: 0, y: 2)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .navigationDestination(isPresented: $isNavigationActive) {
                
                FindParkView(parkLotOwner: $parkLotOwner)
            }
            
        }
    }
}

//parkLotOwner is value that is type bool
//value parkLotOwner is sent by navigationdestination to another view
