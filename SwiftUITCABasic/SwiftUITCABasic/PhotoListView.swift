//
//  PhotoListView.swift
//  SwiftUITCABasic
//
//  Created by 박신영 on 4/29/25.
//

import SwiftUI

import ComposableArchitecture

struct PicsumImage: Equatable, Identifiable, Decodable {
    let id: String
    let author: String
    let downloadUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case downloadUrl = "download_url"
    }
}

/*
 리듀서에 필요한 의존성들을 간결하게 주입하는 방법을 제공해주는 것 뿐
 DependencyValue
 DependencyKey
 @Dependency
 */

//protocol NetworkProtocol {
//    static func callRequest() async throws -> [PicsumImage]
//}

//표준 인터페이스 제공(라이브, 테스트, 모킹 등)
extension NetworkManager: DependencyKey {
    static let liveValue = NetworkManager()
    
}

//DependencyValues에 networkManager 키 등록
//networkManager를 통해 객체를 저장하거나 읽어올 수 있고, 같은키로 라이브, 테스트, 모킹 등을 쉽게 변경할 수 있음.
extension DependencyValues {
    var networkManager: NetworkManager {
        get {
            self[NetworkManager.self]
        }
        set {
            self[NetworkManager.self] = newValue
        }
    }
}

struct NetworkManager {
    
    private init() {}
    
    func callRequest() async throws -> [PicsumImage] {
        let urlStr = "https://picsum.photos/v2/list?page=2&limit=100"
        let url = URL(string: urlStr)!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        let result = try decoder.decode([PicsumImage].self, from: data)
                
        return result
    }
    
}

@Reducer
struct PhotoList {
    
    @ObservableState
    struct State {
        var test = [PicsumImage]()
        var isLoading = false
    }
    
    enum Action {
        case loadButtonTapped
        case loadSucced([PicsumImage])
        case loadFailed
    }
    
    //리듀서에게 필요한 의존성을 간결하게 주입받을 수 있는 방법을 제공
    //@Dependency 매크로는 TCA가 자동으로 DependencyValues에서 해당 키를 찾아서 주입해줌
    @Dependency(\.networkManager) var jack
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadButtonTapped:
                state.isLoading = true
                
                return .run { send in
                    do {
                        let result = try await jack.callRequest()
                        await send(.loadSucced(result))
                    } catch {
                        await send(.loadFailed)
                    }
                }
            case .loadSucced(let result):
                state.test = result
                state.isLoading = false
                return .none
            case .loadFailed:
                state.test = []
                state.isLoading = false
                return .none
            }
        }
    }
    
    
    
}

struct PhotoListView: View {
    let store: StoreOf<PhotoList>
    
    var body: some View {
        VStack {
            Button("이미지 조회") {
                store.send(.loadButtonTapped)
            }
            if store.isLoading {
                ProgressView()
            }
            List(store.test, id: \.id) { item in
                HStack {
                    photo(item.downloadUrl)
                    Text(item.author)
                }
            }
        }
    }
    
    func photo(_ url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 50, height: 50)
            case .empty, .failure(_):
                Rectangle()
                    .fill(.gray)
                    .frame(width: 50, height: 50)
            @unknown default:
                Rectangle()
                    .fill(.gray)
                    .frame(width: 50, height: 50)
            }
        }
    }
    
}

#Preview {
    PhotoListView(
        store: Store(
            initialState: PhotoList.State(),
            reducer: {
                PhotoList()
            }, withDependencies: {
                $0.networkManager = NetworkManager.liveValue
            }
        )
    )
}
