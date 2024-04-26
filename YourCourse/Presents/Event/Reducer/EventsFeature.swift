//
//  EventsFeature.swift
//  YourCourse
//
//  Created by 이민호 on 4/19/24.
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
struct EventsFeature {
    struct State: Equatable {
        @BindingState var events: [Event] = []
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchEvents(String)        
        case setEvents([Event])
        case saveEvents
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .fetchEvents(id):
                return .run { send in
                    for try await events in try await firestoreAPIClient.fetchEvents(courseId: id) {
                        await send(.setEvents(events))
                    }
                }
                
            case let .setEvents(events):
                state.events = events
                return .none
                
            case .saveEvents:
                print("Events 저장")
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}
