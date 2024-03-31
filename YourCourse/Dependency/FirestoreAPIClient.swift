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
        let courseRef = db.collection("Course").document(course.id)
                
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try courseRef.setData(from: course) { error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: ())
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func fetchCourses() async throws -> AsyncThrowingStream<[Course], Error> {
        AsyncThrowingStream<[Course], Error> { continuation in
            let collection = db.collection("Course")
                                          
            _ = collection.addSnapshotListener { (querySnapshot, error) in
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
