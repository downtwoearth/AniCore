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
        
        AniCoreAPISession.sharedInstance.refreshClientToken() { (response) in
            guard response != nil else {
                print("Somehow this is still nil, so just show plain error")
                return urlRequest
            }
            
            urlRequest.addValue("Bearer \(AniCoreAPISession.sharedInstance.APIToken)", forHTTPHeaderField: "Authorization")
            
            switch self {
            case .browseAnime(let params):
                return try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)
            }
        }
    }
}
