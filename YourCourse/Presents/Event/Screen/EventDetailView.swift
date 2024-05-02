//
//  EventDetailView.swift
//  YourCourse
//
//  Created by 이민호 on 5/2/24.
//

import SwiftUI
import ComposableArchitecture

struct EventDetailView: View {
    @Environment(\.dismiss) var dismiss
    let store: StoreOf<EventFeature>
    let courseId: String
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    Section {
                        VStack(alignment: .leading) {
                            Text("\(viewStore.event.title)")
                            
                            if !viewStore.event.location.isEmpty {
                                Text("\(viewStore.event.location)")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    if !viewStore.event.memo.isEmpty {
                        Section(header: Text("메모")) {
                            Text(viewStore.event.memo)
                        }
                    }
                }
                .onAppear() {
                    viewStore.send(.fetchEvent(courseId))
                }
                .navigationTitle("이벤트")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar() {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("편집")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EventDetailView(
        store: Store(
            initialState: EventFeature.State(event: 
                Event(
                    title: "카페가기",
                    location: "성수동",
                    memo: "성수역 2번출구"
                )
            ),
            reducer: { EventFeature() }
        ),
        courseId: ""
    )
}
