//
//  ViewModelProtocol.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
