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
                
                let materials = querySnapshot.documents.map { queryDocumentSnapshot -> Material in
                    let data = queryDocumentSnapshot.data()
                    let name = data["name"] as? String ?? ""
                    let id = queryDocumentSnapshot.documentID
                    
                    return Material(id: id, name: name)
                }
                completion(.success(materials))
            })
            
        }
    }
    
    func addMaterial(name: String, completion: @escaping (Result<String, Error>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            let doc = Firestore.firestore().collection("Materials")
                .addDocument(data: ["name": name]) { err in
                    if let err = err {
                        completion(.failure(err))
                    }
                }
            completion(.success(doc.documentID))
        }
    }
}
