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
    @IBOutlet weak var lineView: UIView!
    let disposeBag = DisposeBag()
    
    var mode: Int = 1
    
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
        button.setTitle(viewModel.title, for: .normal)
        button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.mode = self.mode == 1 ? 2 : 1
                UIView.animate(withDuration: 0.3) {
                    switch self.mode {
                    case 1:
                        self.lineView.transform = .identity
                    case 2:
                        self.lineView.transform = CGAffineTransform(translationX: self.lineView.bounds.size.width, y: 0)
                    default:
                        break
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
