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
    @Published private(set) var materialList: [Material] = [Material]()
    
    func getMaterials() async{
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            FirestoreService.shared.getMaterials { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success(let data):
                    self.state = .success
                    withAnimation{
                        self.materialList = data
                    }
                }
            }
        }
    }
    
    func addMaterial(name: String) async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            FirestoreService.shared.addMaterial(name: name) { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success:
                    self.state = .success
                }
            }
        }
    }
    
    func deleteMaterial(id: String) async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
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
    }
}
