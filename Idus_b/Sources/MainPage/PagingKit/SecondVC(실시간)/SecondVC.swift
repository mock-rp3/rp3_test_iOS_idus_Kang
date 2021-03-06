//
//  SecondVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class SecondVC: BaseViewController {
    
    // MARK: - 프로퍼티
    
    lazy var nowGoodsDataManager: NowGoodsDataManager = NowGoodsDataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowGoodsDataManager.getNowGoodsData(delegate: self)
        
        let tableViewNib = UINib(nibName: "NowGoodsTableViewCell", bundle: nil)
        tableView.register(tableViewNib, forCellReuseIdentifier: "NowGoodsTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
extension SecondVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NowGoodsTopTableViewCell.identifier) as? NowGoodsTopTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NowGoodsTableViewCell.identifier) as? NowGoodsTableViewCell else {
                return UITableViewCell()
            }
            cell.setCell()
            cell.delegate = self
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NowGoodsTableViewCell.identifier) as? NowGoodsTableViewCell else {
                return UITableViewCell()
            }
            cell.setCell()
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }else if indexPath.row == 1 {
            return 400
        }else {
            return 400
        }
    }
}

extension SecondVC: CVCellDelegate {
    func selectedCVCell(_ index: Int) {
        print("\(index)번째 셀")
    }
}

// MARK: - DataManager

// NowGoodsResult
extension SecondVC {
    func successGetNowGoodsData(result: [NowGoodsWorkList]) {
        var idx = 0
        for list in result {
            UserDefaults.standard.set(list.image, forKey: "nowGoodsImage\(idx)")
            UserDefaults.standard.set(list.authorName, forKey: "nowGoodsSellerName\(idx)")
            UserDefaults.standard.set(list.title, forKey: "nowGoodsName\(idx)")
            idx += 1
        }
    }
}
