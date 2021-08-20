////
////  UICollectionViewCell.swift
////  Idus_b
////
////  Created by 강성수 on 2021/08/21.
////
//
//import UIKit
//
//extension UICollectionViewCell {
//    
//    // MARK: 취소와 확인이 뜨는 UIAlertController
//    func presentAlert(title: String, message: String? = nil,
//                      isCancelActionIncluded: Bool = false,
//                      preferredStyle style: UIAlertController.Style = .alert,
//                      handler: ((UIAlertAction) -> Void)? = nil) {
//        
//        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
//        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
//        alert.addAction(actionDone)
//        if isCancelActionIncluded {
//            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//            alert.addAction(actionCancel)
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    // MARK: 커스텀 UIAction이 뜨는 UIAlertController
//    func presentAlert(title: String, message: String? = nil,
//                      isCancelActionIncluded: Bool = false,
//                      preferredStyle style: UIAlertController.Style = .alert,
//                      with actions: UIAlertAction ...) {
//        
//        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
//        actions.forEach { alert.addAction($0) }
//        if isCancelActionIncluded {
//            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//            alert.addAction(actionCancel)
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
//}
