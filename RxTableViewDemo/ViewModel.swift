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
    
    struct Input {
    
    }
    
    struct Output {
        let dataSouce: Driver<[SectionModel]>
    }
    
    func transform(input: Input) -> Output {
        
        let dataSource = BehaviorRelay<[SectionModel]>(value: [])
        
        dataSource.accept([
            .section(items: [
                .labelItem(vm: LabelCellViewModel(text: "0")),
                .labelItem(vm: LabelCellViewModel(text: "1")),
                .labelItem(vm: LabelCellViewModel(text: "2"))]),
            .section(items: [.buttonItem(vm: ButtonCellViewModel(color: .white))]),
            .section(items: [.colorItem(vm: ColorCellViewModel(color: .yellow))])
        ])
     
        return Output(dataSouce: dataSource.asDriver())
    }
}

extension ViewModel {
    enum SectionModel {
        case section(items: [SectionItem])
    }
    
    enum SectionItem {
        case labelItem(vm: LabelCellViewModel)
        case buttonItem(vm: ButtonCellViewModel)
        case colorItem(vm: ColorCellViewModel)
    }
}

extension ViewModel.SectionModel: SectionModelType {
    
    typealias Item = ViewModel.SectionItem
    
    var items: [ViewModel.SectionItem] {
        switch self {
        case .section(let items):
            return items.map { $0 }
        }
    }
    
    init(original: ViewModel.SectionModel, items: [ViewModel.SectionItem]) {
        switch original {
        case .section(_):
            self = .section(items: items)
        }
    }
}


