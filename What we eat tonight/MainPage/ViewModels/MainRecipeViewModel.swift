//
//  MainRecipeViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-09.
//
import Foundation
import SwiftUI

@MainActor
class MainRecipeViewModel: ObservableObject{
    enum State {
        static func == (lhs: MainRecipeViewModel.State, rhs: MainRecipeViewModel.State) -> Bool {
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
    @Published var materialList: [Material] = [Material]()
    @Published var recipesList: [Recipe] = [Recipe]()
    @Published var eatTodayRecipeIds: [TodayRecipe] = [TodayRecipe]()
    @Published var todayRecipes: [Recipe] = [Recipe]()
    @Published var mainRecipeMaterial: [MainRecipeMaterial] = [MainRecipeMaterial]()
    
    func getAllData() async {
        self.state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getRecipes()
        }
    }
    
    
    func removeEatToday(recipeId: String) async{
        let todayRecipe = self.eatTodayRecipeIds.first{ $0.recipeId == recipeId }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
            FirestoreService.shared.removeEatToday(docId: todayRecipe?.id ?? ""){ [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success:
                    withAnimation{
                        self.eatTodayRecipeIds.removeAll(where: { $0.recipeId == recipeId })
                        self.todayRecipes.removeAll(where: { $0.id == recipeId })
                    }
                }
            }
        }
    }
    
    func deleteRecipe(id: String, imageUrl: String) async {
        FirestoreService.shared.deleteRecipe(docId: id){ [unowned self] result in
            switch result{
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    FirestoreService.shared.deleteImage(imageUrl: imageUrl)
                    withAnimation{
                        self.recipesList.removeAll(where: { $0.id == id })
                    }
                }
            case .failure(let err):
                self.state = .failure(error: err)
            }
        }
    }
    
    func addToEatToday(recipeId: String) async{
        FirestoreService.shared.addToEatToday(docId: recipeId) { result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success(let docId):
                withAnimation{
                    self.eatTodayRecipeIds.append(TodayRecipe(id: docId, recipeId: recipeId ))
                }
                self.state = .success
            }
        }
    }
    
    
    private func getRecipes() {
        FirestoreService.shared.getRecipes { [unowned self] result in
            switch result{
            case . failure(let err):
                self.state = .failure(error: err)
            case .success(let recipes):
                withAnimation {
                    self.recipesList = recipes
                }
                self.getEatToday()
            }
        }
    }
    
    private func getEatToday(){
        FirestoreService.shared.getEatToday { [unowned self] result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success(let data):
                self.eatTodayRecipeIds = data
                self.getTodayRecipe()
            }
        }
    }
    
    private func getTodayRecipe(){
        let todayRecipeIds = self.eatTodayRecipeIds.map{ $0.recipeId }
        let lst = self.recipesList.filter{ todayRecipeIds.contains($0.id ?? "")}
        self.todayRecipes = lst
        self.getMaterial()
    }
    
    private func getMaterial() {
        self.state = .loading
        FirestoreService.shared.getMaterials { [unowned self] result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success(let data):
                withAnimation{
                    self.materialList = data
                }
                self.getMainRecipeMaterial()
                self.state = .success
            }
        }
        
    }
    
    private func getMainRecipeMaterial(){
        let todayRecipeIds = self.eatTodayRecipeIds.map{ $0.recipeId }
        let recipes = self.recipesList.filter{ todayRecipeIds.contains($0.id ?? "")}
        let lst = Array(recipes.map{ $0.material }.joined())
        self.mainRecipeMaterial = [MainRecipeMaterial]()
        for material in self.materialList{
            let items = lst.filter{ $0.id == material.id }
            if items.count > 0 {
                self.mainRecipeMaterial.append(MainRecipeMaterial(id: material.id ?? "", name: material.name, inStock: material.qty, qty: (items.map{ $0.qty }).reduce(0, +)))
            }else{
                self.mainRecipeMaterial.append(MainRecipeMaterial(id: material.id ?? "", name: material.name, inStock: material.qty, qty: 0))
            }
        }
    }
}

struct MainRecipeMaterial{
    let id: String
    let name: String
    let inStock: Int
    let qty: Int
}

