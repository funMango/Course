//
//  FirestoreAPIClient.swift
//  YourCourse
//
//  Created by 이민호 on 3/22/24.
//

import Foundation
import Combine
import FirebaseFirestore
import ComposableArchitecture
import Dependencies

protocol FirestoreAPI {
    func saveCourse(course: Course) async throws
}

enum FirestoreAPIClientKey: DependencyKey {
    static var liveValue: FirestoreAPI = FirestoreAPIClient()
}


class FirestoreAPIClient: FirestoreAPI {
    private let db = Firestore.firestore()
            
    func saveCourse(course: Course) async throws {
        do {
            try await db.collection("Course").document(course.id).setData([
                "title": course.title,
                "location": course.location,
                "isAllDay": course.isAllDay,
                "memo": course.memo,
                "startDate": Timestamp(date: course.startDate),
                "endDate": Timestamp(date: course.endDate)
            ], merge: true)
        } catch let error {
            print("Course 저장에 실패하였습니다.")
            throw error
        }
    }
}

extension DependencyValues {
    var firestoreAPIClient: FirestoreAPI {
        get { self[FirestoreAPIClientKey.self] }
        set { self[FirestoreAPIClientKey.self] = newValue }
    }
}
