//
//  TransitionViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

class TransitionViewController: BaseViewController {
    
    // MARK: - 네비게이션 방식 화면 전환
    
    // MARK: 네비게이션 컨트롤러를 이용해 뷰 push(새로운 뷰가 오른쪽에서 왼쪽으로 이동)
    func pushVC() {
        let pushedVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "GoodsPageViewController")

        self.navigationController?.pushViewController(pushedVC, animated: true)
    }
    
    // MARK: 네비게이션 컨트롤러를 이용해 뒤로가기
    @IBAction func navigationPopButtonTouchUpInside(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 네비게이션 컨트롤러를 이용해 RootViewController로 이동
    @IBAction func changeRootViewControllerButtonTouchUpInside(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - 새로운 window로 화면전환
    @IBAction func changeWindowButtonTouchUpInside(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        let loginViewController = loginStoryboard.instantiateViewController(identifier: "LoginViewController")
        self.changeRootViewController(loginViewController)
    }
    
    // MARK: - 모달 방식 화면전환
    func modalVC() {
        let nextVC = UIStoryboard(name: "GoodsPageStoryboard", bundle: nil).instantiateViewController(withIdentifier: "GoodsPageViewController")
        nextVC.modalTransitionStyle = .partialCurl
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: modal 내리기
    @IBAction func dismissModalButtonTouchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
