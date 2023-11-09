//
//  APIManager.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import Foundation
import Moya
import RxSwift

final class APIManager {
    private let provider = MoyaProvider<ItunesAPI>()
    static let shared = APIManager()
    private init() { }
    
    func search(term: String) -> Single<Response> {
        return provider.rx.request(.search(term: term))
            .debug()
            .filterSuccessfulStatusCodes()
            .map(Response.self)
    }
}
