//
//  ThirdVC.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/19.
//

import UIKit

class ThirdVC: BaseViewController {
    
    @IBOutlet var table: UITableView!
    var models = [imgModel]()
    var i = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        while let _ = UIImage(named: "main_banner\(i)") {
            models.append(imgModel(imageName: "main_banner\(i)"))
            i += 1
        }
        
        table.register(NewGoodsTableViewCell.nib(), forCellReuseIdentifier: NewGoodsTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
    }
}

extension ThirdVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: NewGoodsTableViewCell.identifier, for: indexPath) as? NewGoodsTableViewCell else { return UITableViewCell()}
        cell.configure30(with: models)
        cell.delegate = self
        return cell
    }
    
    // 테이블뷰 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - 배너 컬렉션뷰 이미지 클릭 이벤트 델리게이트 채택
extension ThirdVC: NewGoodsViewDelegate {
    func didSelectedGoods(_ index: Int) {
        print("\(index)번째 셀")
    }
}
