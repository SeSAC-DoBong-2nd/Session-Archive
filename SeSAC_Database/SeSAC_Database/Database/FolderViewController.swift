//
//  FolderViewController.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/5/25.
//

import UIKit

import RealmSwift
import SnapKit

class FolderViewController: UIViewController {

    let tableView = UITableView()
    var list: Results<Folder>!
    let repository: FolderRepository = FolderTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        configureHierarchy()
        configureView()
        configureConstraints()
        list = repository.fetchAll()
//        dump(list)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
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
        
        let image = UIImage(systemName: "star")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = "\(data.detail.count)개"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //EmbeddedObject
        let data = list[indexPath.row]
        repository.createMemo(data: data)
        tableView.reloadData()
        
        
        //폴더 삭제
        //폴더 삭제 시 세부 항목도 지울 것인지? (세부항목을 지우면 부모에도 반영이 되지만 그 역은 자동으로 반영되지않음.)
            //그렇기에 세부 항목을 먼저 지우고, 이를 담고있는 폴더도 지워야함
        //폴더 삭제 시 세부 항목을 다른 폴더로 이동해줄 것인지?
//        let data = list[indexPath.row]
//        repository.deleteItem(data: data)
//        self.tableView.reloadData()
        
        //화면 전환
//        let data = list[indexPath.row]
//        let vc = FolderDetailViewController()
//        vc.list = data.detail
//        vc.id = data.id
//        
//        navigationController?.pushViewController(vc, animated: true)
    }
      
    
}

