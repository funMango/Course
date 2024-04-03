//
//  CustinDatePickerDays.swift
//  YourCourse
//
//  Created by 이민호 on 4/1/24.
//

import SwiftUI
import ComposableArchitecture

struct CalendarDaysView: View {
    @Binding var currentDate: Date
    @Binding var currentMonth: Int
    let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 25) {
                HStack {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(extractDate()) { value in
                        CalendarDayView(
                            currentDate: self.$currentDate,
                            value: value,
                            store: self.store
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                    }
                }
            }
            .onChange(of: currentMonth) { newValue in
                currentDate = getCurrentMonth()
            }
        }
    }
}

extension CalendarDaysView {
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month,value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
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

#Preview {
    CalendarDaysView(
        currentDate: .constant(Date()),
        currentMonth: .constant(0),
        store: Store(
            initialState: CalendarFeature.State(),
            reducer: { CalendarFeature() })
    )
}
