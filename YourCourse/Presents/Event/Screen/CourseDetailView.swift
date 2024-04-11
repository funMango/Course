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
    @State var showAddEventView: Bool = false
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
                    viewStore.send(.onAppear)
                }
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
            }
        }
    }
}

#Preview {
    CourseDetailView(
        store: Store(
            initialState: CourseDetailFeature.State(course:
                    Course(
                        title: "도쿄여행",
                        location: "도쿄",
                        memo: "아시아나항공(나리타) 10:30 온보딩 \n대한항공(인천) 12:45 온보딩",
                        startDate: Date(),
                        endDate: Date(),
                        color: .red
                    )
                ),
            reducer: { CourseDetailFeature() }
        )
    )
}