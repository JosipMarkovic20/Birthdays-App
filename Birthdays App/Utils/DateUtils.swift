//
//  DateUtils.swift
//  Birthdays App
//
//  Created by Josip Marković on 26.06.2021..
//

import Foundation

class DateUtils{
    
    static func getAge(from date: String) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        guard let safeDate = dateFormatter.date(from: date) else {
            return 0
        }
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: safeDate, to: Date())
        return ageComponents.year ?? 0
    }
}
