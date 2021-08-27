//
//  CartVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/26.
//

import UIKit

class CartVC: BaseViewController {

    // MARK: - property
    
    @IBOutlet weak var table: UITableView!
    
    // MARK: - 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
    }
    
    
    // MARK: - Actions
    
    // 전 화면 돌아가기
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 결제 페이지 띄우기
    @IBAction func orderBtn(_ sender: UIButton) {
        let nextVC = UIStoryboard(name: "PayStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PayVC")
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    @IBAction func addCartBtn(_ sender: UIButton) {
    }
    
    @IBAction func numPlusBtn(_ sender: UIButton) {
    }
    
    @IBAction func itemOptionBtn(_ sender: UIButton) {
    }
    
    @IBAction func itemCancleBtn(_ sender: UIButton) {
    }
    
    @IBAction func deliveryCostBtn(_ sender: UIButton) {
    }
    
    @IBAction func vipBtn(_ sender: UIButton) {
    }
    
    
    // MARK: - Helper

    private func registerCell() {
        table.delegate = self
        table.dataSource = self
        table.register(CartTableViewCell.nib(), forCellReuseIdentifier: CartTableViewCell.identifier)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        return cell
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
