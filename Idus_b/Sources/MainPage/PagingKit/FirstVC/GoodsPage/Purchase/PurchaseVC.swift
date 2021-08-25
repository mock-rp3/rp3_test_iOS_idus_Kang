//
//  PurchaseVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import UIKit

class PurchaseVC: UIViewController {

    //MARK: - Prperty
    var currentDateIndex: Int = 0
    var dataArr: ShoppingList?
    var viewModel = ShoppingListViewModel()
    
    @IBOutlet weak var table: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        registerCell()
    }
    
    //MARK: - Action
    @IBAction func cancleBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
//        let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "GoodsPageViewController")
////        nextVC.modalPresentationStyle = .overFullScreen
//        nextVC.modalPresentationStyle = .fullScreen
//        self.present(nextVC, animated: false, completion: nil)

//         changeRootViewController(nextVC)
    }
    
    @IBAction func optionBtn(_ sender: UIButton) {
        let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PurchaseOptionVC")
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
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
extension PurchaseVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataArr = self.dataArr else { return 0 }
        return dataArr.shoppingItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseVCTableViewCell.identifier, for: indexPath) as? PurchaseVCTableViewCell else { return UITableViewCell()}

        // UI를 구성할 데이터를 넘겨준다.
        dataArr = viewModel.itemAt(index: indexPath.row)
        
        // 최상위 Tableview의 indexPathRow를 넘겨준다.
        currentDateIndex = indexPath.row
        
        // cell의 UI에 값을 할당한다. (viewModel 혹은 구조체를 전달하는 방법으로 해도 된다.)
        cell.titleLabel.text = viewModel.itemAt(index: indexPath.row).shoppingOptionName
        
        // if cell.cancleBtn 누르면 데이터 셀 취소
        // if cell.minustBtn 누르면 cell.itemNum -1
        // if cell.plnustBtn 누르면 cell.itemNum +1
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
