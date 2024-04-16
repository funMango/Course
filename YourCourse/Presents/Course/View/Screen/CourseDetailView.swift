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
    @State var draggedEvent: Event?
    let store: StoreOf<CourseDetailFeature>
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    Section(header: Text("날짜")) {
                        Text("\(viewStore.course.getPeriod())")
                    }
                    
                    if !viewStore.course.location.isEmpty {
                        Section(header: Text("장소")) {
                            Text(viewStore.course.location)
                        }
                    }
                    
                    EventListView(
                        showAddEventView: $showAddEventView,
                        store: self.store
                    )                    
                                                            
                    if !viewStore.course.memo.isEmpty {
                        Section(header: Text("메모")) {
                            Text(viewStore.course.memo)
                        }
                    }
                }                
                .navigationTitle(viewStore.course.title)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .onAppear() {
                    viewStore.send(.loadCourse)                    
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
                            viewStore.send(.tappedBackButton)
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .sheet(isPresented: $showAddEventView) {
                    AddEventView(
                        showAddEventView: $showAddEventView,
                        store: Store(
                            initialState: EventFeature.State(
                                course: viewStore.course,
                                events: viewStore.events                                
                            ),
                            reducer: { EventFeature() }
                        )
                    )
                }
                .sheet(isPresented: $showChangeCourseView) {                                        
                    ChangeCourseView(
                        showChangeCourseView: $showChangeCourseView,
                        store: Store(
                            initialState: CourseChangeFeature.State(
                                course: viewStore.course
                            ),
                            reducer: { CourseChangeFeature() }
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    CourseDetailView(
        store: Store(
            initialState: CourseDetailFeature.State(
                courseId: ""
                ),
            reducer: { CourseDetailFeature() }
        )
    )
}
