//
//  SearchView.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/15/25.
//

import SwiftUI
/// NavigationController
///     -> NavigationView / NavigationStack(iOS16+)
/// NavigationBar
/// NavigationItem

///NavigationView 1
//struct SearchView: View {
//
//    var body: some View {
//        NavigationView {
//            VStack{
//                Text("Hello world")
//                //button+push = NavigationLink
//                NavigationLink("열려라 Detail View") {
//                    SearchDetailView()
//                }
//                NavigationLink {
//                    TamagochiView()
//                } label: {
//                    PosterView()
//                        .background(.red)
//                }
//
//            }
//                .navigationTitle("케케몬")
//                .navigationBarTitleDisplayMode(.inline)
//        }
//
//
//    }
//
//}

struct Category: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}


///NavigationView 2
struct SearchView: View {
    
    @State private var searchQuery = ""
    @State private var isPresentedTamagochiView = false
    
    @State private var category = [
        Category(name: "스릴러", count: 1),
        Category(name: "스릴러", count: 1),
        Category(name: "스릴러", count: 1),
        Category(name: "로맨스", count: 4),
        Category(name: "애니메이션", count: 5),
    ]
    
    var filterCategory: [Category] {
        return searchQuery.isEmpty ? category : category.filter { $0.name.contains(searchQuery) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filterCategory, id: \.id) { index in
                    NavigationLink {
                        SearchDetailView(number: index.count)
                    } label: {
                        setupRows(category: index)
                    }
                    
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "장르를 검색해보세요")
            .sheet(isPresented: $isPresentedTamagochiView, content: {
                TamagochiView()
            })
            //.fullScrennCover
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "plus")
                        .wrapToButton {
                            isPresentedTamagochiView = true
                        }
                }
            }
            //present fullscreen
        }
    }
    
    func setupRows(category: Category) -> some View {
        HStack {
            Image(systemName: "person")
            Text("\(category.name)(\(category.count))")
        }
    }
    
}

struct SearchDetailView: View {
    
    let number: Int
    
    init(number: Int) {
        self.number = number
        print("SearchDetailView Init")
    }
    
    var body: some View {
        Text("Detail View \(number)")
    }
    
}

#Preview {
    SearchView()
}
