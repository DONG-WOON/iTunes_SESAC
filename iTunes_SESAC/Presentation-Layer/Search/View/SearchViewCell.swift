//
//  SearchViewCell.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import UIKit
import SnapKit
import RxSwift
import Kingfisher

final class SearchViewCell: UICollectionViewCell {
    
    struct Input {
        let data: Observable<AppInfo>
    }
    
    struct Output {
        let buttonDidTapped: Observable<Void>
    }
    
    var disposable = DisposeBag()
    private let buttonDidTapped = PublishSubject<Void>()
    
    // MARK: UI Properties
    
    private let appNameLabel = UILabel()
    private let appOwnerLabel = UILabel()
    let appDownloadButton = UIButton()
    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.rounded()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reset()
    }
    
    private func reset() {
        appNameLabel.text = nil
        appOwnerLabel.text = nil
        appLogoImageView.image = nil
        
        disposable = DisposeBag()
    }
    
    func transform(input: Input) -> Output {
        
        input.data
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(with: self) { owner, value in
                owner.appLogoImageView.kf.setImage(with: URL(string: value.artworkUrl100))
                owner.appNameLabel.text = value.trackName
                owner.appOwnerLabel.text = value.artistName
            }
            .disposed(by: disposable)
        
        return Output(buttonDidTapped: appDownloadButton.rx.tap.asObservable())
    }
}

extension SearchViewCell {
    func configureViews() {
        contentView.addSubviews([
            appLogoImageView, appNameLabel, appOwnerLabel, appDownloadButton
        ])
        
        appNameLabel.font = .boldSystemFont(ofSize: 12)
        appNameLabel.textColor = .label
        
        appOwnerLabel.font = .systemFont(ofSize: 10)
        appOwnerLabel.textColor = .systemGray3
        
        appDownloadButton.setTitle("GET", for: .normal)
        appDownloadButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        appDownloadButton.rounded(30 / 2)
        appDownloadButton.backgroundColor = .systemGray3
    }
    
    func setConstraints() {
        appLogoImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.top.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(20)
            make.height.width.equalTo(60)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appLogoImageView)
            make.leading.equalTo(appLogoImageView.snp.trailing).offset(10)
            make.trailing.equalTo(appDownloadButton.snp.leading).offset(-10)
        }
        
        appOwnerLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(appNameLabel)
            make.trailing.equalTo(appNameLabel)
        }
        
        appDownloadButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
    }
}
