//
//  Day.swift
//  YourCourse
//
//  Created by 이민호 on 3/20/24.
//

import Foundation

struct CourseDate: Codable {
    var date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    func formatDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self.date)
    }
}
