//
//  ViewController.swift
//  Alert
//
//  Created by 장한솔 on 2022/06/04.
//

import UIKit

class ViewController: UIViewController {
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-remove.png")
    
    var isLampOn = true
    
    @IBOutlet var lampImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lampImg.image = imgOn
    }

    //전구 켜기
    @IBAction func btnLampOn(_ sender: UIButton) {
        if(isLampOn == true) { //전구가 이미 켜져있는 경우, alert 창 띄우기
            //UIAlertController 생성
            let lampOnAlert = UIAlertController(title: "경고", message: "현재 On 상태입니다.", preferredStyle: UIAlertController.Style.alert)
            
            //UIAlertAction 생성
            let onAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
            
            //onAction을 Alert에 추가
            lampOnAlert.addAction(onAction)
            
            //present 메소드 실행
            present(lampOnAlert, animated: true, completion: nil)
        } else {
            lampImg.image = imgOn
            isLampOn = true
        }
    }
    
    //전구 끄기
    @IBAction func btnLampOff(_ sender: UIButton) {
        if isLampOn {
            //UIAlertController 생성
            let lampOffAlert = UIAlertController(title: "램프 끄기", message: "램프를 끄시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            
            //"네"에 대한 UIAction 생성
            let offAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {
                ACTION in self.lampImg.image = self.imgOff
                self.isLampOn = false
            })
            
            //"아니오"에 대한 UIAction 생성
            let cancelAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.default, handler: nil)
            
            //UIAction을 alert에 추가
            lampOffAlert.addAction(offAction)
            lampOffAlert.addAction(cancelAction)
            
            //present 메소드 실행
            present(lampOffAlert, animated: true, completion: nil)
        }
    }
    
    //전구 제거
    @IBAction func btnLampRemove(_ sender: UIButton) {
        //UIAlertController 생성
        let lampRemoveAlert = UIAlertController(title: "램프 제거", message: "램프를 제거하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        //"전구 끄기"에 대한 UIAction 생성
        let offAction = UIAlertAction(title: "아니오, 끕니다(off).", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImg.image = self.imgOff
            self.isLampOn = false
        })
        
        //"전구 켜기"에 대한 UIAction 생성(handler 매개변수 다르게 표현 가능)
        let onAction = UIAlertAction(title: "아니오, 켭니다(on).", style: UIAlertAction.Style.default) {
            ACTION in self.lampImg.image = self.imgOn
            self.isLampOn = true
        }
        
        //"전구 제거"에 대한 UIAction 생성
        let removeAction = UIAlertAction(title: "네, 제거합니다.", style: UIAlertAction.Style.default, handler: {
            ACTION in self.lampImg.image = self.imgRemove
            self.isLampOn = false
        })
        
        //UIAction alert에 추가
        lampRemoveAlert.addAction(offAction)
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(removeAction)
        
        //present 메소드 실행
        present(lampRemoveAlert, animated: true, completion: nil)
    }
}

