//
//  HomeView.swift
//  YourCourse
//
//  Created by 이민호 on 3/11/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        NavigationStack {
            TabView {
                
                CalendarView()
                    .tabItem {
                        Image(systemName: "calendar.circle.fill")
                        Text("Calrendar")
                    }
                
                CourseView()
                    .tabItem {
                        Image(systemName: "c.circle")
                        Text("Course")
                    }
                
                
                ArchiveView()
                    .tabItem {
                        Image(systemName: "archivebox.circle.fill")
                        Text("Archive")
                    }
               
            }
        }
    }
}

//#Preview {
//    TabBarView()
//}
