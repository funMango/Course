//
//  CustomDatePicker.swift
//  YourCourse
//
//  Created by 이민호 on 4/1/24.
//

import SwiftUI
import ComposableArchitecture

struct CalendarView: View {
    @State var showAddCourseView = false
    @State var currentDate = Date()
    @State var currentMonth = 0
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 35) {
                CalendarHeaderView(
                    currentDate: $currentDate,
                    showAddCourseView: $showAddCourseView
                )
                .padding(.horizontal)
                
                CalendarDaysView(
                    currentDate: $currentDate,
                    currentMonth: $currentMonth,
                    store: self.store
                )                
                
                Spacer()
            }
            .onAppear() {
                viewStore.send(.onAppear)
            }
            .gesture(DragGesture()
                .onEnded { value in
                    if value.translation.width > 0 {
                        withAnimation {
                            currentMonth -= 1
                        }
                    } else if value.translation.width < 0 {
                        withAnimation {
                            currentMonth += 1
                        }
                    }
                }
            )
            .sheet(isPresented: $showAddCourseView) {
                AddCourseView(showAddCourseView: $showAddCourseView,
                              store: Store(
                                initialState: CourseFeature.State(),
                                reducer: { CourseFeature() })
                )
            }
        }
    }
}

#Preview {
    CalendarView(store: Store(
        initialState: CalendarFeature.State(),
        reducer: { CalendarFeature()}
    ))
}
