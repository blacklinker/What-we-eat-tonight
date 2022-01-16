//
//  MaterialViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import Foundation
import Firebase
import SwiftUI

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
    
    func addMaterial(name: String) async {
        FirestoreService.shared.addMaterial(name: name) { result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success(let docId):
                self.state = .success
                withAnimation {
                    self.materialList?.append(Material(id: docId, name: name))
                }
            }
        }
    }
    
    func deleteMaterial(id: String) async {
        FirestoreService.shared.deleteMaterial(docId: id) { result in
            switch result{
            case .success:
                withAnimation{
                    self.materialList?.removeAll(where: { $0.id == id })
                }
            case .failure(let err):
                self.state = .failure(error: err)
            }
        }
    }
}
