//
//  Category.swift
//  Todoey
//
//  Created by vagelis spirou on 16/05/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>() 
}
