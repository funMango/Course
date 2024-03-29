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
    func fetchCourses() async throws -> AsyncThrowingStream<[Course], Error>
}

enum FirestoreAPIClientKey: DependencyKey {
    static var liveValue: FirestoreAPI = FirestoreAPIClient()
}

enum FetchCoursesResult {
    case success([Course])
    case failure(Error)
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
    
    func fetchCourses() async throws -> AsyncThrowingStream<[Course], Error> {
        AsyncThrowingStream<[Course], Error> { continuation in
            let collection = db.collection("Course")
                                          
            let listener = collection.addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    continuation.finish(throwing: error)
                    return
                }
                
                do {
                    let courses = try querySnapshot?.documents.compactMap { document -> Course? in
                        try document.data(as: Course.self)
                    } ?? []
                    continuation.yield(courses)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}

extension DependencyValues {
    var firestoreAPIClient: FirestoreAPI {
        get { self[FirestoreAPIClientKey.self] }
        set { self[FirestoreAPIClientKey.self] = newValue }
    }
}
