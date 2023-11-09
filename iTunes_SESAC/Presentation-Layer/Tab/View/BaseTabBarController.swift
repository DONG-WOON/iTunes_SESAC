//
//  BaseTabBarController.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {

    // MARK: Properties
    
    // MARK: View Life Cycle

    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = .label
        tabBarAppearance.barTintColor = .black
        tabBarAppearance.isTranslucent = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("🔥 ", self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.viewControllers =
    }
}

extension UIViewController {
    func configureTabBarItem(title: String, image: UIImage?) -> UIViewController {
        self.tabBarItem.title = title
        self.tabBarItem.image = image
        return self
    }
}

