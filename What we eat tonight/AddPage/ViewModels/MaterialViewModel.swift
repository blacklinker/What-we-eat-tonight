//
//  MaterialViewModel.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-01-12.
//

import Foundation
import Firebase

class MaterialViewModel : ObservableObject{
    
    enum State{
        case na
        case loading
        case success(data: [Material])
        case failure(error: Error)
    }
    
    @Published private(set) var state: State = .na
    
    func getMaterials() async {
        FirestoreService.shared.getMaterials { result in
            switch result{
            case .failure(let err):
                self.state = .failure(error: err)
            case .success(let data):
                self.state = .success(data: data)
            }
        }
        
        
    }
}
