//
//  GoodsPageViewController.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/22.
//

import UIKit
import RxGesture // collectionView의 cell내부 contentsView tapGesture() rx 사용위해 import
import RxSwift
import RxCocoa

class GoodsPageViewController: BaseViewController {
    
    @IBOutlet var table: UITableView!
        
    var smallGoodsImgs = [btnImgModel]()
    var k = 1
    
    // MARK: - 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
        setupDelegate()
        registerCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
   }
    
    // MARK: - CollectionViewCell에 사용될 dataSource 정의
    private func setupDataSource() {
        while let _ = UIImage(named: "main_banner\(k)") {
            smallGoodsImgs.append(btnImgModel(btnImageName: "main_banner\(k)"))
            k += 1
        }
    }

    // MARK: -delegate 설정, cell 등록
    private func setupDelegate() {
        table.delegate = self
        table.dataSource = self
        
    }

    private func registerCell() {
        table.register(GoodsPageTableViewCell.nib(), forCellReuseIdentifier: GoodsPageTableViewCell.identifier)
    }
        
}

extension GoodsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: GoodsPageTableViewCell.identifier, for: indexPath) as? GoodsPageTableViewCell else { return UITableViewCell()}
        cell.configureGoodsPageImg(with: smallGoodsImgs)
        cell.delegate = self
        return cell
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - 오늘의 작품 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension GoodsPageViewController: GoodsImgDelegate {
    func didSelectedGoodsBtn(_ index: Int) {
        print("\(index)번째 셀")
    }
}
