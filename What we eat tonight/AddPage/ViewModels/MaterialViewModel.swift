//
//  MaterialViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import Foundation
import Firebase

class MaterialViewModel : ObservableObject{
    @Published var materials = [Material]()
    @Published var showProgressView = false
    
    func getMaterials(completion: @escaping ([Material]) -> Void){
        FirestoreService.shared.getMaterials{ (result: Result<[Material], Error>) in
            self.showProgressView = true
            switch result{
            case .success:
                completion(result.get())
            case .failure:
                completion(result.get())
            }
            
        }
    }
}
