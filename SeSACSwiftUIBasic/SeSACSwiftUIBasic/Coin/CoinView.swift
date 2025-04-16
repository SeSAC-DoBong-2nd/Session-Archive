//
//  CoinView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/16/25.
//

import SwiftUI

struct Money: Hashable, Identifiable {
    
    enum Category: String {
        case study = "자기계발"
        case food = "식비"
        case house = "정기지출"
        case hobby = "취미"
        case deposit = "저축"
    }
    
    let id = UUID()
    let amount: Int
    var product: String
    let category: Category
    
    var amountFormat: String {
        return String(amount.formatted()) + "원"
    }
}

struct CoinView: View {
    
    @State private var money: [Market] = []
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    horizontalScrollView()
                    listView()
                }
            }
            .navigationTitle("My Money")
            .navigationBar(leading: {
                Image(systemName: "person")
                    .wrapToButton {
                        print("ㄷㄷㄷ")
                    }
            })
            .refreshable { //iOS15+
                money.shuffle()
            }
        }
        /// onAppear: 통신목적은 아님, 뷰가 뜰 때의 이벤트를 핸들링하는 것이 주 목적.
        /// 단점: 비동기 코드는 Task {}를 사용해야한다. 아래 처럼 통신이 길게 걸리는 경우 문제발생
        /// 1GB 영상 다운받는 직업. 나사 용량 큰 이미지를 다운 받는 기능. 작업 취소.
        ///     -> iOS15+: .task 라는 modifier 등장
        
        //id는 옵션으로, task 안의 코드가 원하는 시점에 동작하게끔 하는 것. 해당 시점에 id값을 바꾸면 된다
        .task(id: 1) { //비동기 컨텍스트를 자동으로 생성. +@ 뷰가 사라지면 알아서 취소된다.
            do {
                let market = try await Network.fetchAllMarket()
                self.money = market
            } catch APIError.invalidResponse {
                money = []
                print("유효하지 않은 상태코드")
            } catch {
                print("기타 에러 로직 처리")
            }
        }
        
        .onAppear { //willAppear, 동기, 비동기
            print("onAppear")
//            Task {
//                do {
//                    let market = try await Network.fetchAllMarket()
//                    self.money = market
//                } catch APIError.invalidResponse {
//                    money = []
//                    print("유효하지 않은 상태코드")
//                } catch {
//                    print("기타 에러 로직 처리")
//                }
//            }
        }
    }
    
    //SwiftUI iOS17+ ScrollView
    private func horizontalScrollView() -> some View {
        ScrollView(.horizontal) { //container
            HStack {
                ForEach(0..<5) { item in
                    bannerView()
                        .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        
    }
    
    func listView() -> some View {
        LazyVStack(spacing: 15) {
            ForEach($money, id: \.id) { item in
                NavigationLink {
                    CoinDetailView(data: item)
                } label: {
                    CoinRowView(data: item)
                }
                .buttonStyle(.plain)
            }
        }
        .font(.title)
    }
    
    //View Text, Vstack: 컨텐츠 기반 뷰의 크기 시작이 작은쪽 -> 커지는 쪽으로 frame 증가
    //Rectangle, Space: 커질 수 있는 만큼 커진 상태로 뷰의 크기가 시작된다
    
    //Zstack View vs overlay Modifier
    //fill vs background
    //.fontweightBold vs bold()
    //.onAppear vs .task (버전 차이 있고, 비동기 핸들링 방법 차이도 있고 등등)
    func bannerView() -> some View {
        ZStack{
            Rectangle()
                .fill(.brown)
                .overlay(alignment: .leading) {
                    Circle()
                        .fill(.lightBrown)
                        .scaleEffect(2, anchor: .topLeading)
                        .offset(x: -70, y: -70)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
            
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                Text("나의 소비내역")
                    .font(.callout)
                Text("408,150원")
                    .font(.title)
                    .bold()
            }
            .padding(20)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.horizontal, 10)
        .frame(height: 150)
    }
}

struct CoinRowView: View {
    
    @Binding var data: Market
    
    //Hit Test: touch Test
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.koreanName)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(data.englishName)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(data.market)
                .font(.subheadline)
            Button(action: {
                data.like.toggle()
            }, label: {
                let image = data.like ? "star.fill" : "star"
                Image(systemName: image)
            })
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 6)
        .contentShape(Rectangle())
    }
}

#Preview {
    CoinView()
}

