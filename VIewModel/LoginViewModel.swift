//
//  LoginViewModel.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
//


import SwiftUI
import Combine
import Alamofire

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var client_id: String = "park-in-client"
    @Published var grant_type: String = "password"
    @Published var scope: String = "openid"
    @Published var isLoggedIn: Bool = false
    @Published var parkingLotOwner: Bool = false
    func login( completion: @escaping (Result<Any, Error>) -> Void) {
        let parameters: [String: String] = [
                    "client_id": client_id,
                    "grant_type": grant_type,
                    "scope": scope,
                    "password": password,
                    "username": username
        
                ]
        AF.request("http://localhost:8080/realms/park-in/protocol/openid-connect/token",method: .post,parameters: parameters).responseJSON { response in
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
    
//saving token on a keychain
    func saveToken(token: String) {
        let service = "maurer.Park-In.Service"
        let account = "userToken"
        if let tokenData = token.data(using: .utf8) {
            let status = KeychainHelper.save(service: service, account: account, data: tokenData)
            if status == errSecSuccess {
                print("Token saved successfully")
            } else {
                print("Error saving token: \(status)")
            }
        }
    }
    
    //retriveing token from keychain
    func retrieveToken() -> String? {
        let service = "maurer.Park-In.Service"
        let account = "userToken"
        if let tokenData = KeychainHelper.retrieve(service: service, account: account) {
            return String(data: tokenData, encoding: .utf8)
        }
        return nil
    }
    
    func JWTDecode(token: String)->[String:Any]?{
        
        let parts = token.components(separatedBy: ".")
        if parts.count != 3 { fatalError("jwt is not valid!") }
        let payload = parts[1]
        if let payloadDecoded = decodeJWTPart(part: payload){
            return payloadDecoded
        }else{
            return nil
        }
        
        
    }
    func decodeBase64Url(_ base64Url: String) -> Data? {
        var base64 = base64Url
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        while base64.count % 4 != 0 {
            base64.append("=")
        }
        
        return Data(base64Encoded: base64)
    }
    
    func base64StringWithPadding(encodedString: String) -> String {
        var stringTobeEncoded = encodedString.replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let paddingCount = encodedString.count % 4
        for _ in 0..<paddingCount {
            stringTobeEncoded += "="
        }
        return stringTobeEncoded
    }
    func decodeJWTPart(part: String) -> [String: Any]? {
        guard let decodedData = decodeBase64Url(part) else { return nil }
        
        do {
            let json = try JSONSerialization.jsonObject(with: decodedData, options: [])
            return json as? [String: Any]
        } catch {
            print("Error decoding JWT part: \(error)")
            return nil
        }
    }
    

    //function that checks if there is some role in roles
    func hasRole(_ payload: [String: Any], role: String) -> Bool {
        if let realmAccess = payload["realm_access"] as? [String: Any],
           let roles = realmAccess["roles"] as? [String]{
            return roles.contains(role)
        }
        return false
    }
    
    
}
    

