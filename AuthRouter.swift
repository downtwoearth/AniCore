//
//  AniCoreAPIRouter.swift
//  AniCore
//
//  Created by Kyle Brown on 28/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//
//  All Client credential calls will happen here to AniList
//

import Foundation
import Alamofire

enum clientCredRouter: URLRequestConvertible {
    
    case clientCred([String: Any])
    
    var method: HTTPMethod {
        switch self {
        case .clientCred:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .clientCred:
            return "/auth/access_token"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: OAuthClient.OAuthURl)
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        urlRequest.httpMethod = self.method.rawValue
        
        switch self {
        case .clientCred(let params):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: params)
        }
    }
}
