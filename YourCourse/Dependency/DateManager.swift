//
//  DateManager.swift
//  YourCourse
//
//  Created by 이민호 on 4/4/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

protocol DateManagable {
    func getCurrentMonth(currentMonth: Int) -> Date
    func extractDate(currentMonth: Int) -> [DateValue]
}

enum DateManagerKey: DependencyKey {
    static var liveValue: DateManagable = DateManager()
}

class DateManager: DateManagable {
    private let calendar = Calendar.current
    
    func getCurrentMonth(currentMonth: Int) -> Date {
        guard let month = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else {
            return Date()
        }
        
        return month
    }
    
    func extractDate(currentMonth: Int) -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth(currentMonth: currentMonth)
        
        var days =  currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

extension DependencyValues {
    var DateManager: DateManagable {
        get { self[DateManagerKey.self] }
        set { self[DateManagerKey.self] = newValue }
    }
}

