//
//  AniCoreAPIResponse.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import PromiseKit
import Mapper

enum APIResult {
    case success([String:Any])
    case failure(String)
}

class APISession {
    
    static let sharedInstance = APISession()

    var APIToken: AniCoreAPIToken?

    public func clientTokenRequest() -> Promise<AniCoreAPIToken> {
        return Promise { fulfill, reject in
            // Check to see if we need to refresh/get a new token
            if !refreshClientToken() {
                fulfill(self.APIToken!)
            }
            
            // Looks like we need to get a new token
            let params: [String : Any] = ["grant_type" : "client_credentials", "client_id" : OAuthClient.clientId as AnyObject, "client_secret" : OAuthClient.clientSecret]
            
            AniCoreAPI.request(endpoint: clientCredRouter.clientCred(params)).then { token -> Void in
                // Do something
                print("Success, we have a token")
                if let aniToken = AniCoreAPIToken.from(token as NSDictionary) {
                    self.APIToken = aniToken
                    fulfill(aniToken)
                }
                reject(APIError.apiError(reason: "Problem with Token json format"))
            }.catch { error in
                // We have a problem
                print("An error getting token occured : " + error.localizedDescription)
                reject(APIError.apiError(reason: error.localizedDescription))
            }
        }
    }
    
    func refreshClientToken() -> Bool {
        guard let token = APIToken else {
            // We dont even have a token... what are you doing here.
            return true
        }
        
        // Just double check we actually have an expire field to work with
        guard let expires = token.expires else {
            return true
        }
        
        // Check if our token has expired yet, if it has request a new one, else just carry on
        let epochDate = Date(timeIntervalSince1970: expires)
        let now = Date()
        
        if epochDate < now {
            return true
        }
        
        return false
    }
    
    public func request(endpoint: URLRequestConvertible) -> Promise<Any> {
        return Promise { fullfil, reject in
            firstly {
               clientTokenRequest()
            }.then { token in
                AniCoreAPI.request(endpoint: endpoint).then { response -> Void in
                    // Do something
                    fullfil(response)
                }.catch { error in
                    // We have a problem
                    print("An error getting token occured : " + error.localizedDescription)
                    reject(APIError.apiError(reason: error.localizedDescription))
                }
            }.catch { (error) in
                reject(APIError.apiError(reason: error.localizedDescription))
            }
        }
    }
}
