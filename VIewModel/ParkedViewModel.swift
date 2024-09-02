//
//  ParkedViewModel.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 25.06.2024..
//

import SwiftUI
import Combine
import Alamofire

class ParkedViewModel: ObservableObject {
    @ObservedObject var loginViewModel = LoginViewModel()

    
    func endoccupation(occupiedLot:String,completion: @escaping (Result<Any, Error>) -> Void) {
        
        let token = loginViewModel.retrieveToken()!
       
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "accept": "application/json"
        ]
        
        
        AF.request("http://localhost:8082/api/V1/occupations/\(occupiedLot)",method: .put,headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
                print("success")
            case .failure(let error):
                completion(.failure(error))
                print("failure")
            }
        }
    }
    
}

