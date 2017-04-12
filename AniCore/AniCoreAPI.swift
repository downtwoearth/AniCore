//
//  ACAPIRequest.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum APIError: Error {
    case objectSerialization(reason: String)
    case apiError(reason: String)
}

struct AniCoreAPI {
    
    public static func request(endpoint: URLRequestConvertible) -> Promise<[String: AnyObject]> {
        return Promise { fulfill, reject in
            Alamofire.request(endpoint).validate().responseJSON { (response) in
                // Check if we got an error for some reason
                guard response.result.error == nil else {
                    print("Error in API call")
                    reject(response.result.error!)
                    return
                }
                
                // If we dont get a JSON response, we dont want it.
                guard let json = response.value as? [String: AnyObject] else {
                    print("Not a json response, abort abort!")
                    reject(APIError.objectSerialization(reason: "Not a json array"))
                    return
                }
                
                // Everything should be good?...lets send it back
                fulfill(json)
            }
        }
    }
}
