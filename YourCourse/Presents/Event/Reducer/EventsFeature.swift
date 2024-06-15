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
        var eventsCopy: [Event] = []
        var courseId: String?
        var oldEvents: [Event]?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case setCourseId(String)
        
        case fetchEvents(String)
        case setEvents([Event])
        case saveEvents(String)
        case resetOldEvents
        
        case moveEvent(IndexSet, Int)
        case removeEvent(IndexSet)        
    }
    
    @Dependency(\.firestoreAPIClient) var firestoreAPIClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case let .setCourseId(id):
                state.courseId = id
                return .none
                
            case let .fetchEvents(id):
                return .run { send in
                    for try await events in try await firestoreAPIClient.fetchEvents(courseId: id) {
                        await send(.setEvents(events))
                    }
                }
                        
            case let .setEvents(events):
                state.events = events.sorted(by: { $0.order < $1.order })
                state.eventsCopy = state.events
                return .none
                                     
            case let .saveEvents(id):
                let old = state.oldEvents
                var temp = state.events
                for idx in temp.indices {
                    temp[idx].setOrder(order: idx)
                }
                state.events = temp
                
                let events = state.events
                return .run { send in
                    try await firestoreAPIClient.saveEvents(
                        courseId: id,
                        events: events,
                        oldEvents: old
                    )
                    await send(.resetOldEvents)
                }
                
            case .resetOldEvents:
                state.oldEvents = nil
                return .none
                
            case let .moveEvent(source, destination):
                state.oldEvents = state.events.map{ $0 }
                state.events.move(fromOffsets: source, toOffset: destination)
                return .none
            
            case let .removeEvent(offsets):
                state.oldEvents = state.events.map{ $0 }
                state.events.remove(atOffsets: offsets)
                return .none
                                        
            case .binding:
                return .none
            }
        }
    }
}
