//
//  CustinDatePickerDays.swift
//  YourCourse
//
//  Created by 이민호 on 4/1/24.
//

import SwiftUI
import ComposableArchitecture

struct CalendarDaysView: View {
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
                    ForEach(viewStore.dateValues) { value in
                        CalendarDayView(
                            currentDate: viewStore.$currentDate,
                            value: value,
                            store: self.store
                        )
                        .onTapGesture {
                            viewStore.send(.setCurrentDate(value.date))
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(hex: "#D3D3D5"))
            }
            .onChange(of: viewStore.currentMonth) {
                viewStore.send(.setCurrentMonth)
            }
            .onAppear() {
                viewStore.send(.extractDate)
            }
        }
    }
}

#Preview {
    CalendarDaysView(        
        store: Store(
            initialState: CalendarFeature.State(),
            reducer: { CalendarFeature() })
    )
}
