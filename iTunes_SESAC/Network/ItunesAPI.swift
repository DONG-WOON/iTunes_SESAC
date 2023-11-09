//
//  ItunesAPI.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import Foundation
import RxMoya
import Moya

enum ItunesAPI {
    case search(term: String)
}

extension ItunesAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        return "/search"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        let parameters: [String: Any] = [
            "country": "KR",
            "lang": "ko_kr",
            "entity": "software"
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
