//
//  ChangeNavigationColorViewController.swift
//  SPSPhotoBook
//
//  Created by 鶴本賢太朗 on 2018/07/13.
//  Copyright © 2018年 Kentarou. All rights reserved.
//

import UIKit

// ナビゲーションバーの色を設定できるViewController
// 遷移前と遷移後のナビゲーションの色が違う場合、遷移前の画面に戻った時にタイトルの色が変更されない場合がある
// 解決方法は遷移後の画面でwillMoveをオーバーライドしてそこで色を変更する
// その場合、遷移先が多いとそこに条件分岐の数が増えて鬱陶しくなるためこのクラスを作成した
// 遷移前と遷移後でタイトルの色が一緒ならこのクラスは不要である
// 遷移前と遷移後のViewControllerを継承させないと何も起こらない
// setNavigationColorsをオーバーライドしてそこに色を設定する処理を書き込む
class ChangeNavigationColorViewController: UIViewController {
    
    override func willMove(toParentViewController parent: UIViewController?) {
        // 現在表示している画面がChangeNavigationColorViewControllerを継承しているか?
        guard let navi: UINavigationController = self.navigationController else { return }
        guard let currentVC: ChangeNavigationColorViewController = navi.viewControllers.last as? ChangeNavigationColorViewController else {
            return
        }
        if currentVC != self || navi.viewControllers.count < 2 { return }
        
        // 前の画面を取得する
        if let preVC: ChangeNavigationColorViewController = navi.viewControllers[navi.viewControllers.count - 2] as? ChangeNavigationColorViewController {
            // 前の画面の色をここで設定する
            preVC.setNavigationColors()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationColors()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController: ChangeNavigationColorViewController = navigationController?.viewControllers.last as? ChangeNavigationColorViewController {
            currentViewController.animateNavigationColors()
        }
    }
    
    private func animateNavigationColors() {
        self.transitionCoordinator?.animate(alongsideTransition: { [weak self] (context) in
            self?.setNavigationColors()
            }, completion: nil)
    }
    
    internal func setNavigationColors() {
        // このメソッドをオーバーライドしてナビゲーションの背景色、タイトルカラー、戻るボタンの色を設定する
    }
}
