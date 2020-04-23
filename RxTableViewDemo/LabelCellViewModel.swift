//
//  LabelCellViewModel.swift
//  RxTableViewDemo
//
//  Created by 康志斌 on 2020/4/19.
//  Copyright © 2020 AppChihPin. All rights reserved.
//

import Foundation
import RxDataSources

struct LabelCellViewModel {
    let title: String
    let color: UIColor
}

extension LabelCellViewModel: IdentifiableType, Equatable {
    
    var identity: String {
        return title
    }
}
