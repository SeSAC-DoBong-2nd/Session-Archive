//
//  MainViewController.swift
//  SeSAC6Database
//
//  Created by Jack on 3/4/25.
//

import UIKit

import RealmSwift
import SnapKit

class MainViewController: UIViewController {

    let tableView = UITableView()
    
    //Results 타입을 활용했기에, 데이터가 바뀐 걸 새로 대입해주지 않아도 realm이 알아서 반영해줌.
    var list: Results<JackTable>!
    
    //Realm의 동기화가 되려 성가시다면 아래와 같이 기존 배열 데이터관리하는 것처럼 다뤄도 좋다.
//    var list: [JackTable]!
    
    //realm에 접근
    let realm = try! Realm() //default.realm
     
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        print(realm.configuration.fileURL!)
        configureHierarchy()
        configureView()
        configureConstraints()
        
//        let data = realm.objects(JackTable.self)
//        self.list = Array(data)
        
        list = realm.objects(JackTable.self)
//            .where {$0.productName.contains("sesac", options: .caseInsensitive)}
//            .sorted(byKeyPath: "money", ascending: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
//        let data = realm.objects(JackTable.self)
//        self.list = Array(data)
        
        self.tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
//        cell.testUI(model: data)
        cell.titleLabel.text = data.productName
        cell.subTitleLabel.text = data.category
        cell.overviewLabel.text = data.money.formatted() + "원"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        
        
        do {
            //Realm의 CRUD와 같은 작업들은 write 트랜젝션이 보장돼야 하기에 그 안에 위치해야한다.
            try realm.write {
                
                //삭제
//                realm.delete(data)
//                print("realm 데이터 삭제 성공")
                
                //수정
                realm.create(JackTable.self, value:["id": data.id, "money": 1000000000, "productName": "케케몬"], update: .modified)
                
                self.tableView.reloadData()
                
            }
        } catch {
            print("realm 데이터 삭제 실패")
        }
    }
      
    
}
