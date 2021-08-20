//
//  CategoryScrollVeiw.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/20.
//

import UIKit

class CategoryScrollVeiw: UIScrollView {
    
    // 코드로 식별자 부여
    static let identifier = "FirstVCTableBannerCell"
    
    // 코드로 nib명 부여
    static func nib() -> UINib {
        return UINib(nibName: "FirstVCTableBannerCell", bundle: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented xib init")
    }

    // 기본적인 레이아웃 설정
    func configure() {}
    
    // data가 변경되면 불려지도록 구현
    func bind() {}

}
