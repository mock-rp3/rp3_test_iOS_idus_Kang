//
//  BaseScrollView.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit

class BaseScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemeted xib")
    }

    func configure() {}
    func bind() {}
}
