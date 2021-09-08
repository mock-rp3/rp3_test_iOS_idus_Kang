//
//  PayVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/26.
//

import Alamofire

class PayVC: BaseViewController {
    
    // MARK: - property
    
    lazy var dataManager: PayDataManager = PayDataManager()
    let numberFormatter = NumberFormatter()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var payNum: UILabel!
    @IBOutlet weak var mileageNum: UILabel!
    
    // MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberFormatter.numberStyle = .decimal
        registTableCell()
        setPayNum()
    }
    
    // MARK: - Helper
    
    private func registTableCell() {
        table.delegate = self
        table.dataSource = self
        table.register(PayTableViewCell.nib(), forCellReuseIdentifier: PayTableViewCell.identifier)
        table.register(PayTableViewCell2.nib(), forCellReuseIdentifier: PayTableViewCell2.identifier)
    }
    
    func setPayNum() {
        let payNumber0 = UserDefaults.standard.value(forKey: "sellNum") as! Int
        let payNumber = numberFormatter.string(from: NSNumber(value: 3000+payNumber0))! + "원 간편하게 카드 결제"
        payNum.text = payNumber
        let mileageNumber = "예상 적립금 : " + numberFormatter.string(from: NSNumber(value: payNumber0/100))! + "p"
        mileageNum.text = mileageNumber
    }
    
    // MARK: - Actions
    
    // 결제 완료하기
    
    @IBAction func payBtn(_ sender: UIButton) {
        
        // Requst Payment
        var detailOptionList = [DetailOptionList]()
        let selectedOptionIndex0 = UserDefaults.standard.data(forKey: "selectedOptionIndex")! 
        let selectedOptionIndex = try! PropertyListDecoder().decode([SelectedOptionIndex].self, from: selectedOptionIndex0)
        for i in selectedOptionIndex {
            detailOptionList.append(DetailOptionList(workOptionIndex: i.selectedOptionIndex, workOptionDetailIndex: i.selectedItemIndex))
        }
        
        let workNumber = UserDefaults.standard.value(forKey: "finalItemNum") as! Int
        let workPrice = UserDefaults.standard.value(forKey: "sellNum") as! Int
        let orderDetail = [OrderDetail(workIndex: 1, workNumber: workNumber, workPrice: workPrice, workfee: 3000, requests: "배송전 미리연락주세요.", detailOptionList: detailOptionList)]
        
        let userIdx = UserDefaults.standard.value(forKey: "userIdxKey") as! Int
        let totalPrice = UserDefaults.standard.value(forKey: "finalCostNum") as! Int
        let input = PayRequest(userIndex: userIdx, addressIndex: 1, totalPrice: totalPrice, orderDetails: orderDetail)
        dataManager.postPayment(input, delegate: self)
        
        self.showIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismissIndicator()
        }
        
    }
    
    // 전 화면 돌아가기
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - Table
extension PayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: PayTableViewCell.identifier, for: indexPath) as! PayTableViewCell
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: PayTableViewCell2.identifier, for: indexPath) as! PayTableViewCell2
            
            let payNumber0 = UserDefaults.standard.value(forKey: "sellNum") as! Int
            let itemNumber = numberFormatter.string(from: NSNumber(value: payNumber0))! + "원"
            let payNumber = numberFormatter.string(from: NSNumber(value: 3000+payNumber0))! + "원"
            cell.itemNum.text = itemNumber
            cell.payNum.text = payNumber
            
            return cell
        }
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 350
        } else {
            return 400
        }
    }
    
}


// MARK: - 성공/실패 데이터 메니저
    
extension PayVC {

    func didSuccessPayment(_ message: String) {
        let mainPage = UIStoryboard(name: "LoginedMainStoryboard", bundle: nil).instantiateViewController(identifier: "LoginedMainTabBarController")
        self.presentAlert(title: "결제 완료됐습니다!", message: message, isCancelActionIncluded: false) { action in
            self.changeRootViewController(mainPage)
        }
    }

    func failedToRequestPayment(message: String) {
        self.presentAlert(title: message)
    }

}
