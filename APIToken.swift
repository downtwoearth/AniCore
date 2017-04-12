//
//  AniCoreAPIToken.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Mapper

struct AniCoreAPIToken: Mappable {

    var accessToken: String?
    var tokenType: String?
    var expires: TimeInterval?
    var expiresIn: Int?
    var refreshToken: String?
    
    /// Define how your custom object is created from a Mapper object
    init(map: Mapper) throws {
        accessToken = map.optionalFrom("access_token")
        tokenType = map.optionalFrom("token_type")
        expires = map.optionalFrom("expires")
        expiresIn = map.optionalFrom("expires_in")
        refreshToken = map.optionalFrom("refresh_token")
    } 
}
