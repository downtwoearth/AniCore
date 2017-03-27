//
//  ACAPIRequest.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Alamofire

class ACAPI {
    
    let aniListAPIURl = ""
    let aniListAPIKey = ""
    
    public enum EndPoints {
        case Series()
        
        public var method: HTTPMethod {
            switch self {
            case .Series:
                return .get
            }
        }
    }
    
}
