//
//  CoinDetailView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/16/25.
//

import SwiftUI

struct CoinDetailView: View {
    
    @Binding var data: Market
    
    var body: some View {
        CoinRowView(data: $data)
    }
}
