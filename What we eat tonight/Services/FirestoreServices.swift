//
//  FirestoreServices.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import Foundation
import Firebase
import FirebaseStorage

class FirestoreService{
    static let shared = FirestoreService()

    func getMaterials(completion: @escaping (Result<[Material], Error>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            Firestore.firestore().collection("Materials").getDocuments(completion: { querySnapshot, err in
                guard err == nil, let querySnapshot = querySnapshot else {
                    completion(.failure(err!))
                    return
                }
                
                let decoder = JSONDecoder()
                for document in querySnapshot.documents {
                            print("\(document.documentID) => \(document.data())")
                        }
                
    
                 if let data = try?  JSONSerialization.data(withJSONObject: querySnapshot, options: []) {
                   let materials = try? decoder.decode([Material].self, from: data)
                     completion(.success(materials!))
                   }
            })
                
            }
        }
    }
