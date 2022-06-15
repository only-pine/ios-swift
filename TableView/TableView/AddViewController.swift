//
//  AddViewController.swift
//  TableView
//
//  Created by 장한솔 on 2022/06/15.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet var tfAddItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //새로운 목록 추가
    @IBAction func btnAddItem(_ sender: UIButton) {
        //items에 tdAddItem 텍스트 값을 추가
        items.append(tfAddItem.text!)
        //itemsImageFile에 시간 이미지 추가
        itemsImageFile.append("clock.png")
        //input 값 초기화
        tfAddItem.text = ""
        //테이블 뷰 컨트롤러로 돌아간다.
        _ = navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
