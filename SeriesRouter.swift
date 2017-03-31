//
//  AniCoreSeriesRouter.swift
//  AniCore
//
//  Created by Kyle Brown on 28/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Alamofire

enum seriesRouter: URLRequestConvertible {
    
    case browseAnime([String: Any])
    
    var method: HTTPMethod {
        switch self {
        case .browseAnime:
            return .get
        }
    }
        
    var path: String {
        switch self {
        case .browseAnime:
            return "/browse/anime"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: APIClient.APIUrl)
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        urlRequest.httpMethod = self.method.rawValue
        
        AniCoreAPISession.sharedInstance.refreshClientToken { (response) in
            guard let token = response else {
                print("We dont have an auth token, so cant do this call")
                return
            }
            
            urlRequest.addValue("Bearer \(AniCoreAPISession.sharedInstance.APIToken)", forHTTPHeaderField: "Authorization")
            
            switch self {
            case .browseAnime(let params):
                do {
                    let _ = try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)
                } catch {
                    print("EXPLOSIOS?!??!?!")
                }
            }
        }
        return urlRequest
    }
}
