//
//  MaterialViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import Foundation
import Firebase

@MainActor
class MaterialViewModel : ObservableObject{
    enum State{
        case loading
        case success
        case failure(error: Error)
    }
    
    @Published private(set) var state: State = .loading
    @Published private(set) var materialList: [Material]?

    func getMaterials() async{
        FirestoreService.shared.getMaterials { result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success(let data):
                self.state = .success
                self.materialList = data
            }
        }
    }
    
    func addMaterials(name: String) async {
        FirestoreService.shared.addMaterial(name: name) { result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success(let docId):
                self.state = .success
                self.materialList?.append(Material(id: docId, name: name))
            }
        }
    }
}
