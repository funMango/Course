//
//  CalendarView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI
import SwiftUICalendar
import ComposableArchitecture

struct CalendarCourseView: View {
    @StateObject var controller: CalendarController = CalendarController()
    @State var focusDate: YearMonthDay? = nil
    @State var focusInfo: [(String, Color)]? = nil
    @State var showAddCourseView = false
    var informations = [YearMonthDay: [(String, Color)]]()
    let store: StoreOf<CalendarFeature>
    
    //    init() {
    ////        var ex = YearMonthDay(year: 2024, month: 3, day: 15)
    ////        informations[ex] = []
    ////        informations[ex]?.append(("Hello", Color.orange))
    //
    //        var date = YearMonthDay.current
    //        informations[date] = []
    //        informations[date]?.append(("Hello", Color.orange))
    //        informations[date]?.append(("World", Color.blue))
    //
    //        date = date.addDay(value: 3)
    //        informations[date] = []
    //        informations[date]?.append(("Test", Color.pink))
    //
    //        date = date.addDay(value: 8)
    //        informations[date] = []
    //        informations[date]?.append(("Jack", Color.green))
    //
    //        date = date.addDay(value: 5)
    //        informations[date] = []
    //        informations[date]?.append(("Home", Color.red))
    //
    //        date = date.addDay(value: -23)
    //        informations[date] = []
    //        informations[date]?.append(("Meet at 8, Home", Color.purple))
    //
    //        date = date.addDay(value: -5)
    //        informations[date] = []
    //        informations[date]?.append(("Home", Color.yellow))
    //
    //        date = date.addDay(value: -10)
    //        informations[date] = []
    //        informations[date]?.append(("Baseball", Color.green))
    //    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
                .onAppear() {
                    viewStore.send(.onAppear)
                }                
                .toolbar {
                    ToolbarItem {
                        Button {
                            print("Tap plus button")
                            showAddCourseView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddCourseView) {
                    AddCourseView(showAddCourseView: $showAddCourseView,
                                  store: Store(
                                    initialState: CourseFeature.State(),
                                    reducer: { CourseFeature() })
                    )
                }
            }        
        }
    }
}

struct CalendarCourseView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCourseView(store: Store(
            initialState: CalendarFeature.State(),
            reducer: { CalendarFeature()}
        ))
    }
}
