//
//  ButtonCell.swift
//  RxTableViewDemo
//
//  Created by 康志斌 on 2020/4/19.
//  Copyright © 2020 AppChihPin. All rights reserved.
//

import UIKit
import RxSwift

class ButtonCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(viewModel: ButtonCellViewModel) {
        backgroundColor = viewModel.color
    }
}
