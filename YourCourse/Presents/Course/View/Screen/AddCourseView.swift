//
//  AddCourseView.swift
//  YourCourse
//
//  Created by 이민호 on 3/16/24.
//

import SwiftUI
import ComposableArchitecture

struct AddCourseView: View {
    @Binding var showAddCourseView: Bool
    let store: StoreOf<CourseFeature>
    var memoPlaceholder = "메모"
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    Section {
                        TextField("제목", text: viewStore.$title)
                        TextField("위치", text: viewStore.$location)
                    }
                    
                    Section {
                        Toggle(isOn: viewStore.$isAllDay) {
                            Text("하루 종일")
                        }
                                                                            
                        if !viewStore.isAllDay {
                            DatePicker(
                                selection: viewStore.binding(
                                    get: \.startDate,
                                    send: CourseFeature.Action.setStartDate
                                ),
                                in: Date()...,
                                displayedComponents: .date
                            ) {
                                Text("시작")
                            }
                            
                            DatePicker(
                                selection: viewStore.binding(
                                    get: \.endDate,
                                    send: CourseFeature.Action.setEndDate
                                ),
                                in: viewStore.startDate...,
                                displayedComponents: .date
                            ) {
                                Text("종료")
                            }
                        }
                    }
                    
                    Section {
                        TextEditor(text: viewStore.$memo)
                            .foregroundColor(viewStore.memo == memoPlaceholder ? .gray : .primary)
                            .cornerRadius(15)
                            .frame(minHeight: 200, maxHeight: 300)
                            .onTapGesture {
                                if viewStore.memo == memoPlaceholder {
                                    viewStore.send(.resetMemo)
                                }
                            }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedAddButton)
                        } label: {
                            Text("추가")
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("새로운 코스")
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showAddCourseView.toggle()
                        } label: {
                            Text("취소")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
        }
    }
}

struct AddCourseView_Previews: PreviewProvider {
  static var previews: some View {
      AddCourseView(showAddCourseView: .constant(true),
                    store: Store(
                    initialState: CourseFeature.State(),
                    reducer: { CourseFeature() })
                   )
  }
}
