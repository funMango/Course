//
//  EventList.swift
//  YourCourse
//
//  Created by 이민호 on 5/2/24.
//

import SwiftUI
import ComposableArchitecture

struct EventList: View {
    let store: StoreOf<EventsFeature>
    let coursId: String
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ForEach(viewStore.events, id: \.self) { event in
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
    }
}
