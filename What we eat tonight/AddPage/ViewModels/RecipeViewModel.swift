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
    enum State{
        case na
        case loading
        case success
        case failure(error: Error)
    }
    
    @Published private(set) var state: State = .na
    @Published var recipe: Recipe?
    @Published var materialList: [Material] = [Material]()
    
    func getRecipe() async {
        
    }
    
    func addRecipe(name: String, image: UIImage, material: [Material]) async {
        DispatchQueue.main.async {
            FirestoreService.shared.addRecipe(name: name, image: image, material: material) { [unowned self] result in
                switch result{
                case .failure(let err):
                    self.state = .failure(error: err)
                case .success:
                    self.state = .success
                }
            }
        }
    }
    
    func getMaterial() async {
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
