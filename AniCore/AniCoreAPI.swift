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

public enum EndPoints {
    case ClientCred()
    case GetAnime()
    
    public var method: HTTPMethod {
        switch self {
        case .ClientCred():
            return .post
        case .GetAnime:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .ClientCred:
            return OAuthClient.OAuthURl + "/auth/access_token"
        case .GetAnime:
            return APIClient.APIUrl + "/anime"
        }
    }
    
    public var parameters: [String : AnyObject] {
        switch self {
        case .ClientCred:
            return ["grant_type" : "client_credentials" as AnyObject, "client_id" :  OAuthClient.clientId as AnyObject, "client_secret" : OAuthClient.clientSecret as AnyObject]
        case .GetAnime:
            return ["" : "" as AnyObject]
        }
    }
}

class AniCoreAPI {
    
    public static func request(endpoint: EndPoints, completionHandler: @escaping (Result<Any>) -> Void) {
         Alamofire.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
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
