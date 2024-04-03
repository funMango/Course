//
//  CourseListView.swift
//  YourCourse
//
//  Created by 이민호 on 4/3/24.
//

import SwiftUI

struct CourseListView: View {
    let data: [String] = ["Course1", "Course2", "Course3", "Course4"]
    
    var body: some View {
        List {
            Section {
                ForEach(data, id: \.self) { value in
                    HStack(alignment: .top) {
                        Spacer()
                            .frame(width: 15)
                        VStack(alignment: .leading) {
                            Text(value)
                                .font(.title3.bold())
                            
                            Spacer()
                                .frame(height: 7)
                            
                            Text("경기도 수원시 권선구")
                                .foregroundStyle(.gray)
                        }
                    }
                    .background(
                        Rectangle()
                            .frame(width: 6)
                            .foregroundColor(.red)
                            .cornerRadius(3.5),
                        alignment: .leading
                    )
                }
            }
        }
        .listStyle(.inset)        
    }
}

#Preview {
    CourseListView()
}
