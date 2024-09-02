//
//  ScheduleViewModel.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 22.06.2024..
//

import SwiftUI
import Combine
import Alamofire

class ScheduleViewModel: ObservableObject {
    @ObservedObject var loginViewModel = LoginViewModel()
    @Published var startTime = Date()
    @Published var endTime = Date()
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.timeZone = TimeZone.current
            formatter.locale = Locale.current
            return formatter
        }()
    
    func createschedule(completion: @escaping (Result<Any, Error>) -> Void) {

        let token = loginViewModel.retrieveToken()!
        let url = "http://localhost:8082/api/V1/schedules"
        let headers: HTTPHeaders = [
                "accept": "application/json",
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        let parameters: [String: String] = [
            "startTime" : "\(dateFormatter.string(from: startTime))",
            "endTime" : "\(dateFormatter.string(from: endTime))"
        ]
        AF.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.default,headers: headers).responseJSON { response in
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
