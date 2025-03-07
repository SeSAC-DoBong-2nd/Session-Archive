//
//  UIViewController+Extension.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

//아래 이미지 저장하기 이전에 해야할 것들

//실제 디바이스 남은 용량을 확인
//>> 카톡의 경우 1기가 남았을 때 350M 이상의 용량을 만들어달라고 alert 띄움

extension UIViewController {
    
    //Document에 image 저장하기
    //posterImageView.image
    func saveImageToDocument(image: UIImage, fileName: String) {
        
        //ex)jack/Desktop/SeSAC/project/Documents ...
        //도큐먼트 폴더 위치 가져오기
        //for: 무슨 디렉토리를 찾을거냐?, in: 어디 안에 속해있어? (얘는 user로 고정)
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //이미지를 저장할 경로(파일명) 지정
        //appendingPathComponent: '/' 를 찍어주는 메서드
        //+@ 폴더를 아예 생성해버리는 메서드도 있으니 그 매서드도 찾아봐라!
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        //이미지 용량 줄이기: 압축, 해상도 조절, 리사이징, 다운 샘플링 등
        //compressionQuality: 압축
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        //실제 저장하려는 이미지 파일
        do {
            try data.write(to: fileURL)
        } catch {
            print("이미지 저장 실패") //용량 부족할 때
        }
    }
    
    func loadImageToDocument(fileName: String) -> UIImage? {
        
        //도큐먼트 위치 확인
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star") }
        
        //이미지가 저장된 경로 확인
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        //위 경로에 실제로 파일이 존재하는지 체크
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return UIImage(systemName: "star")
        }
        
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("file remove error", error)
            }
            
        } else {
            print("file no exist")
        }
        
    }
    
}
