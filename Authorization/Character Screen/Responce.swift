//
//  Responce.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

enum RespoceError: Error {
    case unknown
}

enum Responce<Entity> {
    case success(Entity)
    case error(Error)
}
