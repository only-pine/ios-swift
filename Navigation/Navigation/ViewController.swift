//
//  ViewController.swift
//  Navigation
//
//  Created by 장한솔 on 2022/06/09.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    
    var isOn = true
    
    @IBOutlet var txtMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }
    
    //세그웨이를 이용하여 화면을 전환하기 위해 prepare 함수 사용
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //세그웨이의 도착 컨트롤러를 EditViewController 형태를 가지는 segue.destinationViewController로 선언
        let editViewController = segue.destination as! EditViewController
        
        if segue.identifier == "editButton" {           //버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" { //바 버튼을 클릭한 경우
            editViewController.textWayValue = "segue : use Bar button"
        }
        
        //수정 화면으로 전달할 데이터
        editViewController.textMessage = txtMessage.text!
        editViewController.isOn = isOn
        editViewController.delegate = self
    }

    //수정 화면에서 온 메시지 값을 텍스트 필드에 표시
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txtMessage.text = message
    }
    
    //수정 화면에서 온 전구 이미지 상태 세팅
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        //isOn = 파라미터 isOn
        //self.isOn = 자기 자신의 컨트롤러 안의 변수 isOn
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
}

