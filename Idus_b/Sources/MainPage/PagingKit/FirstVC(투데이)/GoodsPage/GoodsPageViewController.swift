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
    
    // MARK: - 프로퍼티
    let goodsPageDataManager: GoodsPageDataManager = GoodsPageDataManager()
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var heartBtn: UIButton!
    var heartChecked: Bool = false
    
    //    var smallGoodsImgs = [btnImgModel]()
//    var k = 0
    var goods = [GoodsPageResponseResult]()
    var smallGoodsImgs = [String]()
    var bigGoodsImgs = [String]()
    
    // MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodsPageDataManager.getTodayGoodsPageData(delegate: self)
        
//        setupDataSource()
//        self.setupDelegate()
//        self.registerCell()
        // 인디케이터 (로딩)
        showIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.table.reloadData()
            self.dismissIndicator()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
   }

    
    // MARK: - 전 화면으로 가기
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
//        let prevVC = UIStoryboard(name: "MainPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MainPageViewController")
//        prevVC.modalTransitionStyle = .crossDissolve
//        prevVC.modalPresentationStyle = .overFullScreen
//        prevVC.modalPresentationStyle = .fullScreen
//        self.present(prevVC, animated: true, completion: nil)
//        changeRootViewController(prevVC)
    }
    
    // MARK: - 하트 누르기
    @IBAction func CheckHeartBtn(_ sender: UIButton) {
        if heartChecked == false {
            heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartBtn.setTitle("589", for: .normal)
            
            heartChecked = true
        } else {
            heartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            heartBtn.setTitle("588", for: .normal)
            heartChecked = false
        }
    }
    
    // MARK: - 주문하기
    @IBAction func orderBtn(_ sender: UIButton) {
        
        if UserDefaults.standard.value(forKey: "accessToken") as? String == nil || UserDefaults.standard.value(forKey: "userIdxKey") as? String == nil {
            self.presentAlert(title: "로그인해주세요", message: nil, isCancelActionIncluded: true) { action in
                let loginViewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(identifier: "LoginStoryboard")
                self.changeRootViewController(loginViewController)
            }
        } else {
            // 화면 전환
            let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "OrderOptionVC")
            nextVC.modalTransitionStyle = .coverVertical
            nextVC.modalPresentationStyle = .overFullScreen
            self.present(nextVC, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - CollectionViewCell에 사용될 dataSource 정의
//    private func setupDataSource() {
//        while let _ = UIImage(named: "goodsDummy\(k)") {
//            smallGoodsImgs.append(btnImgModel(btnImageName: "goodsDummy\(k)"))
//            k += 1
//        }
//    }

    // MARK: -delegate 설정, cell 등록
    private func setupDelegate() {
        table.delegate = self
        table.dataSource = self
        
    }

    private func registerCell() {
        table.register(GoodsPageImgTableViewCell.nib(), forCellReuseIdentifier: GoodsPageImgTableViewCell.identifier)
        table.register(GoodsPageMainInfoTableViewCell.nib(), forCellReuseIdentifier: GoodsPageMainInfoTableViewCell.identifier)
        table.register(GoodsPageDeliveryTableViewCell.nib(), forCellReuseIdentifier: GoodsPageDeliveryTableViewCell.identifier)
        table.register(GoodsPageTextTableViewCell.nib(), forCellReuseIdentifier: GoodsPageTextTableViewCell.identifier)
    }
        
}

// MARK: - DataManager

// RelatedGoodsResult
extension GoodsPageViewController {
    func successTodayGoodsPageData(result: GoodsPageResponseResult, imgResult: [String]) {
        self.goods.append(result)
        for index in 0...8{
            self.smallGoodsImgs.append(imgResult[index])
            self.bigGoodsImgs.append(imgResult[index])
        }
        UserDefaults.standard.set(bigGoodsImgs, forKey: "bigGoodsImgs")
        self.setupDelegate()
        self.registerCell()
    }
}

// MARK: - TableViewDelegate

extension GoodsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = table.dequeueReusableCell(withIdentifier: GoodsPageImgTableViewCell.identifier, for: indexPath) as? GoodsPageImgTableViewCell else { return UITableViewCell()}
            
//            cell.configureGoodsPageImg(with: goods)
            cell.configureGoodsImg(with: smallGoodsImgs)
//            cell.delegate = self
            return cell
        } else if indexPath.row == 1 {
            guard let cell = table.dequeueReusableCell(withIdentifier: GoodsPageMainInfoTableViewCell.identifier, for: indexPath) as? GoodsPageMainInfoTableViewCell else { return UITableViewCell()}
            return cell
        } else if indexPath.row == 2 {
            guard let cell = table.dequeueReusableCell(withIdentifier: GoodsPageDeliveryTableViewCell.identifier, for: indexPath) as? GoodsPageDeliveryTableViewCell else { return UITableViewCell()}
            return cell
        } else {
            guard let cell = table.dequeueReusableCell(withIdentifier: GoodsPageTextTableViewCell.identifier, for: indexPath) as? GoodsPageTextTableViewCell else { return UITableViewCell()}
            return cell
        }
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        } else if indexPath.row == 1 {
            return 350
        } else if indexPath.row == 2 {
            return 300
        } else {
            return 450
        }
    }
}

// MARK: - 작품 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
//extension GoodsPageViewController: GoodsImgDelegate {
//    func didSelectedGoodsPageBtn(_ index: Int) {
//        print("\(index)번째 작품 이미지")
//    }
//}
