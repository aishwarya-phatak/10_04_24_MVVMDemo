//
//  Product.swift
//  10_04_24_MVVMDemo
//
//  Created by Vishal Jagtap on 18/06/24.
//

import Foundation
struct Product : Decodable{
    var id : Int
    var title : String
    var price : Double
    var description : String
    var category : String
    var image : String
    var rating : Rating
}

struct Rating : Decodable{
    var rate : Double
    var count : Int
}
