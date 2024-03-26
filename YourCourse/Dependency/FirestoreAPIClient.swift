//
//  FirestoreAPIClient.swift
//  YourCourse
//
//  Created by 이민호 on 3/22/24.
//

import Foundation
import FirebaseFirestore
import ComposableArchitecture
import Dependencies

protocol FirestoreAPI {
    func saveCourse(course: Course) async throws
    func fetchCourses() async throws -> [Course]
}

enum FirestoreAPIClientKey: DependencyKey {
    static var liveValue: FirestoreAPI = FirestoreAPIClient()
}


class FirestoreAPIClient: FirestoreAPI {
    private let db = Firestore.firestore()
    
    func saveCourse(course: Course) async throws {
        do {
            try await db.collection("Course").document(course.id).setData([
                "id": course.id,
                "title": course.title,
                "location": course.location,
                "memo": course.memo,
                "startDate": Timestamp(date: course.startDate),
                "endDate": Timestamp(date: course.endDate)
            ], merge: true)
        } catch let error {
            print("Course 저장에 실패하였습니다.")
            throw error
        }
    }
    
    func fetchCourses() async throws -> [Course] {
        do {
            let collection = db.collection("Course")
            let snapshot = try await collection.getDocuments()
            var courses: [Course] = []

            for document in snapshot.documents {
                do {
                    let course = try document.data(as: Course.self)
                    courses.append(course)
                } catch {
                    print("Course decoding에 실패하였습니다.: \(document.documentID), error: \(error)")
                }
            }
            return courses
        } catch let error {
            print("Course fetch에 실패하였습니다: \(error)")
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
