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
    @FocusState private var isFocused: Bool
    let store: StoreOf<CourseFeature>
    var memoPlaceholder = "메모"
        
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    Section {
                        TextField("제목", text: viewStore.$title)
                            .focused($isFocused)
                            .keyboardType(.default)
                            .autocorrectionDisabled()
                        TextField("위치", text: viewStore.$location)
                            .focused($isFocused)
                            .keyboardType(.default)
                            .autocorrectionDisabled()
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
                            .focused($isFocused)
                            .autocorrectionDisabled()
                            .onTapGesture {
                                if viewStore.memo == memoPlaceholder {
                                    viewStore.send(.resetMemo)
                                }
                            }
                    }
                }
                .onChange(of: viewStore.$isSavedCourse) { _ in
                    if viewStore.isSavedCourse {
                        showAddCourseView = false
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedAddButton)
                        } label: {
                            Text("추가")
                        }
                    }
                    
                    ToolbarItemGroup(placement: .principal) {
                        Text("새로운 코스")
                    }
                    
                    ToolbarItemGroup(placement: .topBarLeading) {
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
