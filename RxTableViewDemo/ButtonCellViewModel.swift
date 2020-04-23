//
//  ButtonCellViewModel.swift
//  RxTableViewDemo
//
//  Created by 康志斌 on 2020/4/19.
//  Copyright © 2020 AppChihPin. All rights reserved.
//

import UIKit
import RxDataSources

struct ButtonCellViewModel {
    let title: String
    var color: UIColor
}

extension ButtonCellViewModel: IdentifiableType, Equatable {
    
    var identity: String {
        return title
    }
}
