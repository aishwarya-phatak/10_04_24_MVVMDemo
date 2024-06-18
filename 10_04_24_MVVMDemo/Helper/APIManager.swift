//
//  APIManager.swift
//  10_04_24_MVVMDemo
//
//  Created by Vishal Jagtap on 18/06/24.
//

import Foundation
enum DataError : Error{
    case invalidURL
    case invalidResponse
    case invalidDecoding
    case network(Error?)
}

typealias Handler = ((Result<[Product],DataError>)->Void)

final class APIManager{

    static let shared = APIManager()
    private init(){}
    
    func fetchProducts(completionHandler : @escaping Handler){
        guard let url = URL(string: Constant.API.productUrl) else {return}
        
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            do{
                let products = try jsonDecoder.decode([Product].self, from: data!)
                completionHandler(.success(products))
            }catch{
                completionHandler(.failure(error as! DataError))
            }
        }
        dataTask.resume()
    }
}
