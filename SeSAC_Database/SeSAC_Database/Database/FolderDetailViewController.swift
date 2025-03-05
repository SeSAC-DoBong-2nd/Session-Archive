//
//  FolderDetailViewController.swift
//  SeSAC_Database
//
//  Created by 박신영 on 3/5/25.
//

import UIKit

import RealmSwift
import SnapKit

class FolderDetailViewController: UIViewController {

    let tableView = UITableView()
    
    var list: List<JackTable>!
    var id: ObjectId?
    
    let repository: JackRepository = JackTableRepository()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        repository.getFileURL()
        configureHierarchy()
        configureView()
        configureConstraints()
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
        vc.id = self.id
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension FolderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        //realm의 코드는 동기로 동작한다.
        repository.deleteItem(data: data)
        
        self.tableView.reloadData()
    }
      
    
}

