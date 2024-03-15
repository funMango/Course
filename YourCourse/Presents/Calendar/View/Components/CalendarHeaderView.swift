//
//  CalendarHeaderView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI
import SwiftUICalendar

struct CalendarHeaderView: View {
    @StateObject var controller: CalendarController
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
            } label: {
                 Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
            }
            .padding(8)
            
            Spacer()
            
            Text("\(controller.yearMonth.monthShortString), \(String(controller.yearMonth.year))")
                .font(.title)
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            
            Spacer()
            
            Button {
                controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
            } label: {
                 Image(systemName: "chevron.forward")
                    .foregroundColor(.black)
            }
            .padding(8)
        }
    }
}

//#Preview {
//    CalendarHeaderView()
//}
