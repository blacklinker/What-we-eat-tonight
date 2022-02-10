//
//  AddRecipeViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-07.
//
import Foundation
import SwiftUI

class AddRecipeViewModel: ObservableObject{
    enum State {
        static func == (lhs: AddRecipeViewModel.State, rhs: AddRecipeViewModel.State) -> Bool {
            switch(lhs, rhs){
            case (.na, .na):
                return true
            case (.loading, .loading):
                return true
            case (.success, .success):
                return true
            case (.saved, .saved ):
                return true
            case ( .failure(_), .failure(_)):
                return true
            default:
                return false
            }
        }
        
        case na
        case loading
        case success
        case saved
        case failure(error: Error)
    }
    
    @Published var state: State = .na
    @Published var allMaterialList: [Material] = [Material]()
    
    init(){
        self.getAllMaterial()
    }
    
    
    func addRecipe(name: String, image: UIImage?) async {
        self.state = .loading
        if name.isEmpty{
            self.state = .failure(error: Recipe.RecipeError.emptyName)
            return
        }
        DispatchQueue.main.async{
            let material = self.allMaterialList.filter{ $0.qty > 0 }
            FirestoreService.shared.addRecipe(name: name, image: image, material: material) { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success:
                    withAnimation{
                        self.state = .saved
                        self.initilzeMaterialList()
                    }
                }
            }
        }
    }

    func getAllMaterial() {
        self.state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            FirestoreService.shared.getMaterials { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success(let data):
                    withAnimation{
                        for material in data {
                            self.allMaterialList.append(Material(id: material.id, name: material.name, qty: 0))
                        }
                    }
                    self.state = .success
                }
            }
        }
    }
    
    func addMaterial(id: String?, qty: String) async {
        guard let id = id else{
            return
        }
        if id.isEmpty || qty.isEmpty {
            withAnimation {
                self.state = .failure(error: Material.MaterialError.negativeQty)
            }
        } else {
            guard let index = self.allMaterialList.firstIndex(where: { $0.id == id }) else {
                withAnimation {
                    self.state = .failure(error: Material.MaterialError.unknown)
                }
                return
            }
            self.allMaterialList[index].qty = Int(qty) ?? 0
        }
    }
    
    private func initilzeMaterialList(){
        for index in allMaterialList.indices {
            allMaterialList[index].qty = 0
        }
    }
}
