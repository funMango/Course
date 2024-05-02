//
//  EventCell.swift
//  YourCourse
//
//  Created by 이민호 on 5/2/24.
//

import SwiftUI

struct EventCell: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
            
            if !event.location.isEmpty {
                Spacer()
                    .frame(height: 5)
                
                Text(event.location)
                    .foregroundStyle(.gray)
                    .font(.system(size: 13))
            }
        }
    }
}
