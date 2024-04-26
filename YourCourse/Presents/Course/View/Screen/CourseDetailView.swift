//
//  DetailCourseView.swift
//  YourCourse
//
//  Created by 이민호 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture

struct CourseDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var showAddEventView = false
    @State var showChangeCourseView = false
    let store: StoreOf<CourseFeature>
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    CourseInfoView(store: self.store)
                                                                               
                    EventListView(
                        store: self.store.scope(
                            state: \.eventsFeature,
                            action: \.eventsFeature
                        ),
                        courseId: viewStore.course.id
                    )
                                                            
                    if !viewStore.course.memo.isEmpty {
                        Section(header: Text("메모")) {
                            Text(viewStore.course.memo)
                        }
                    }
                }
                .navigationTitle("코스")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .onAppear() {
                    viewStore.send(.fetchCourse)
                }
                .toolbar() {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showChangeCourseView.toggle()
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
                .sheet(isPresented: $showChangeCourseView) {                                        
                    CourseChangeView(
                        showChangeCourseView: $showChangeCourseView,
                        store: self.store
                    )
                }
            }
        }
    }
}

#Preview {
    CourseDetailView(
        store: Store(
            initialState: CourseFeature.State(course:
                    Course(
                        title: "도쿄여행",
                        location: "도쿄역",
                        memo: "나리타 익스프레스 -> 도쿄역",
                        startDate: Date(),
                        endDate: Date(),
                        color: .navy
                    )
                ),
            reducer: { CourseFeature() }
        )
    )
}
