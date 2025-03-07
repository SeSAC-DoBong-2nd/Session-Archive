//
//  MainViewController.swift
//  SeSAC6Database
//
//  Created by Jack on 3/4/25.
//

import UIKit

import FSCalendar
import RealmSwift
import SnapKit

//TMI: Mainvc와 같이 이름 짓지 말자
//TMI: ...Manager, Service, Helper 키워드의 구분 찾아보기

class MainViewController: UIViewController {

    let tableView = UITableView()
    let calendar = FSCalendar()
    
    //Results 타입을 활용했기에, 데이터가 바뀐 걸 새로 대입해주지 않아도 realm이 알아서 반영해줌.
    var list: Results<JackTable>!
    
    //Realm의 동기화가 되려 성가시다면 아래와 같이 기존 배열 데이터관리하는 것처럼 다뤄도 좋다.
//    var list: [JackTable]!
    
    let repository: JackRepository = JackTableRepository()
    let folderRepository: FolderRepository = FolderTableRepository()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        folderRepository.createItem(name: "개인")
//        folderRepository.createItem(name: "동아리")
//        folderRepository.createItem(name: "회사")
//        folderRepository.createItem(name: "멘토")
        print(#function)
        repository.getFileURL()
        configureHierarchy()
        configureView()
        configureConstraints()
        
        list = repository.fetchAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        self.tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(calendar)
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
        
        calendar.backgroundColor = .green
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    private func configureConstraints() {
        
        calendar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(250)
        }
         
        tableView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
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
        cell.titleLabel.text = "\(data.productName), \(data.category)"
        cell.subTitleLabel.text = data.folder.first?.name
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

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    //어떤 일자에 이벤트 dot을 찍을 것인지
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        print(#function, date)
//        return 2
//    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star")
//    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "케케"
//    }
    
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "케케"
//    }
    
    //custom cell 사용
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        <#code#>
//    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(#function, date)
        
        //선택한 일자
        let start = Calendar.current.startOfDay(for: date)
        
        //선택한 일자의 다음날
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        
        //Realm where filter, iOS NSPredicate
        //Realm 쿼리 통해서 조회
        let predicate = NSPredicate(format: "regdate >= %@ && regdate < %@", start as NSDate, end as NSDate)
        
        let realm = try! Realm()
        
        let result = realm.objects(JackTable.self).filter(predicate)
        dump(result)
        
    }
    
}
