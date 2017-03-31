//
//  ACAPIRequest.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case objectSerialization(reason: String)
}

struct AniCoreAPI {
    
    public static func request(endpoint: URLRequestConvertible, completionHandler: @escaping (Result<Any>) -> Void) {
            Alamofire.request(endpoint).validate().responseJSON { (response) in
                // Check if we got an error for some reason
                guard response.result.error == nil else {
                    print("Error in API call")
                    completionHandler(Result.failure(response.result.error!))
                    return
                }
                
                // If we dont get a JSON response, we dont want it.
                guard let json = response.value as? [String: AnyObject] else {
                    print("Not a json response, abort abort!")
                    completionHandler(Result.failure(APIError.objectSerialization(reason: "Not a json array")))
                    return
                }
                
                // Everything should be good?...lets send it back
                completionHandler(Result.success(json))
        }
    }
}
