//
//  UIFont+Extension.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation
import UIKit
extension UIFont{
    
    static func robotoFontOf(size: CGFloat, weight: UIFont.Weight) -> UIFont{
        if weight == .bold{
            return UIFont(name: "Roboto-Bold", size: size) ?? .boldSystemFont(ofSize: size)
        }else{
            return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
        }
    }
}
