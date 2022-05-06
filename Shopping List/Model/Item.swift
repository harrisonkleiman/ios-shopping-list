//
//  Item.swift
//  Shopping List
//
//  Created by Harrison Kleiman on 5/6/22.
//

import Foundation

class Item: Encodable, Decodable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
