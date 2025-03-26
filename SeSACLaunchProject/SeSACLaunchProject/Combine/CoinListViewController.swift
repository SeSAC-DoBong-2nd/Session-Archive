//
//  CoinListViewController.swift
//  SeSACLaunchProject
//
//  Created by 박신영 on 3/26/25.
//

import UIKit
import Combine

import SnapKit

final class CoinListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: "MarketCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var markets: Markets = [Market(market: "Jack", koreanName: "a", englishName: "b")] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let viewModel: CoinListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CoinListViewModel) {
//        self.markets = markets
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        
        //파라미터는 value copy (값을 복사)
        //파라미터를 통해서 무언가를 변경하더라도, data 상수에는 변화가 없다.
        var data = 3
        add(number: &data) // &: 참조를 전달하겠다. 라는 뜻
        print(data)
    }
    
    //inout 매개변수는 파라미터가 참조 형태로 전달. 함수내부에서 수정한 내용이 data 상수에도 반영이 됨.
    func add(number: inout Int) {
        number += 1
    }
    
    private func bindViewModel() {
        let input = CoinListViewModel.Input(viewOnTask: Just(()).eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.markets
            .sink { [weak self] markets in
                self?.markets = markets
            }
            .store(in: &cancellables) // inout parameter 이기에 & 가 붙는다
        
        output.isLoading
            .sink { [weak self] isLoading in
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        /*
         withUnretained -> custom
         closure weak self -> custom
         */
        output.error
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        title = "My Money"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.dataSource = self
    }
    
}

extension CoinListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as! MarketTableViewCell
        let market = markets[indexPath.row]
        cell.configure(with: market)
        return cell
    }
}
