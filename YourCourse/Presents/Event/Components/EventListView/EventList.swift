//
//  EventList.swift
//  YourCourse
//
//  Created by 이민호 on 5/2/24.
//

import SwiftUI
import ComposableArchitecture

struct EventList: View {
    let store: StoreOf<EventsFeature>
    let courseId: String
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ForEach(viewStore.events, id: \.self) { event in
                NavigationLink {
                    EventDetailView(
                        store: Store(
                            initialState: EventFeature.State(event: event),
                            reducer: { EventFeature() }
                        ),
                        courseId: courseId
                    )
                } label: {
                    EventCell(event: event)
                }
            }
        }
    }
}
