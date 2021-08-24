//
//  HorizontalScrollView.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

import UIKit
import SnapKit

class HorizontalScrollView: BaseScrollView {
    var dataSource: [SomeDataModel]? {
        didSet { bind() }
    }

    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16.0
        view.backgroundColor = .separator

        return view
    }()

    override func configure() {
        super.configure()

        showsHorizontalScrollIndicator = false
        bounces = false

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview() /// 이 값이 없으면 scroll 안되는 것 주의
            make.top.bottom.equalToSuperview()
        }
    }

    override func bind() {
        super.bind()

        dataSource?.forEach { data in
            let button = UIButton()
            button.setTitleColor(.blue, for: .normal)
            button.setTitle(data.name, for: .normal)
            button.setImage(data.iamge, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -4.0, bottom: 0.0, right: 0.0)

            button.snp.makeConstraints { make in
                make.height.equalTo(42)
            }

            stackView.addArrangedSubview(button)
        }
    }

}
