//
//  Order.swift
//  CupcakeCorner
//
//  Created by Lucas Chae on 5/16/22.
//

import SwiftUI

class Order: ObservableObject, Codable {
    // Enum that conforms to CodingKey, listing all the properties we want to save.
    enum CodingKeys: CodingKey {
        case flavor, quantity, extraFilling, extraSprinkles, name, streetAddress, city, zip
    }
    
    
    static let flavors = ["Glazed", "Strawberry", "Chocolate", "Banana", "Rainbow"]
    
    @Published var flavor = 0
    @Published var quantity = 1
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFilling = false
                extraSprinkles = false
            }
        }
    }
    @Published var extraFilling = false
    @Published var extraSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
            return true
    }
    
    var price: Double {
        var price = Double(quantity) * 2
        price += (Double(flavor) / 2)
        
        if extraFilling {
            price += Double(quantity)
        }
        if extraSprinkles {
            price += Double(quantity) / 2
        }
        return price
    }
    
    // encode(to:) method that creates a container using the coding keys enum, then writes out all the properties attached to their respective keys.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(flavor, forKey: .flavor)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraFilling, forKey: .extraFilling)
        try container.encode(extraSprinkles, forKey: .extraSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        flavor = try container.decode(Int.self, forKey: .flavor)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFilling = try container.decode(Bool.self, forKey: .extraFilling)
        extraSprinkles = try container.decode(Bool.self, forKey: .extraSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() { }
}
