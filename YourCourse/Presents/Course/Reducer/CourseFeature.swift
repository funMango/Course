//
//  CourseFeature.swift
//  YourCourse
//
//  Created by 이민호 on 3/20/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
struct CourseFeature {
    struct State: Equatable {
        @BindingState var course = Course()
        var eventsFeature = EventsFeature.State()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case tappedSaveButton
        case saveCourse
        case fetchCourse
        case setCourse(Course)
        case setEventsFeature(String)
        case eventsFeature(EventsFeature.Action)
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some Reducer<State, Action> {
        Scope(state: \.eventsFeature, action: \.eventsFeature) {
            EventsFeature()
        }
        
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .tappedSaveButton:
                if state.course.memo == "메모" {
                    state.course.memo = ""
                }
                return .send(.saveCourse)
                
            case .saveCourse:
                let course = state.course
                return .run { send in
                    try await firestoreAPIClient.saveCourse(course: course)
                    await send(.eventsFeature(.saveEvents(course.id)))
                } catch: { error, send in
                    print(error)
                }
                
            case .fetchCourse:
                let id = state.course.id
                return .run { send in
                    for try await course in try await firestoreAPIClient.fetchCourse(courseId: id) {
                        await send(.setCourse(course))
                    }
                }
                
            case let .setCourse(course):
                state.course = course
                return .send(.setEventsFeature(course.id))
            
            case let .setEventsFeature(courseId):
                return .run { send in
                    await send(.eventsFeature(.setCourseId(courseId)))
                }
                                            
            case .binding:
                return .none
                
            default:
                return .none                
            }
        }
    }
}
