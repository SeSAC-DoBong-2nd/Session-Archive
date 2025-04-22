//
//  PhotoView.swift
//  SwiftUIMVVM
//
//  Created by 박신영 on 4/22/25.
//

import SwiftUI

/* iOS 17
 - Swift Macro <<< 17때등장
    - 반복되는 코드를 줄여보자
    - 컴파일러에 기능을 주자
 - @Observable
 - @Bindable
 */

/* iOS 18
 - transition effect
 - @previewable
 - SwiftData
 */

struct ImageList: Hashable, Identifiable {
    let id = UUID()
    let url: String
}



struct PhotoView: View {
    let list = [
            ImageList(url: "https://fastly.picsum.photos/id/844/200/200.jpg?hmac=blYHTv1EUQA2puhc8O_7gTL4H6Y8FgSmVXDYEJqXWdQ"), ImageList(url: "https://fastly.picsum.photos/id/1/200/200.jpg?hmac=jZB9EZ0Vtzq-BZSmo7JKBBKJLW46nntxq79VMkCiBG8"), ImageList(url: "https://fastly.picsum.photos/id/29/200/200.jpg?hmac=555gm3Z1-4AkmdAj9t_Ql-1yIo7bMHpYRRyAz3xqavY")
        ]
    
    @Namespace private var jack
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(list, id: \.id) { item in
                    Text("\(item.id)")
                    NavigationLink(value: item) {
                        AsyncImage(url: URL(string: item.url))
                            .matchedTransitionSource(id: item, in: jack) //iOS18+
                        
                        ///이전에는 아래 GeometryEffect로 위 기능을 구현했었다.
//                            .matchedGeometryEffect(id: item, in: jack)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: ImageList.self) {
                PhotoDetailView(photo: $0)
                    .navigationTransition(.zoom(sourceID: $0, in: jack))
            }
            //NameSpace = iOS14+
        }
    }
}

struct PhotoDetailView: View {
    
    let photo: ImageList
    
    var body: some View {
        
        VStack {
            Text("Photo Detail View")
            Text("\(photo.id)")
            AsyncImage(url: URL(string: photo.url))
        }
    }
}

#Preview {
    PhotoView()
}
