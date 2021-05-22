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
    
    let cellButtonOnTap = PublishSubject<()>()
    
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
    
    lazy var animatedDataSource: RxTableViewSectionedAnimatedDataSource<ViewModel.SectionModel> = {
        return RxTableViewSectionedAnimatedDataSource<ViewModel.SectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .none, deleteAnimation: .top),
            configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
                switch item {
                case .labelItem(let vm):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! LabelCell
                    cell.configure(viewModel: vm)
                    return cell
                case .buttonItem(let vm):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as!  ButtonCell
                    cell.button.rx.tap
                        .subscribe(onNext: { [weak self] _ in
                            self?.cellButtonOnTap.onNext(())
                        })
                        .disposed(by: self.disposeBag)
                    cell.configure(viewModel: vm)
                    return cell
                case .colorItem(let vm):
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
                    cell.configure(viewModel: vm)
                    return cell
                }
            })
    }()

    
    func bindViewModel() {
        
        let input = ViewModel.Input(buttonCellOnTap: cellButtonOnTap.asDriver(onErrorJustReturn: ()))
        let output = viewModel.transform(input: input)
        output.dataSouce
            .drive(tableView.rx.items(dataSource: animatedDataSource))
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
