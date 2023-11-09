//
//  SearchViewModel.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import Foundation
import RxSwift

final class SearchViewModel: ViewModelProtocol {
    struct Input {
        let searchText: Observable<String?>
        let searchButtonDidTapped: Observable<Void>
    }
    
    struct Output {
        let loadResult: PublishSubject<Response>
    }
    
    private let disposable = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let model = PublishSubject<Response>()
            
        input.searchButtonDidTapped
            .withLatestFrom(input.searchText, resultSelector: { $1! })
            .flatMap { return APIManager.shared.search(term: $0) }
            .subscribe(with: self) { owner, value in
                model.onNext(value)
            } onError: { owner, error in
                print(error)
            }
            .disposed(by: disposable)
            
        
        return Output(loadResult: model)
    }
}

extension SearchViewModel {
    
    func viewDidLoad() {
        
    }
}
