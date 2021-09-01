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
    lazy var goodsPageDataManager: GoodsPageDataManager = GoodsPageDataManager()
    private var items0 = [ShoppingList]()
    
    @IBOutlet var table: UITableView!
    @IBOutlet weak var heartBtn: UIButton!
    var heartChecked: Bool = false
    
    var goods = [GoodsPageResponseResult]()
    var smallGoodsImgs = [String]()
    var bigGoodsImgs = [String]()
    
    // MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodsPageDataManager.getTodayGoodsPageData(delegate: self)
        
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
        
        if UserDefaults.standard.value(forKey: "accessToken") as? String == nil && UserDefaults.standard.value(forKey: "userIdxKey") as? String == nil {
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
        
        // 상품 상세페이지 이미지 세팅
        self.goods.append(result)
        for index in 0...8{
            self.smallGoodsImgs.append(imgResult[index])
            self.bigGoodsImgs.append(imgResult[index])
        }
        UserDefaults.standard.set(bigGoodsImgs, forKey: "bigGoodsImgs")
        self.setupDelegate()
        self.registerCell()

        // 주문 옵션 세팅
        var shoppingOptionNames = [String]()
        for index in 0...goods[0].options.count-1 {
            shoppingOptionNames.append("   \(index+1). \(goods[0].options[index].optionName)")
            var shoppingItems = [String]()
            var isSelecteds = [Bool]()
            
            for index2 in 0...goods[0].options[index].optionDetailList.count-1 {
                shoppingItems.append(goods[0].options[index].optionDetailList[index2].optionDetailName)
                isSelecteds.append(false)
            }

            self.items0.append(ShoppingList(shoppingOptionName: shoppingOptionNames[index],
                                           shoppingItem: shoppingItems,
                                           isSelected: isSelecteds))
            UserDefaults.standard.set(shoppingOptionNames[index], forKey: "shoppingOptionNames\(index)")
            UserDefaults.standard.set(shoppingItems, forKey: "shoppingItems\(index)")
            UserDefaults.standard.set(isSelecteds, forKey: "isSelecteds\(index)")
        }
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
            cell.configureGoodsImg(with: smallGoodsImgs)
            return cell
        } else if indexPath.row == 1 {
            guard let cell = table.dequeueReusableCell(withIdentifier: GoodsPageMainInfoTableViewCell.identifier, for: indexPath) as? GoodsPageMainInfoTableViewCell else { return UITableViewCell()}
            cell.configureAuthor(with: goods)
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
