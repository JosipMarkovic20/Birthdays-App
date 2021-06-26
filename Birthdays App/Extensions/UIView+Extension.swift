//
//  UIView+Extension.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(views: [UIView]){
        for view in views{
            self.addSubview(view)
        }
    }
}
