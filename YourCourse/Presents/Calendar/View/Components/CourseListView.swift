//
//  CourseListView.swift
//  YourCourse
//
//  Created by 이민호 on 4/3/24.
//

import SwiftUI
import ComposableArchitecture

struct CourseListView: View {
    let store: StoreOf<CalendarFeature>
    let data: [String] = ["Course1", "Course2", "Course3", "Course4"]
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                Section {
                    ForEach(getFilteredCourses(date: viewStore.currentDate, courses: viewStore.courses), id: \.self) { course in
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
}

extension CourseListView {
    func getFilteredCourses(date: Date, courses: [Course]) -> [Course] {
        return courses.filter { course in
            let courseDates = course.getDays()
            
            return courseDates.contains(where: { courseDate in
                Calendar.current.isDate(courseDate, inSameDayAs: date)
            })
        }
    }
}

#Preview {
    CourseListView(        
        store: Store(
        initialState: CalendarFeature.State(),
        reducer: { CalendarFeature()}
    ))
}
