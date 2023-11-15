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
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, AppInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AppInfo>
    
    // MARK: UI Properties
    
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout())
    var dataSource: DataSource!
    
    // MARK: Properties
    
    enum Section: Int, Hashable { case main }
    
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
        
        setUpDataSource()
        configureViews()
        setConstraints()
    }
    
    private func bind() {
        
        let input = SearchViewModel.Input(
            searchText: searchBar.rx.text.orEmpty.map { $0 }.asObservable(),
            searchButtonDidTapped: searchBar.rx.searchButtonClicked.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.loadResult
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, value in
                owner.takeSnapshot(with: value)
            }
            .disposed(by: disposable)
    }
    
    func takeSnapshot(with items: [AppInfo]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func presentNextVC() {
        print("next VC")
    }
}

extension SearchViewController {
    
    func setUpDataSource() {
        
        let cellProvider = UICollectionView.CellRegistration<SearchViewCell, AppInfo> { cell, indexPath, item in
            
            let input = SearchViewCell.Input(
                data: Observable.just(item)
            )

            let output = cell.transform(input: input)
            
            output.buttonDidTapped
                .subscribe(with: self) { owner, value in
                    owner.presentNextVC()
                }
                .disposed(by: cell.disposable)
        }
        
        self.dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                let cell = collectionView.dequeueConfiguredReusableCell(
                    using: cellProvider,
                    for: indexPath,
                    item: item
                )
                return cell
            }
        )
    }
    
    static func flowLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(500.0)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension SearchViewController {
    func configureViews() {
        self.navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
