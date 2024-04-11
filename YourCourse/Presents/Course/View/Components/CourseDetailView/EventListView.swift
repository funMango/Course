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
    let store: StoreOf<CourseDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Section (header: Text("이벤트")) {
                ForEach(viewStore.events, id: \.self) { event in
                    VStack(alignment: .leading) {
                        Text(event.title)
                        
                        if !event.location.isEmpty {
                            Spacer()
                                .frame(height: 5)
                            
                            Text(event.location)
                                .foregroundStyle(.gray)
                                .font(.system(size: 13))
                        }
                    }
                }
                .onMove { from, to in
                    viewStore.send(.eventsMove(from, to))
                }
                
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
        }
    }
}

#Preview {
    EventListView(
        showAddEventView: .constant(false),
        store: Store(
            initialState: CourseDetailFeature.State(
                courseId: ""
                ),
            reducer: { CourseDetailFeature() }
        )
    )
}
