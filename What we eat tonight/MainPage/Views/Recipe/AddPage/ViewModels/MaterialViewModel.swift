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
    enum MaterialVMState{
        static func == (lhs: MaterialViewModel.MaterialVMState, rhs: MaterialViewModel.MaterialVMState) -> Bool {
            switch(lhs, rhs){
            case (.loading, .loading):
                return true
            case (.success, .success):
                return true
            case (.saved, .saved):
                return true
            case ( .failure(_), .failure(_)):
                return true
            default:
                return false
            }
        }
        
        case loading
        case success
        case saved
        case failure(error: Error)
    }
    
    @Published var state: MaterialVMState = .loading
    @Published var error: Material.MaterialError?
    @Published var materialList: [Material] = [Material]()
    
    func getMaterials() async{
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            FirestoreService.shared.getMaterials { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success(let data):
                    self.materialList = data
                    self.state = .success
                }
            }
        }
    }
    
    func addMaterial(name: String, qty: Int) async {
        if emptyCheck(name: name, qty: qty){
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            FirestoreService.shared.addMaterial(name: name, qty: qty) { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success(let docID):
                    withAnimation{
                        self.materialList.insert(Material(id: docID, name: name, qty: qty), at: 0)
                    }
                    self.state = .success
                }
            }
        }
    }
    
    func editMaterial(id: String?, name: String, qty: Int) async {
        if id == nil{
            return
        }
        if emptyCheck(name: name, qty: qty){
            return
        }
        self.state = .loading
        let material = Material(id: id, name: name, qty: qty)
        FirestoreService.shared.editMaterial(material) { result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.state = .saved
                    withAnimation {
                        self.materialList.update(material)
                    }
                }
            }
        }
    }
    
    func deleteMaterial(id: String) async {
        FirestoreService.shared.deleteMaterial(docId: id) { [unowned self] result in
            switch result{
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation{
                        self.materialList.removeAll(where: { $0.id == id })
                    }
                }
            case .failure(let err):
                self.state = .failure(error: err)
            }
        }
    }
    
    private func emptyCheck(name: String, qty: Int) -> Bool{
        if name.isEmpty{
            withAnimation {
                error = Material.MaterialError.emptyName
            }
            return true
        }
        if qty < 0 {
            withAnimation {
                error = Material.MaterialError.negativeQty
            }
            return true
        }
        return false
    }
}
