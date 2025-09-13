//
//  User.swift
//  Apple
//
//  Created by 석민솔 on 9/11/25.
//

import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: Int
    
    var name: String
    var age: Int
    
    @Attribute(.externalStorage) var imageData: Data?
    
    init(id: Int, name: String, age: Int, img: Data?) {
        self.id = id
        self.name = name
        self.age = age
        self.imageData = img
    }
}
