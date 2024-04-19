//
//  AddCourseView.swift
//  YourCourse
//
//  Created by 이민호 on 3/16/24.
//

import SwiftUI
import ComposableArchitecture

struct CourseAddView: View {
    @Binding var showAddCourseView: Bool
    @FocusState private var isFocused: Bool
    @State private var isPlusBtnDisable = true
    let store: StoreOf<CourseFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                List {
                    TitleLocationSectionView(store: self.store, isFocused: $isFocused)
                    
                    DateSectionView(store: self.store)
                                        
                    MemoSectionView(store: self.store, isFocused: $isFocused)
                    
                    ColorSectionView(store: self.store)
                }                
                .onChange(of: viewStore.course.title) {
                    isPlusBtnDisable = viewStore.course.title.isEmpty ? true : false
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewStore.send(.tappedSaveButton)
                            showAddCourseView.toggle()
                        } label: {
                            Text("추가")
                                .foregroundStyle(isPlusBtnDisable ? .gray : .red)
                        }
                        .disabled(isPlusBtnDisable)
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
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct AddCourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseAddView(showAddCourseView: .constant(true),
                      store: Store(
                        initialState: CourseFeature.State(),
                        reducer: { CourseFeature() })
        )
    }
}
