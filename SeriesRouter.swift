//
//  AniCoreSeriesRouter.swift
//  AniCore
//
//  Created by Kyle Brown on 28/03/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol router: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
}

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
        
        if let token = APISession.sharedInstance.APIToken?.accessToken {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
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
