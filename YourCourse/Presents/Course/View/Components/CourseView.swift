//
//  CourseView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI

struct CourseView: View {
    let course = ["행궁동 데이트", "안동 여행", "교토 여행", "로스엔젤리스 출장"]
    
    var body: some View {
        NavigationStack {
            VStack() {
                LargeTitleText(title: "Course")
                    .padding(.horizontal)
                
                
                List {
                    Section("기본") {
                        ForEach(course, id: \.self) { value in
                            HStack {
                                
                                
                                Text(value)
                            }
                            
                        }
                    }
                }
                .listStyle(.insetGrouped)
                
                Spacer()
                
            }
            .toolbar() {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Text("편집")
                    }
                }
            }
        }
    }
}

//#Preview {
//    CourseView()
//}
