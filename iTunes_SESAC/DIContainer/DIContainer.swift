//
//  DIContainer.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import Foundation

final class DIContainer {
    static func makeViewModel<ViewModel: ViewModelProtocol>(_ viewModel: ViewModel) -> ViewModel {
        return viewModel
    }
}
