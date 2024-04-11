//
//  CourseDetailFeature.swift
//  YourCourse
//
//  Created by 이민호 on 4/6/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

struct CourseDetailFeature: Reducer {
    struct State: Equatable {
        @BindingState var course: Course
        @BindingState var events: [Event] = []
    }
    
    enum Action: BindableAction {
        case onAppear
        case eventsLoaded([Event])
        case eventsMove(IndexSet, Int)
        case tappedBackButton
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                let id = state.course.id
                return .run { send in
                    for try await events in try await firestoreAPIClient.fetchEvents(courseId: id) {
                        await send(.eventsLoaded(events))
                    }
                } catch: { error, send in
                    print(error)
                }
                
            case let .eventsLoaded(events):
                print("Event들이 성공적으로 Fetch되었습니다. Event: \(events.count)개")
                state.events = events.sorted(by: { $0.order < $1.order })
                return .none
                
            case let .eventsMove(from, to):
                state.events.move(fromOffsets: from, toOffset: to)
                state.events = state.events.enumerated().map { (index, event) in
                    var updatedEvent = event
                    updatedEvent.setOrder(order: index)
                    return updatedEvent
                }
                return .none
                
            case .tappedBackButton:
                let id = state.course.id
                let events = state.events
                return .run { send in
                    try await firestoreAPIClient.saveEvents(courseId: id, events: events)
                }
                
            case .binding:
                return .none
            }
        }
    }
}
