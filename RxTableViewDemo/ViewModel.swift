//
//  ViewModel.swift
//  RxTableViewDemo
//
//  Created by 康志斌 on 2020/4/19.
//  Copyright © 2020 AppChihPin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}

class ViewModel: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let buttonCellOnTap: Driver<Void>
    }
    
    struct Output {
        let dataSouce: Driver<[SectionModel]>
    }
    
    func transform(input: Input) -> Output {
        
        let dataSource = BehaviorRelay<[SectionModel]>(value: [])
        
        dataSource.accept([
            // section identity 重複會造成 Crash
            // section 內 的 item identity 重複會造成 Crash
            SectionModel(id: "Label", items: [
                .labelItem(vm: LabelCellViewModel(title: "0", color: .white)),
                .labelItem(vm: LabelCellViewModel(title: "1", color: .white)),
                .labelItem(vm: LabelCellViewModel(title: "2", color: .white))
            ]),
            SectionModel(id: "Button", items: [.buttonItem(vm: ButtonCellViewModel(title: "Button", color: .white))]),
            SectionModel(id: "Color", items: [.colorItem(vm: ColorCellViewModel(title: "Color", color: .red))])
        ])
        
        input.buttonCellOnTap
            .drive(onNext: { _ in
                dataSource.accept([
                    SectionModel(id: "Label", items: [
                        .labelItem(vm: LabelCellViewModel(title: "4", color: .white)),
                        .labelItem(vm: LabelCellViewModel(title: "5", color: .white)),
                        .labelItem(vm: LabelCellViewModel(title: "6", color: .white))
                    ]),
                    SectionModel(id: "Button", items: [.buttonItem(vm: ButtonCellViewModel(title: "Button", color: .white))]),
                    SectionModel(id: "Color", items: [.colorItem(vm: ColorCellViewModel(title: "Color", color: .yellow))])
                ])
            })
            .disposed(by: disposeBag)
     
        return Output(dataSouce: dataSource.asDriver())
    }
}

extension ViewModel {
    struct SectionModel {
        let id: String
        var items: [SectionItem]
    }
    
    enum SectionItem: IdentifiableType, Equatable {
        
        case labelItem(vm: LabelCellViewModel)
        case buttonItem(vm: ButtonCellViewModel)
        case colorItem(vm: ColorCellViewModel)
        
        var identity: String {
            switch self {
            case .labelItem(let vm):
                return vm.identity
            case .buttonItem(let vm):
                return vm.identity
            case .colorItem(let vm):
                return vm.identity
            }
        }
        
    }
}

extension ViewModel.SectionModel: AnimatableSectionModelType {

    typealias Item = ViewModel.SectionItem
    
    init(original: ViewModel.SectionModel, items: [ViewModel.SectionItem]) {
        self = original
        self.items = items
    }
    
    typealias Identity = String
    var identity: String {
        return id
    }
}


