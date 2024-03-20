//
//  HomeView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            CalendarCourseView()
                .tabItem {
                    Image(systemName: "calendar.circle.fill")
                    Text("Calrendar")
                }
                                                
            ArchiveView()
                .tabItem {
                    Image(systemName: "archivebox.circle.fill")
                    Text("Archive")
                }
        }        
    }
}

//#Preview {
//    TabBarView()
//}
