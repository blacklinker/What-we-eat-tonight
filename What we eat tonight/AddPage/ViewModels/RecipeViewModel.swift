//
//  RecipeViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-23.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject{
    enum State {
        static func == (lhs: RecipeViewModel.State, rhs: RecipeViewModel.State) -> Bool {
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
    @Published var recipe: Recipe?
    @Published var materialList: [Material] = [Material]()
    @Published var recipesList: [Recipe] = [Recipe]()
    @Published var eatTodayRecipeIds: [TodayRecipe] = [TodayRecipe]()
    @Published var todayRecipes: [Recipe] = [Recipe]()
    @Published var todayRecipeMaterial: [String] = [String]()
    
    func addRecipe(name: String, image: UIImage, material: [Material]) async {
        self.state = .loading
        DispatchQueue.main.async {
            FirestoreService.shared.addRecipe(name: name, image: image, material: material) { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success:
                    withAnimation{
                        self.state = .saved
                    }
                }
            }
        }
    }
    
    func getRecipes() async {
        self.state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            FirestoreService.shared.getRecipes { [unowned self] result in
                switch result{
                case . failure(let err):
                    self.state = .failure(error: err)
                case .success(let recipes):
                    withAnimation {
                        self.recipesList = recipes
                    }
                    self.state = .success
                }
            }
        }
    }
    
    func deleteRecipe(id: String) async {
        FirestoreService.shared.deleteRecipe(docId: id){ [unowned self] result in
            switch result{
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation{
                        self.recipesList.removeAll(where: { $0.id == id })
                    }
                }
            case .failure(let err):
                self.state = .failure(error: err)
            }
        }
    }
    
    func deleteImage(imageUrl: String) async {
        FirestoreService.shared.deleteImage(imageUrl: imageUrl)
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
    
    func getEatToday() async{
        DispatchQueue.main.asyncAfter(deadline: .now()){
            FirestoreService.shared.getEatToday { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success(let data):
                    self.eatTodayRecipeIds = data
                }
            }
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
    
    func getTodayRecipe() async{
        let todayRecipeIds = self.eatTodayRecipeIds.map{ $0.recipeId }
        let lst = self.recipesList.filter{ todayRecipeIds.contains($0.id ?? "")}
        self.todayRecipes = lst
    }
    
    
    func getTodayRecipeMaterial() async{
        let todayRecipeIds = self.eatTodayRecipeIds.map{ $0.recipeId }
        let recipes = self.recipesList.filter{ todayRecipeIds.contains($0.id ?? "")}
        let lst = Array( recipes.map{ $0.material.map{ $0.name } }.joined())
        self.todayRecipeMaterial = Array(Set(lst))
    }
    
    func getMaterial() async {
        self.state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            FirestoreService.shared.getMaterials { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success(let data):
                    withAnimation{
                        self.materialList = data
                    }
                    self.state = .success
                }
            }
        }
    }
}
