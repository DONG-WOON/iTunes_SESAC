//
//  BaseTabBarController.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: Properties
    
    let searchVC = SearchViewController(viewModel: SearchViewModel())
        .embedNavigationController()
        .configureTabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"))
    
    // MARK: View Life Cycle

    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("🔥 ", self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [searchVC]
    }
}

extension UIViewController {
    func configureTabBarItem(title: String, image: UIImage?) -> UIViewController {
        self.tabBarItem.title = title
        self.tabBarItem.image = image
        return self
    }
}

