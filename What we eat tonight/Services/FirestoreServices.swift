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
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Material").getDocuments(completion: { querySnapshot, err in
            guard err == nil, let querySnapshot = querySnapshot else {
                completion(.failure(err!))
                return
            }
            
            let materials = querySnapshot.documents.map { queryDocumentSnapshot -> Material? in
                do{
                    let material = try queryDocumentSnapshot.data(as: Material.self)
                    return material
                } catch {
                    completion(.failure(error))
                    return nil
                }
            }
            completion(.success(materials.compactMap{ $0 }))
        })
    }
    
    func addMaterial(name: String, qty: Int, completion: @escaping (Result<String, Error>) -> Void){
        let doc = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Material")
            .addDocument(data: [
                "name": name,
                "qty": qty
            ]) { err in
                if let err = err {
                    completion(.failure(err))
                    return
                }
            }
        completion(.success(doc.documentID))
    }
    
    func deleteMaterial(docId: String, completion: @escaping (Result<Bool, Error>) -> Void){
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Material").document(docId).delete(){ err in
            if let err = err{
                completion(.failure(err))
            }else{
                completion(.success(true))
            }
        }
    }
    
    func editMaterial(_ material: Material, completion: @escaping (Result<Bool, Error>) -> Void){
        do{
            try Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Material").document(material.id ?? "").setData(from: material){ err in
                guard let err = err else{
                    completion(.success(true))
                    return
                }
                completion(.failure(err))
            }
        }
        catch{
            completion(.failure(error))
        }
    }
    //END
    
    //Recipe Service API
    func getRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void){
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Recipes").getDocuments(completion: { querySnapshot, err in
            guard err == nil, let querySnapshot = querySnapshot else {
                completion(.failure(err!))
                return
            }
            let recipes = querySnapshot.documents.map { queryDocumentSnapshot -> Recipe? in
                do {
                    let recipe = try queryDocumentSnapshot.data(as: Recipe.self)
                    return recipe
                } catch {
                    completion(.failure(error))
                    return nil
                }
            }
            completion(.success(recipes.compactMap{ $0 }))
        })
    }
    
    func updateRecipe(recipe: Recipe, image: UIImage?, completion: @escaping (Result<Bool, Error>) -> Void) {
        let documentRef = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Recipes").document(recipe.id ?? "")
        documentRef.getDocument { [unowned self] (document, error) in
            if let document = document, document.exists {
                do{
                    let dataDescription = try document.data(as: Recipe.self)
                    if image != nil{
                        if !dataDescription!.imageUrl.isEmpty{
                            deleteImage(imageUrl: dataDescription!.imageUrl)
                        }
                        uploadImage(image: image) { [weak self] result in
                            switch result{
                            case .failure(let err):
                                completion(.failure(err))
                            case .success(let url):
                                let newRecipe: [String: Any] = [
                                    "name": recipe.name,
                                    "imageUrl": url.absoluteString,
                                    "material": self?.convertMaterialToDic(material: recipe.material) ?? "",
                                    "AddDate": Date()
                                ]
                                documentRef.setData(newRecipe)
                            }
                        }
                    } else {
                        let newRecipe: [String: Any] = [
                            "name": recipe.name,
                            "imageUrl": recipe.imageUrl,
                            "material": self.convertMaterialToDic(material: recipe.material),
                            "AddDate": Date()
                        ]
                        documentRef.setData(newRecipe)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error!))
                return
            }
        }
    }
    
    func addRecipe(name: String, image: UIImage?, material: [Material], completion: @escaping (Result<Bool, Error>) -> Void){
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
                Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Recipes").addDocument(data: newRecipe) { err in
                    if let err = err {
                        completion(.failure(err))
                    }else{
                        completion(.success(true))
                    }
                }
            }
        }
    }
    
    func deleteRecipe(docId: String, completion: @escaping (Result<Bool, Error>) -> Void){
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Recipes").document(docId).delete(){ err in
            if let err = err{
                completion(.failure(err))
            }else{
                completion(.success(true))
            }
        }
    }
    
    func deleteImage(imageUrl: String){
        if !imageUrl.isEmpty{
            Firebase.Storage.storage().reference(forURL: imageUrl).delete()
        }
    }
    
    func addToEatToday(docId: String, completion: @escaping (Result<String, Error>) -> Void){
        let doc = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("EatTonight").addDocument(data: ["recipeId": docId]) { err in
            if let err = err {
                completion(.failure(err))
                return
            }
        }
        completion(.success(doc.documentID))
    }
    
    func getEatToday(completion: @escaping (Result<[TodayRecipe], Error>) -> Void){
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("EatTonight").getDocuments (completion: { querySnapshot, err in
            guard err == nil, let querySnapshot = querySnapshot else{
                completion(.failure(err!))
                return
            }
            
            let todayRecipes = querySnapshot.documents.map { queryDocumentSnapshot -> TodayRecipe? in
                do {
                    let todayRecipe = try queryDocumentSnapshot.data(as: TodayRecipe.self)
                    return todayRecipe
                } catch {
                    completion(.failure(error))
                    return nil
                }
            }

            completion(.success(todayRecipes.compactMap{ $0 }))
        })
    }
    
    func removeEatToday(docId: String, completion: @escaping (Result<Bool, Error>) -> Void){
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("EatTonight").document(docId).delete(){ err in
            if let err = err{
                completion(.failure(err))
            }else{
                completion(.success(true))
            }
        }
    }
    
    private func convertMaterialToDic(material: [Material]) -> [Any] {
        var materialDic = [Any]()
        for item in material {
            materialDic.append([
                "id": item.id ?? "",
                "name": item.name,
                "qty": item.qty
            ])
        }
        return materialDic
    }
    
    private func convertMaterialToDic(material: [RecipeMaterial]) -> [Any] {
        var materialDic = [Any]()
        for item in material {
            materialDic.append([
                "id": item.id,
                "name": item.name,
                "qty": item.qty
            ])
        }
        return materialDic
    }
    
    private func uploadImage(image: UIImage?, completion: @escaping (Result<URL, Error>) -> Void ){
        guard let image = image else {
            completion(.success(URL(string: "empty")!))
            return
        }
        let data = image.jpegData(compressionQuality: 0.05)
        let storageRef = Firebase.Storage.storage().reference()
        let imageRef = storageRef.child("\(Auth.auth().currentUser?.uid ?? "")/\(Date()).jpg")
        
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
    //end Recipe API
}
