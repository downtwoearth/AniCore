//
//  AniCoreAPIToken.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Mapper

class AniCoreAPIToken: Mappable {

    var accessToken: String?
    var tokenType: String?
    var expires: Int?
    var expiresIn: Int?
    var refreshToken: String?
    
    /// Define how your custom object is created from a Mapper object
    required init(map: Mapper) throws {
        try accessToken = map.from("access_token")
        try tokenType = map.from("token_type")
        try expires = map.from("expires")
        try expiresIn = map.from("expires_in")
        try refreshToken = map.from("refresh_token")
        print(self)
    } 
}
