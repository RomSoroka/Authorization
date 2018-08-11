//
//  ServerDefaults.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class ServerDefaults {
    private let baseURL: URL
    
    private init() {
         baseURL = URL(string: "https://apiecho.cf/api/")!
    }
    
    private func stetStandartValues(_ request: inout URLRequest) {
        request.timeoutInterval = 5
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
    }
    
    func registerRequest(name: String, email: String, password: String) -> URLRequest {
        let json = ["name": name,
                    "email": email,
                    "password": password]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        let url = baseURL.appendingPathComponent("signup/")

        var request = URLRequest(url: url)
        request.httpBody = jsonData
        stetStandartValues(&request)
        request.httpMethod = "POST"

        return request
    }
    
    func loginRequest(email: String, password: String) -> URLRequest {
        let json = ["email": email,
                    "password": password]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        let url = baseURL.appendingPathComponent("login/")
        
        var request = URLRequest(url: url)
        request.httpBody = jsonData
        stetStandartValues(&request)
        request.httpMethod = "POST"

        return request
    }
    
    func getText(locale: String) -> URLRequest {
        let url = baseURL.appendingPathComponent("get/text/")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "Locale", value: locale)
        ]
        
        var request = URLRequest(url: components.url!)
        stetStandartValues(&request)
        request.setValue("Bearer \(Token.current.token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        return request
    }
    
    func logoutRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent("logout/")
        
        var request = URLRequest(url: url)
        stetStandartValues(&request)
        request.setValue("Bearer \(Token.current.token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        return request
    }
    
    static var shared = ServerDefaults()
}











