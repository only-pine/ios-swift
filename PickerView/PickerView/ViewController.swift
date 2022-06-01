//
//  ViewController.swift
//  PickerView
//
//  Created by 장한솔 on 2022/06/01.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLUMN = 1
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    var imageArray = [UIImage?]()
    var imageFileName = [ "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg",
                          "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg"]
    
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //imageFileName에 있는 이미지를 imageArray에 할당시킨다.
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        //레이블과 이미지 뷰에 배열의 처음에 해당하는 파일명과 이미지를 출력하도록 한다.
        lblImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }
    
    /* 델리게이트 메서드 */
    //피커에게 컴포넌트의 수를 정수 값으로 넘겨주는 델리게이트 함수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    //피커의 해당 열에서 선택할 수 있는 행의 갯수를 넘겨주는 델리게이트 함수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }

    //피커에게 컴포넌트의 각 열의 타이틀을 문자열 값으로 넘겨주는 델리게이트 함수
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileName[row]
//    }
    
    //피커에게 컴포넌트의 높이를 정수 값으로 넘겨주는 델리게이트 함수
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    //피커에게 컴포넌트의 각 열의 뷰를 UIView 타입의 값으로 넘겨주는 델리게이트 함수
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)

        return imageView
    }
    
    //사용자가 피커 뷰의 룰렛을 선택했을 때 호출되는 델리게이트 함수
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblImageFileName.text = imageFileName[row]
        imageView.image = imageArray[row]
    }
}

