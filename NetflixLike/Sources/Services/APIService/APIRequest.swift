//
//  APIRequest.swift
//  NetflixLike
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation

class APIRequest<E: Decodable>: Encodable {
    let path: String
    init(path: String) {
        self.path = path
    }
}
