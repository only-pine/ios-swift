//
//  EditViewController.swift
//  Navigation
//
//  Created by 장한솔 on 2022/06/09.
//

import UIKit

//프로토콜
protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate : EditDelegate?
    var isOn = false
    
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var swIsOn: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //전달된 데이터 세팅
        lblWay.text = textWayValue
        txtMessage.text = textMessage
        swIsOn.isOn = isOn
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        //메인 화면으로 텍스트와 전구 이미지 상태 보내기
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txtMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
        }
        //메인 화면으로 이동
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
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
