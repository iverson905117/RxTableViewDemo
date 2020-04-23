//
//  ColorCellViewModel.swift
//  RxTableViewDemo
//
//  Created by 康志斌 on 2020/4/19.
//  Copyright © 2020 AppChihPin. All rights reserved.
//

import UIKit
import RxDataSources

struct ColorCellViewModel {
    let title: String
    let color: UIColor
    
}

extension ColorCellViewModel: IdentifiableType, Equatable {
    
    var identity: String {
        return title
    }
    // 要自訂 ==，否則會比對所有物件是否相同來判定是否要 reload
    static func == (lhs: ColorCellViewModel, rhs: ColorCellViewModel) -> Bool {
        return lhs.title == rhs.title
    }
    
}
