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
    @Published var recipe: Recipe
    @Published var image: UIImage?

    init(_ recipe: Recipe = Recipe(id: "", name: "", imageUrl: "", material: [])){
        self.recipe = recipe
        self.getAllMaterial()
    }
    
    
    func addOrUpdateRecipe() async {
        self.state = .loading
        if self.recipe.name.isEmpty{
            self.state = .failure(error: Recipe.RecipeError.emptyName)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            let material = self.allMaterialList.filter{ $0.qty > 0 }
            if self.recipe.id!.isEmpty {
                FirestoreService.shared.addRecipe(name: self.recipe.name, image: self.image, material: material) { [unowned self] result in
                    switch result{
                    case .failure(let err):
                        self.state = .failure(error: err)
                    case .success:
                        withAnimation{
                            self.initilzeMaterialList()
                            self.state = .saved
                        }
                    }
                }
            } else {
                FirestoreService.shared.updateRecipe(recipe: self.recipe, image: self.image) { [unowned self] result in
                    switch result{
                    case .failure(let err):
                        self.state = .failure(error: err)
                    case .success:
                        withAnimation{
                            self.initilzeMaterialList()
                            self.state = .saved
                        }
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
                    self.allMaterialList = [Material]()
                    for material in data {
                        self.allMaterialList.append(Material(id: material.id, name: material.name, qty: 0))
                    }
                    withAnimation{
                        self.initilzeMaterialList()
                    }
                    self.state = .success
                }
            }
        }
    }
    
    func addMaterial(material: Material, qty: String) async {
        guard let id = material.id else{
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
            let value = Int(qty) ?? 0
            self.allMaterialList[index].qty = value
            if value == 0{
                self.recipe.material.removeAll(where: { $0.id == id })
            }
            else {
                guard let mIndex = self.recipe.material.firstIndex(where: { $0.id == id }) else {
                    self.recipe.material.append(RecipeMaterial( id: id, name: material.name, qty: value ))
                    return
                }
                self.recipe.material[mIndex].qty = value
            }
        }
    }

    private func initilzeMaterialList(){
        for index in allMaterialList.indices {
            let qty = self.recipe.material.first{ $0.id == allMaterialList[index].id }?.qty ?? 0
            allMaterialList[index].qty = qty
        }
        self.allMaterialList = self.allMaterialList.sorted{ $0.qty > $1.qty }
    }
}
