//
//  Token.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

struct SignUPResonce {
    let accessToken: String
}

//MARK: Decoding
extension SignUPResonce: Decodable {
    private struct SuccessData: Decodable {
        let accessToken: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(from decoder: Decoder) throws {
        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
        
        let data = try conteiner.decode(SuccessData.self, forKey: .data)
        accessToken = data.accessToken
    }
}
