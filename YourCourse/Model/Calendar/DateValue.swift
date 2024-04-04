//
//  DateValue.swift
//  YourCourse
//
//  Created by 이민호 on 4/1/24.
//

import SwiftUI

struct DateValue: Identifiable, Equatable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    
    func isDay() -> Bool {
        return day != -1
    }
}

