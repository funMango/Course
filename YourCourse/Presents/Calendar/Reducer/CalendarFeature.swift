//
//  CalendarFeature.swift
//  YourCourse
//
//  Created by 이민호 on 3/23/24.
//

import Foundation
import ComposableArchitecture
import SwiftUICalendar
import Dependencies
import Combine
import SwiftUI

struct CalendarFeature: Reducer {
    struct State: Equatable {
        @BindingState var courses: [Course] = []   
        @BindingState var currentDate = Date()
        @BindingState var currentMonth = 0
        @BindingState var dateValues: [DateValue] = []        
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case coursesLoaded([Course])    
        case swipeNextMonth
        case swipePrevMonth
        case setCurrentDate(Date)
        case setCurrentMonth
        case extractDate
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    @Dependency(\.DateManager) var dateManager
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    for try await courses in try await firestoreAPIClient.fetchCourses() {
                        await send(.coursesLoaded(courses))
                    }
                } catch: { error, send in
                    print(error)
                }
                
            case let .coursesLoaded(courses):
                print("Course들이 성공적으로 Fetch되었습니다.\nCourse \(courses.count)개")
                state.courses = courses
                return .none
            
            case .swipeNextMonth:
                state.currentMonth += 1
                return .none
            
            case .swipePrevMonth:
                state.currentMonth -= 1
                return .none
            
            case let .setCurrentDate(date):
                state.currentDate = date
                return .none
                
            case .setCurrentMonth:
                state.currentDate = dateManager.getCurrentMonth(currentMonth: state.currentMonth)
                return .send(.extractDate)
                
            case .extractDate:
                state.dateValues = dateManager.extractDate(currentMonth: state.currentMonth)
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}
