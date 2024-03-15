//
//  CalendarCourseListView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI

struct CalendarCourseListView: View {
    @Binding var infos: [(String, Color)]?
    
    var body: some View {
        if let infos = infos {
            List(infos.indices, id: \.self) { index in
                let info = infos[index]
                HStack(alignment: .center, spacing: 0) {
                    Circle()
                        .fill(info.1.opacity(0.75))
                        .frame(width: 12, height: 12)
                    Text(info.0)
                        .padding(.leading, 8)
                }
            }
        }              
    }
}

//#Preview {
//    CalendarCourseListView()
//}
