//
//  ApplicationExtensions.swift
//  What we eat tonight
//
//  Created by Cheng Peng on 2022-02-05.
//

import Foundation
import SwiftUI


extension Array where Element == Material{
    mutating func update(_ material: Material){
        self.removeAll(where: { $0.id == material.id })
        self.append(material)
    }
}
