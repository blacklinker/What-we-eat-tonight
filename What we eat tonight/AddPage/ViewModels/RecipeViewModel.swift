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
