//
//  FindParkViewModel.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//


import SwiftUI
import Combine
import Alamofire

class FindParkViewModel: ObservableObject {
    @Published var parkinglot:Int?=nil
    @ObservedObject var loginViewModel = LoginViewModel()

    func findPark(completion: @escaping (Result<Any, Error>) -> Void) {
        let token = loginViewModel.retrieveToken()!
        let url = "http://localhost:8082/api/V1/lots/nearest-available/page"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "page": 0,
            "size": 10,
            "sort": NSNull(),
            "filters": NSNull()
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
