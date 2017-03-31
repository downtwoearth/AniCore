//
//  AniCoreAPIResponse.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation

class AniCoreAPISession {
    
    static let sharedInstance = AniCoreAPISession()

    var APIToken: AniCoreAPIToken?

    func clientTokenRequest(completionHandler: @escaping (AniCoreAPIToken?) -> Void) {
        let params: [String : Any] = ["grant_type" : "client_credentials", "client_id" :  OAuthClient.clientId as AnyObject, "client_secret" : OAuthClient.clientSecret]
        AniCoreAPI.request(endpoint: clientCredRouter.clientCred(params)) { (response) in
            switch response {
            case .success(let data):
                self.APIToken = AniCoreAPIToken.from(data as! NSDictionary)
                break
            case .failure(let error):
                print("AAHHHHH No client stuff : " + error.localizedDescription)
                self.APIToken = nil
                break
            }
        }
    }
    
    func refreshClientToken(completionHandler: @escaping (AniCoreAPIToken?) -> Void) {
        guard let token = APIToken else {
            // We dont even have a token... what are you doing here.
            clientTokenRequest(completionHandler: { (response) in
                print("coool")
            })
            completionHandler(APIToken)
            return
        }
        
        // Just double check we actually have an expire field to work with
        guard let expires = token.expires else {
            clientTokenRequest(completionHandler: { (response) in
                print("It didnt have an expire field")
            })
            completionHandler(APIToken)
            return
        }
        
        // Check if our token has expired yet, if it has request a new one, else just carry on
        let epochDate = Date(timeIntervalSince1970: expires)
        let now = Date()
        
        if epochDate < now {
            clientTokenRequest(completionHandler: { (response) in
                print("The token had expired")
            })
        }
        
        completionHandler(APIToken)
    }
}
