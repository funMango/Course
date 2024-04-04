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
    let store: StoreOf<CalendarFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 35) {
                CalendarHeaderView(                    
                    showAddCourseView: $showAddCourseView,
                    store: self.store
                )
                .padding(.horizontal)
                
                CalendarDaysView(store: self.store) 
                    .animation(.easeInOut, value: viewStore.currentDate)
                    
                                                    
                CourseListView(
                    store: self.store
                )
                .padding(.top, -30)
            }            
            .onAppear() {
                viewStore.send(.onAppear)
            }
            .gesture(DragGesture()
                .onEnded { value in
                    if value.translation.width > 0 {
                        viewStore.send(.swipePrevMonth)
                    } else if value.translation.width < 0 {
                        viewStore.send(.swipeNextMonth)
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
