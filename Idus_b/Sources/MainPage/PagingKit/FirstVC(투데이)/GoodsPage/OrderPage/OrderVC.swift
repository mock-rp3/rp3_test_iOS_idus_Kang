//
//  OrderVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import UIKit

class OrderVC: BaseViewController {

    //MARK: - Prperty
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var costNum: UILabel!
    @IBOutlet weak var deliveryNum: UILabel!
    var dataArr = [String]()
    let sellNum = UserDefaults.standard.value(forKey: "sellNum") as! Int
    let numberFormatter = NumberFormatter()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        registerCell()
        numberFormatter.numberStyle = .decimal
        dataArr.append(UserDefaults.standard.value(forKey: "plusSelectedItem") as? String ?? "")
    }
    
    //MARK: - Action
    
    // 모달 닫기(화면전환? - 보류)
    @IBAction func cancleBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
//        let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "GoodsPageViewController")
////        nextVC.modalPresentationStyle = .overFullScreen
//        nextVC.modalPresentationStyle = .fullScreen
//        self.present(nextVC, animated: false, completion: nil)

//         changeRootViewController(nextVC)
    }
    
    // 옵션 선택창으로 돌아가기
    @IBAction func optionBtn(_ sender: UIButton) {
        let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "OrderOptionVC")
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    
    // 장바구니 담기
    @IBAction func cartBtn(_ sender: UIButton) {
        self.presentAlert(title: "장바구니에 담으시겠습니까?", message: nil, isCancelActionIncluded: true) { action in
            self.view.backgroundColor = .yellow
        }
    }
    
    // 구매하기 - 주문확인 페이지 띄우기
    @IBAction func buyBtn(_ sender: UIButton) {
        let nextVC = UIStoryboard(name: "CartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CartVC")
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: -delegate 설정, cell 등록
    private func setupDelegate() {
        table.delegate = self
        table.dataSource = self
    }
    
    private func registerCell() {
        table.register(PurchaseVCTableViewCell.nib(), forCellReuseIdentifier: PurchaseVCTableViewCell.identifier)
//        table.tableFooterView = UIView()
//        table.separatorStyle = .none
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension OrderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseVCTableViewCell.identifier, for: indexPath) as? PurchaseVCTableViewCell else { return UITableViewCell()}
        
        cell.itemLabel.text = UserDefaults.standard.value(forKey: "plusSelectedItem") as? String
        
        let resultCountCost = numberFormatter.string(from: NSNumber(value: sellNum))! + "원"
        cell.CountCost.text = resultCountCost
        cell.selectionStyle = .none
        
        let sumResult = numberFormatter.string(from: NSNumber(value: 3000+sellNum))! + "원"
        costNum.text = sumResult
        
//        deliveryNum.text = ""
//        let deliveryNumResult = numberFormatter.string(from: NSNumber(value: Int(deliveryNum.text)))! + "원"
        
        cell.clickMinusBtn = { [unowned self] in
            cell.itemNum.text = "\(Int(cell.itemNum.text!)! - 1)"
            UserDefaults.standard.set(Int(cell.itemNum.text!)! - 1, forKey: "finalItemNum")
            let resultMinusCountCost = numberFormatter.string(from: NSNumber(value: sellNum * Int(cell.itemNum.text!)!))! + "원"
            cell.CountCost.text = resultMinusCountCost
            
            let sumResult = numberFormatter.string(from: NSNumber(value: 3000+sellNum * Int(cell.itemNum.text!)!))! + "원"
            costNum.text = sumResult
            UserDefaults.standard.set(sellNum * Int(cell.itemNum.text!)!, forKey: "finalCostNum")
            
        }
        
        cell.clickPlusBtn = { [unowned self] in
            cell.itemNum.text = "\(Int(cell.itemNum.text!)! + 1)"
            UserDefaults.standard.set(Int(cell.itemNum.text!)! + 1, forKey: "finalItemNum")
            let resultPlusCountCost = numberFormatter.string(from: NSNumber(value: sellNum * Int(cell.itemNum.text!)!))! + "원"
            cell.CountCost.text = resultPlusCountCost
            
            let sumResult = numberFormatter.string(from: NSNumber(value: 3000+sellNum * Int(cell.itemNum.text!)!))! + "원"
            costNum.text = sumResult
            UserDefaults.standard.set(sellNum * Int(cell.itemNum.text!)!, forKey: "finalCostNum")
        }
        
        // if cell.cancleBtn 누르면 데이터 셀 취소
        cell.clickCancleBtn = { [unowned self] in
            dataArr.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
//            table.deleteSections([indexPath.section], with: .fade)
            table.reloadData()
            costNum.text = "3000" + "원"
        }
        
        return cell
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
