//
//  CaledarView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI
import SwiftUICalendar

struct CaledarMainView: View {
    @StateObject var controller: CalendarController
    var informations: [YearMonthDay: [(String, Color)]]
    @Binding var focusDate: YearMonthDay?
    @Binding var focusInfo: [(String, Color)]?
    
    var body: some View {
        CalendarView(controller, header: { week in
            GeometryReader { geometry in
                Text(week.shortString)
                    .font(.subheadline)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }, component: { date in
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 2) {
                    if date.isToday {
                        Text("\(date.day)")
                            .font(.system(size: 10, weight: .bold, design: .default))
                            .padding(4)
                            .foregroundColor(.white)
                            .background(Color.red.opacity(0.95))
                            .cornerRadius(14)
                    } else {
                        Text("\(date.day)")
                            .font(.system(size: 10, weight: .light, design: .default))
                            .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                            .foregroundColor(getColor(date))
                            .padding(4)
                    }
                    if let infos = informations[date] {
                        ForEach(infos.indices) { index in
                            let info = infos[index]
                            if focusInfo != nil {
                                Rectangle()
                                    .fill(info.1.opacity(0.75))
                                    .frame(width: geometry.size.width, height: 4, alignment: .center)
                                    .cornerRadius(2)
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                            } else {
                                Text(info.0)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                                    .font(.system(size: 8, weight: .bold, design: .default))
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                    .frame(width: geometry.size.width, alignment: .center)
                                    .background(info.1.opacity(0.75))
                                    .cornerRadius(4)
                                    .opacity(date.isFocusYearMonth == true ? 1 : 0.4)
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                .border(.green.opacity(0.8), width: (focusDate == date ? 1 : 0))
                .cornerRadius(2)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        if focusDate == date {
                            focusDate = nil
                            focusInfo = nil
                        } else {
                            focusDate = date
                            focusInfo = informations[date]
                        }
                    }
                }
            }
        })
    }
}

extension CaledarMainView {
    private func getColor(_ date: YearMonthDay) -> Color {
        if date.dayOfWeek == .sun {
            return Color.red
        } else if date.dayOfWeek == .sat {
            return Color.blue
        } else {
            return Color.black
        }
    }
}
