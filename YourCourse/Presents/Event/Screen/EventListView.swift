//
//  EventListView.swift
//  YourCourse
//
//  Created by 이민호 on 4/11/24.
//

import SwiftUI
import ComposableArchitecture

struct EventListView: View {
    @Binding var showAddEventView: Bool
    let store: StoreOf<EventsFeature>
    let courseId: String
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section(header: Text("이벤트")) {
                EventList(
                    store: self.store,
                    courseId: courseId
                )
                
                Button {
                    showAddEventView.toggle()
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Text("이벤트 추가")
                            .foregroundStyle(.red)
                        
                        Spacer()
                    }
                }
            }
            .onAppear() {
                viewStore.send(.fetchEvents(courseId))
            }
        }
    }
}

#Preview {
    EventListView(
        showAddEventView: .constant(false),
        store: Store(
            initialState: EventsFeature.State(),
            reducer: { EventsFeature() }
        ),
        courseId: ""
    )
}
