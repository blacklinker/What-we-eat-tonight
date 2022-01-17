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
        Firestore.firestore().collection("Materials").addSnapshotListener{ querySnapshot, err in
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
        }
    }
    
    func addMaterial(name: String, completion: @escaping (Result<String, Error>) -> Void){
        let doc = Firestore.firestore().collection("Materials")
            .addDocument(data: ["name": name]) { err in
                if let err = err {
                    completion(.failure(err))
                }
            }
        completion(.success(doc.documentID))
    }
    
    func deleteMaterial(docId: String, completion: @escaping (Result<Bool, Error>) -> Void){
        Firestore.firestore().collection("Materials").document(docId).delete(){ err in
            if let err = err{
                completion(.failure(err))
            }else{
                completion(.success(true))
            }
        }
    }
}
