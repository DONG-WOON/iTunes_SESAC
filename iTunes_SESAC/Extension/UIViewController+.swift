//
//  Extension+UIViewController.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import UIKit

extension UIViewController {
    func embedNavigationController() -> UINavigationController {
           let navigationController = UINavigationController(rootViewController: self)
           return navigationController
       }

}
