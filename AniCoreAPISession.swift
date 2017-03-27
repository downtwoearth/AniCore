//
//  AniCoreAPIResponse.swift
//  AniCore
//
//  Created by Kyle Brown on 27/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation

class AniCoreAPISession: NSObject {
    
    static let sharedInstance = AniCoreAPISession()

    var APIToken: AniCoreAPIToken?

    func clientTokenRequest() {
        AniCoreAPI.request(endpoint: EndPoints.ClientCred()) { (response) in
            switch response {
            case .success(let data):
                print(data)
                break
            case .failure(let error):
                print("AAHHHHH No client stuff : " + error.localizedDescription)
                break
            }
        }
    }
}
