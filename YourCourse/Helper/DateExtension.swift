//
//  DateExtension.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import Foundation

extension Date {
    func formatDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        return dateFormatter.string(from: self)
    }
        
}
