//
//  CalendarView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI
import SwiftUICalendar


struct CalendarCourseView: View {
    @StateObject var controller: CalendarController = CalendarController()
    var informations = [YearMonthDay: [(String, Color)]]()
    @State var focusDate: YearMonthDay? = nil
    @State var focusInfo: [(String, Color)]? = nil

    init() {
        var date = YearMonthDay.current
        informations[date] = []
        informations[date]?.append(("Hello", Color.orange))
        informations[date]?.append(("World", Color.blue))

        date = date.addDay(value: 3)
        informations[date] = []
        informations[date]?.append(("Test", Color.pink))

        date = date.addDay(value: 8)
        informations[date] = []
        informations[date]?.append(("Jack", Color.green))

        date = date.addDay(value: 5)
        informations[date] = []
        informations[date]?.append(("Home", Color.red))

        date = date.addDay(value: -23)
        informations[date] = []
        informations[date]?.append(("Meet at 8, Home", Color.purple))

        date = date.addDay(value: -5)
        informations[date] = []
        informations[date]?.append(("Home", Color.yellow))

        date = date.addDay(value: -10)
        informations[date] = []
        informations[date]?.append(("Baseball", Color.green))
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                VStack {
                    // Year & Month
                    CalendarHeaderView(controller: controller)
                                        
                    CaledarMainView(
                        controller: controller,
                        informations: informations,
                        focusDate: $focusDate,
                        focusInfo: $focusInfo
                    )
                    
                    CalendarCourseListView(infos: $focusInfo)
                        .frame(width: reader.size.width, height: 160, alignment: .center)
                }
            }
        }
    }
}

#Preview {
    CalendarCourseView()
}
