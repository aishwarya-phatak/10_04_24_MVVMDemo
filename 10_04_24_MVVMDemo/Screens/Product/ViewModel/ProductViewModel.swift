//
//  ProductViewModel.swift
//  10_04_24_MVVMDemo
//
//  Created by Vishal Jagtap on 18/06/24.
//

import Foundation
final class ProductViewModel{
    var products : [Product] = []
    var eventHandler : ((_ event : Event)->Void)?
    func fetchProducts(){
       // self.eventHandler!(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler!(.stopLoading)
            switch response{
            case .success(let products):
                self.products = products
                self.eventHandler!(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler!(.error(DataError.invalidResponse))
            }
        }
    }
}

extension ProductViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(DataError)
    }
}
