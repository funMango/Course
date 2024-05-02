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
    func fetchCourse(courseId: String) async throws -> AsyncThrowingStream<Course, Error>
    func fetchCourses() async throws -> AsyncThrowingStream<[Course], Error>
    func fetchEvent(courseId:String, eventId: String) async throws ->  AsyncThrowingStream<Event, Error>
    func saveEvent(courseId: String, event: Event) async throws
    func fetchEvents(courseId: String) async throws -> AsyncThrowingStream<[Event], Error>
    func saveEvents(courseId: String, events: [Event]) async throws    
}

enum FirestoreAPIClientKey: DependencyKey {
    static var liveValue: FirestoreAPI = FirestoreAPIClient()
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
    
    func fetchCourse(courseId: String) async throws -> AsyncThrowingStream<Course, Error> {
        AsyncThrowingStream<Course, Error> { continuation in
            let collection = db.collection("Course").document(courseId)
            
            _ = collection.addSnapshotListener{ (querySnapshot, error) in
                if let error = error {
                    continuation.finish(throwing: error)
                    return
                }
                                
                do {
                    if let course = try querySnapshot?.data(as: Course.self) {
                        continuation.yield(course)
                    }
                } catch {
                    continuation.finish(throwing: error)
                }
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
    
    func fetchEvent(courseId:String, eventId: String) async throws ->  AsyncThrowingStream<Event, Error> {
        AsyncThrowingStream<Event, Error> { [weak self] continuation in
            let collection = self?.db.collection("Course").document(courseId).collection("Event").document(eventId)
            
            _ = collection?.addSnapshotListener{ (querySnapshot, error) in
                if let error = error {
                    continuation.finish(throwing: error)
                    return
                }
                                
                do {
                    if let event = try querySnapshot?.data(as: Event.self) {
                        continuation.yield(event)
                    }
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    func saveEvent(courseId: String, event: Event) async throws {
        let eventRef = db.collection("Course").document(courseId).collection("Event").document(event.id)
        
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try eventRef.setData(from: event) { error in
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
    
    func fetchEvents(courseId: String) async throws -> AsyncThrowingStream<[Event], Error> {
        AsyncThrowingStream<[Event], Error> { [weak self] continuation in
            let collection = self?.db.collection("Course").document(courseId).collection("Event")
            
            _ = collection?.addSnapshotListener { (querySnapshot, error) in
                if let error = error  {
                    continuation.finish(throwing: error)
                    return
                }
                
                do {
                    let events = try querySnapshot?.documents.compactMap { document -> Event? in
                        try document.data(as: Event.self)
                    } ?? []
                    continuation.yield(events)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    func saveEvents(courseId: String, events: [Event]) async throws {
        for event in events {
            do {
                try await saveEvent(courseId: courseId, event: event)
            } catch {
                throw error
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
