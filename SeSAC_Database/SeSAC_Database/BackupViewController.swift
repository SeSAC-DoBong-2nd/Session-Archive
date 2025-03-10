//
//  BackupViewController.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/10/25.
//

import UIKit

import SnapKit
import Zip

class BackupViewController: UIViewController {
    
    let backupButton = {
        let view = UIButton()
        view.setTitle("백업", for: .normal)
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let restoreButton = {
        let view = UIButton()
        view.setTitle("복구", for: .normal)
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let backupTableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
        view.backgroundColor = .white
        backupTableView.delegate = self
        backupTableView.dataSource = self
    }
    
    func configure() {
        view.addSubview(backupTableView)
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    func setConstraints() {
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        return documentDirectory
    }
    
    @objc
    func backupButtonTapped() {
        print(#function)
        //Document File > Zip
        //도큐먼트 위치 조회
        guard let path = documentDirectoryPath()
        else {
            print("도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        //백업할 파일을 조회(ex. default.realm)
        let realmFile = path.appendingPathComponent("default.realm")
        
        //백업할 파일 경로가 유효한지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path()) else {
            print("백업할 파일이 없습니다") //앱 다운 직후 백업 버튼 누를 경우
            return
        }
        
        //압축하고자 하는 파일을 urlPath에 추가
        var urlPaths = [URL]()
        urlPaths.append(realmFile)
        
        //백업할 파일을 압축 파일로 묶는 작업
        do {
            let filePath = try Zip.quickZipFiles(urlPaths, fileName: "JackArchive") { progress in
                print("현재 진행률: \(progress)")
            }
            
            print("Zip Location", filePath)
        } catch {
            print("압축을 실패했어요")
            //ex) 기기 용량 부족, 화면 dismiss, 다른 탭 전환, 백그라운드 전환 등
        }
    }
    
    @objc
    func restoreButtonTapped() {
        print(#function)
        
        let document = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        
        //zip 선택 -> 도큐먼트 저장 -> 압축 해제
        document.delegate = self
        document.allowsMultipleSelection = false
        
        present(document, animated: true)
    }
    
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Document 폴더에서 zip 확장자를 갖고있는 파일만 조회
    func fetchZipList() -> [String] {
        
        //도큐먼트 위치 조회
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다.")
            return []
        }
        
        var list: [String] = ["fail"]
        
        //도큐먼트 폴더 내에 컨텐츠들 조회 zip filter
        do {
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            
            let last = zip.map { $0.lastPathComponent }
            
            list = last
        } catch {
            print("목록 조회 실패")
        }

        return list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = fetchZipList()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //cell 클릭 시 해당 zip 파일 외부로 보내기
            //현재로서는 JackArchive.zip 구성이 돼있는 파일을 외부로 보내기
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let backupFileURL = path.appendingPathComponent(fetchZipList()[indexPath.row])
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: nil)
        
        present(vc, animated: true)
    }
    
}

/**
 #TODO.
 - 사진 데이터가 백업이 되고있지 않음
    - 백업 압축 파일에 default.realm만 있음
    - 해결: 폴더를 만들어 해당 폴더에 이미지를 저장하고, 이후 백업 저장할 때 해당 폴더 URL만 활용하면 안의 이미지 활용 가능
 
 - 백업 파일명, 내부 폴더 구조..
 - 압축 해제 이후, 해당 압축 파일 제거 혹은 잘못 해제한 파일들이 있다면 이 역시 제거
    - Jack_날짜_초단위.zip
    - default.realm.
 - 백업본A. 근데 복원하기 전에 새로 설치한 앱에 데이터를 많이 쌓아두었다..
 - 그리고 나중에 알게돼서 백업본을 적용했는데, 현재 구성 로직으로는 그냥 덮어써버리고 있다.
 - default.ralm -> 앱을 처음 실행해야만 동작.
    - 따라서 default.realm이 백업으로 설치된 이후 앱 재시작 없이 바로 적용되는 것이 안됨.
 
 
 -> 위 모든 문제 해결법.
 -> json 확장자로 백업/복구 를 진행하면 다 가능
    # 백업:
    1. default.realm을 fetch
    2. encodable
    3. json 이후 Zip
    # 복구:
    1. Zip 해제
    2. json 데이터들 가공
    3. 적용
 
 
 +@ - 가끔 도큐먼트나 파일앱을 다룰 때, info.plist의 값 설정을 얘기하는 블로그가 있는데, 잘못 설정하면 도큐먼트 폴더 자체가 사용자에게 노출될 수 있으니 유의하자.
 */

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        //멀티 선택을 끄지 않았다면 배열형태로 왔을테니 [URL]인 것.
        
        guard let selectedFileURL = urls.first else {
            print("선택한 파일에 오류가 있습니다.")
            return
        }
        
        //파일앱 데이터 -> 도큐먼트 폴더로 넣기
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        //도큐먼트 폴더 내에 저장할 경로 설정
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        //압축 파일을 저장하고, 풀면 된다.
        //이미 경로에 파일이 존재하는 지 확인 -> 압축을 바로 해제
        //경로에 파일이 존재하지 않는다면 -> 파일 앱의 압축 파일 -> 도큐먼트 경로로 복사 -> 도큐먼트에 저장 -> 저장된 압축 파일을 해제
        
        
        //파일 존재 확인 출동
        if FileManager.default.fileExists(atPath: sandboxFileURL.path()) {
            let fileURL = path.appendingPathComponent("JackArchive.zip")
            print("파일 존재 O")
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil) {
                    progress in
                    print(progress)
                } fileOutputHandler:
                                    { unzippedFile in
                    print("압축해제 완료", unzippedFile)
                    
                }
            } catch {
                print("압축 해제 실패")
                //ex) 용량부족 등
            }
        } else {
            print("파일 존재 X")
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("JackArchive.zip")
                
                do {
                    try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil) {
                        progress in
                        print(progress)
                    } fileOutputHandler:
                                        { unzippedFile in
                        print("압축해제 완료", unzippedFile)
                        
                    }
                } catch {
                    print("압축 해제 실패")
                    //ex) 용량부족 등
                }
                
            } catch {
                print("파일 copy 실패, 압축 해제 실패")
            }
        }
    }
    
}
