//
//  Test.swift
//  01_Complexity
//
//  Created by 박신영 on 3/25/25.
//

import Foundation

//DTO = Data Transfer Object
struct CoinResponse: Decodable {
    let id: Int
    let symbols: String
    let price: Int
    
    func transform() -> CoinData {
        .init(id: id, symbol: symbols, price: Double(price))
    }
}

struct CoinData {
    let id: Int
    let symbol: String
    let price: Double
}

class TestViewModel {
    //어떤 Repository
    
    func transform() {
        //어떤 Repository.fetchData() -> CoinData
    }
}
