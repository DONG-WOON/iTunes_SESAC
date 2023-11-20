//
//  APIManager.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import Foundation
import Moya
import RxSwift

enum CustomError: Error {
    case hey
    case decodingError
}

final class APIManager {
    private let provider = MoyaProvider<ItunesAPI>()
    static let shared = APIManager()
    private init() { }
    
    func search(term: String) -> Single<Result<ItunesResponse, CustomError>> {
        return provider.rx.request(ItunesAPI())
            .debug()
            .map { self.handle($0) }
    }
    
    func handle<T: Codable>(_ response: Response) -> Result<T, CustomError> {
        switch response.statusCode {
        case 200...299:
            guard let decodedData = try? JSONDecoder().decode(T.self, from: response.data) else { return .failure(.decodingError) }
            return .success(decodedData)
        case 404:
            return .failure(.hey)
        default:
            return .failure(.hey)
        }
    }
}
