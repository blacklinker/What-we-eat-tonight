//
//  FirestoreServices.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class FirestoreService{
    static let shared = FirestoreService()
    //Material Service API
    func getMaterials(completion: @escaping (Result<[Material], Error>) -> Void){
        let userID = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("Users").document(userID).collection("Material").getDocuments(completion: { querySnapshot, err in
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
    
    func addMaterial(name: String, completion: @escaping (Result<String, Error>) -> Void){
        let userID = Auth.auth().currentUser?.uid ?? ""
        let doc = Firestore.firestore().collection("Users").document(userID).collection("Material")
            .addDocument(data: ["name": name]) { err in
                if let err = err {
                    completion(.failure(err))
                }
            }
        completion(.success(doc.documentID))
    }
    
    func deleteMaterial(docId: String, completion: @escaping (Result<Bool, Error>) -> Void){
        let userID = Auth.auth().currentUser?.uid ?? ""
        Firestore.firestore().collection("Users").document(userID).collection("Material").document(docId).delete(){ err in
            if let err = err{
                completion(.failure(err))
            }else{
                completion(.success(true))
            }
        }
    }
    //END
    
    //Recipe Service API
    func addRecipe(name: String, image: UIImage, material: [Material], completion: @escaping (Result<Bool, Error>) -> Void){
        uploadImage(image: image) { [weak self] result in
            switch result{
            case .failure(let err):
                completion(.failure(err))
            case .success(let url):
                let newRecipe: [String: Any] = [
                    "name": name,
                    "imageUrl": url.absoluteString,
                    "material": self?.convertMaterialToDic(material: material) ?? "",
                    "AddDate": Date()
                ]
                let userID = Auth.auth().currentUser?.uid ?? ""
                Firestore.firestore().collection("Users").document(userID).collection("Recipes").addDocument(data: newRecipe) { err in
                    if let err = err {
                        completion(.failure(err))
                    }else{
                        completion(.success(true))
                    }
                }
            }
        }
    }
    
    private func convertMaterialToDic(material: [Material]) -> [Any] {
        var materialDic = [Any]()
        for item in material {
            materialDic.append([
                "id": item.id,
                "name": item.name
            ])
        }
        return materialDic
    }
    
    private func uploadImage(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void ){
        let userID = Auth.auth().currentUser?.uid ?? ""
        let data = image.jpegData(compressionQuality: 0.5)
        let storageRef = Firebase.Storage.storage().reference()
        let imageRef = storageRef.child("\(userID)/\(DateFormatter().string(from: Date()))")
        
        imageRef.putData(data!, metadata: nil) { (metadata, error) in
            guard metadata != nil, error == nil else {
                completion(.failure(error!))
                return
            }
            
            imageRef.downloadURL {(url, error) in
                guard let downloadURL = url else{
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }
}
