//
//  CourseCellView.swift
//  YourCourse
//
//  Created by 이민호 on 4/6/24.
//

import SwiftUI

struct CourseCellView: View {
    let course: Course
    
    var body: some View {
        HStack(alignment: .top) {
            Spacer()
                .frame(width: 15)
            
            VStack(alignment: .leading) {
                Text("\(course.title)")
                    .font(.title3.bold())
                
                Spacer()
                    .frame(height: 7)
                
                Text("\(course.location)")
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    CourseCellView(course: Course(
        title: "Course",
        location: "Suwon",
        memo: "Testing...",
        startDate: Date(),
        endDate: Date(),
        color: .red
    ))
}
