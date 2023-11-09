//
//  UIView+Extension.swift
//  iTunes_SESAC
//
//  Created by 서동운 on 11/10/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
