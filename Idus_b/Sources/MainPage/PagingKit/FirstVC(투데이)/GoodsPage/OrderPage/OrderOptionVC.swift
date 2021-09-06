//
//  PurchaseOptionVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/24.
//

import UIKit

class OrderOptionVC: BaseViewController {

    //MARK: - Prperty
    @IBOutlet var table: UITableView!
    var viewModel = ShoppingListViewModel()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()
        registerCell()
    }
    
    //MARK: - Action
    
    @IBAction func cancleBtn() {
        self.dismiss(animated: true, completion: nil)
        
//        let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "GoodsPageViewController")
//        self.navigationController?.pushViewController(nextVC, animated: false)
//        nextVC.modalPresentationStyle = .overFullScreen
//        nextVC.modalPresentationStyle = .fullScreen
//        self.present(nextVC, animated: false, completion: nil)
//
//        changeRootViewController(nextVC)
    }
    
    //MARK: - Helper
    
    // MARK: -delegate 설정, cell 등록
    private func setupDelegate() {
        table.delegate = self
        table.dataSource = self
    }
    
    private func registerCell() {
        table.register(PurchaseOptionTableViewCell.nib(), forCellReuseIdentifier: PurchaseOptionTableViewCell.identifier)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension OrderOptionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PurchaseOptionTableViewCell.identifier, for: indexPath) as? PurchaseOptionTableViewCell else { return UITableViewCell()}
        
        cell.delegate = self

        // UI를 구성할 데이터를 넘겨준다.
        cell.dataArr = viewModel.itemAt(index: indexPath.row)
        
        // 최상위 Tableview의 indexPathRow를 넘겨준다.
        cell.currentDateIndex = indexPath.row
        
        // cell의 UI에 값을 할당한다. (viewModel 혹은 구조체를 전달하는 방법으로 해도 된다.)
        cell.optionName.text = viewModel.itemAt(index: indexPath.row).shoppingOptionName
        
        if viewModel.itemAt(index: indexPath.row).isFolding {
            cell.optionNameView.backgroundColor = .lightGray
            cell.selectImg.image = UIImage(systemName:"chevron.up")
        } else {
            cell.optionNameView.backgroundColor = .white
            cell.selectImg.image = UIImage(systemName:"chevron.down")
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    // cell 클릭 시, cell의 사이즈를 변경하는 로직
    // (현재 그냥 전체를 변경하고 있고, 추후에 클릭한 cell의 사이즈만 변경하도록 구현)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateIsFoldingState(dateIndex: indexPath.row)
//        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var cellHeight = Int()
        
        if viewModel.itemAt(index: indexPath.row).isFolding {

            let numberOfItems = viewModel.itemAt(index: indexPath.row).shoppingItem.count
            
            cellHeight = (numberOfItems + 1) * 50
            return CGFloat(cellHeight)
            
        } else {
            
            cellHeight = 50
            return CGFloat(cellHeight)
        }
    }
}


//MARK: - MainTableViewCellDidTapDelegate
extension OrderOptionVC: MainTableViewCellDidTapDelegate {
    
    /// "MainTableview" 내부에 있는 "InsideTableViewCell"을 클릭했을 때, 호출되는 메소드
    func InsideCellDidTap(dateIndex: Int, itemIndex: Int) {
        viewModel.setCompletionState(optionIndex: dateIndex, itemIndex: itemIndex)
        viewModel.updateIsFoldingState(dateIndex: dateIndex)
        viewModel.updateIsFoldingState(dateIndex: dateIndex+1)
        table.reloadData()
        if viewModel.count == dateIndex + 1 {
            let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "OrderVC")
            nextVC.modalPresentationStyle = .overFullScreen
            self.present(nextVC, animated: false, completion: nil)
        }
    }

}
