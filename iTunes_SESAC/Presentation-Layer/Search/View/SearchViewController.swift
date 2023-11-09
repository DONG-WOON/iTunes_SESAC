//
//  SearchViewController.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    
    // MARK: UI Properties
    
    let searchBar = UISearchBar()
    
    // MARK: Properties
    
    private let viewModel: SearchViewModel
    private let disposable = DisposeBag()
    
    // MARK: Life Cycle
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    func bind() {
        let input = SearchViewModel.Input(
            searchText: searchBar.rx.text.orEmpty.map { $0 },
            searchButtonDidTapped: searchBar.rx.searchButtonClicked.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.loadResult
            .subscribe(onNext: { print($0)} )
            .disposed(by: disposable)
    }
}

extension SearchViewController {
    func configureViews() {
        self.navigationItem.titleView = searchBar
        
        searchBar.showsCancelButton = true
    }
}
