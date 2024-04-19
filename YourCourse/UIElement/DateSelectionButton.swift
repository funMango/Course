//
//  DateSelectButton.swift
//  YourCourse
//
//  Created by 이민호 on 4/18/24.
//

import SwiftUI

struct DateSelectionButton: View {
    @Binding var showCalendar: Bool
    let type: SelectDateType
    let title: String
        
    private var animation: Animation {
        .easeInOut(duration: 0.1)
    }
    
    var body: some View {
        HStack {
            Text(type == .start ? "시작" : "종료")
                .foregroundColor(.black)
            
            Spacer()
            
            Button {
                withAnimation(animation) {
                    showCalendar.toggle()
                }
            } label: {
                DayPickerBtnText(
                    showCalendar: $showCalendar,
                    title: title
                )
            }
        }
    }
}

//#Preview {
//    DateSelectButton()
//}
