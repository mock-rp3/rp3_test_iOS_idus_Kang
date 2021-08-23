//
//  DataModels.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/21.
//

// MARK:- 메인페이지 Model_페이징킷
struct imgModel {
    let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
}

struct btnImgModel {
    let btnImageName: String
    
    init(btnImageName: String) {
        self.btnImageName = btnImageName
    }
}

// MARK:- 작품 상세 페이지 CollectionViewCell에서 사용될 모델_페이저

struct MyCollectionViewModel {
    let title: Int
}

struct GoodsPageCollectionViewModel {
    let goodsImageName: String
}
