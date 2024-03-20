//
//  AddCourseView.swift
//  YourCourse
//
//  Created by 이민호 on 3/16/24.
//

import SwiftUI

struct AddCourseView: View {
    @State var title = ""
    @State var location = ""
    @State var allDay = false
    @State var startDate = Date()
    @State var endDate = Date()
    @State var memo = "메모"
    var memoPlaceholder = "메모"
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("제목", text: $title)
                    TextField("위치", text: $location)
                }
                
                Section {
                    Toggle(isOn: $allDay) {
                        Text("하루 종일")
                    }
                    
                    if !allDay {
                        DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                            Text("시작")
                        }
                        
                        DatePicker(selection: $endDate, in: ...Date(), displayedComponents: .date) {
                            Text("종료")
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $memo)
                        .foregroundColor(self.memo == memoPlaceholder ? .gray : .primary)
                        .cornerRadius(15)
                        .frame(minHeight: 200, maxHeight: 300)
                        .onTapGesture {
                            if self.memo == memoPlaceholder {
                                self.memo = ""
                            }
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("새로운 코스")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Tap 추가 버튼")
                    } label: {
                        Text("추가")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("Tap 취소 버튼")
                    } label: {
                        Text("취소")
                            .foregroundStyle(.red)
                    }
                }                                
            }
        }
    }
}

//#Preview {
//    AddCourseView()
//}
