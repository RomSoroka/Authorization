//
//  Token.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class Token {
    private let userDefaultsName = "token"
    var token: String? {
        didSet {
            UserDefaults.standard.set(token, forKey: userDefaultsName)
        }
    }
    
    private init() {
        token = UserDefaults.standard.value(forKeyPath: "token") as? String
    }
    
    static var current = Token()
}
