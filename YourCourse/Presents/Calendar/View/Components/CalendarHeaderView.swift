//
//  CustomDatePickerHeader.swift
//  YourCourse
//
//  Created by 이민호 on 4/1/24.
//

import SwiftUI

struct CalendarHeaderView: View {
    @Binding var currentDate: Date
    @Binding var showAddCourseView: Bool
   
    var body: some View {
        HStack(spacing: 20) {
            Text(extractDate())
                .font(.title3.bold())
                        
            Spacer()
            
            Button {
                showAddCourseView.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.red)
            }
        }        
    }
}

extension CalendarHeaderView {
    func extractDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        
        return formatter.string(from: currentDate)
    }
}

#Preview {
    CalendarHeaderView(currentDate: .constant(Date()), showAddCourseView: .constant(false))
}
