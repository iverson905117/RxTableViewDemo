//
//  ViewController.swift
//  RxTableViewDemo
//
//  Created by 康志斌 on 2020/4/18.
//  Copyright © 2020 AppChihPin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        bindViewModel()
    }
    
    func setTableView() {
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: String(describing: LabelCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LabelCell.self))
        tableView.register(UINib(nibName: String(describing: ButtonCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ButtonCell.self))
        tableView.register(UINib(nibName: String(describing: ColorCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ColorCell.self))
    }
    
    func bindViewModel() {
        
        let input = ViewModel.Input()
        let output = viewModel.transform(input: input)
        output.dataSouce
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    lazy var dataSource: RxTableViewSectionedReloadDataSource<ViewModel.SectionModel> = {
        return RxTableViewSectionedReloadDataSource<ViewModel.SectionModel>(configureCell: { [weak self] (_, tableView, indexPath, item) -> UITableViewCell in
            switch item {
            case .labelItem(let vm):
                let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelCell
                cell.configure(viewModel: vm)
                return cell
            case .buttonItem(let vm):
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
                cell.configure(viewModel: vm)
                return cell
            case .colorItem(let vm):
                let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
                cell.configure(viewModel: vm)
                return cell
            }
        })
    }()

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
