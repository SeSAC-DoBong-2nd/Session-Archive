//
//  ViewController.swift
//  SeSACInAppExLecture
//
//  Created by 박신영 on 5/21/25.
//

import UIKit
import StoreKit
//StoreKit (~iOS 18): Delegate
//StoreKit2 (Swift Concurrency) + Configuration

class ViewController: UIViewController {
    
    private let productIdentifiers: Set<Product.ID> = [
        "com.sesac.jack",
        "com.sesac.jack.diamond200"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await loadProductData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    //Product -> edit Scheme -> StoreKit Configuration 파일 설정
    func loadProductData() async {
        print(#function)
        do {
            let product = try await Product.products(for: productIdentifiers)
            
            for item in product {
                print(item.displayName)
                print(item.displayPrice)
                print(item.id)
            }
            
            await purchaseProduct(product.first!)
        } catch {
            print("인앱 상품 로드 실패: \(error)")
        }
    }
    
    func purchaseProduct(_ product: Product) async {
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verificationResult):
                print("success") //영수증 검증, 구매복원 등 트랜잭션에 대한 추가 처리 필요.
                //실제 결제라면 SandBox 계정
                //인앱 상품 개수 제한도 있음. 여러 정책 등
            case .userCancelled:
                print("userCancelled")
            case .pending:
                print("pending")
            @unknown default:
                print("@unknown")
            }
        } catch {
            print("구매 실패: \(error)")
        }
    }

}

