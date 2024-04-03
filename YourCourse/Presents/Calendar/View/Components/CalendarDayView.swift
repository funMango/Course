//
//  CustomDatePickerDay.swift
//  YourCourse
//
//  Created by 이민호 on 4/1/24.
//

import SwiftUI
import ComposableArchitecture

struct CalendarDayView: View {
    @Binding var currentDate: Date
    let value: DateValue
    let today = Date()
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                if value.isDay() {
                    ZStack {
                        Circle()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(circleColor())
                        
                        Text("\(value.day)")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(textColor())
                            .frame(maxWidth: .infinity)
                    }
                                        
                    Circle()
                        .frame(width: 6)
                        .foregroundStyle(isContainDate(courses: viewStore.courses, target: value.date) ? .red : .white)
                    
                } else {
                    Rectangle()
                        .foregroundColor(.white)
                }
            }            
            .frame(height: 45, alignment: .top)
        }
    }
}

extension CalendarDayView {
    func textColor() -> Color {
        if currentDate == value.date {
            return .white
        }
        
        if isSameDay(date1: value.date, date2: today) {
            return .red
        }
        
        return .primary
    }
    
    func textBold() -> Font {
        if currentDate == value.date || isSameDay(date1: value.date, date2: today) {
            return .title3.bold()
        }
        
        return .title3
    }
    
    func circleColor() -> Color {
        if currentDate == value.date {
            if isSameDay(date1: value.date, date2: today) {
                return .red
            }
            
            return .black
        }
                        
        return .white
    }
}

extension CalendarDayView {
    func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    func isContainDate(courses: [Course], target: Date) -> Bool {
        let calendar = Calendar.current
        
        if courses.flatMap({ $0.getDays() }).contains(where: { calendar.isDate($0, inSameDayAs: target) }) {
            return true
        }
                        
        return false
    }
    
    
}
