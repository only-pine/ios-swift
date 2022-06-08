//
//  ViewController.swift
//  Datepicker
//
//  Created by 장한솔 on 2022/06/01.
//

import UIKit

class DateViewController: UIViewController {
    let timeSelector: Selector = #selector(DateViewController.updateTime)
    let timeInterval = 1.0
    var count = 0
    var currentTime = ""
    var pickerTime = ""
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        
        let datePickerView = sender
        let nowTime = NSDate()
        
        lblPickerTime.text = "선택 시간 : " + formatter.string(from: datePickerView.date)
        
        //mission: 선택한 시간과 현재 시간이 같으면 1분 동안 배경색 어둡게 한 후, 시간 지나면 원상 복귀
        pickerTime = formatter.string(from: datePickerView.date)
        currentTime = formatter.string(from: nowTime as Date)
        
        checkTime()
    }
    
    @objc func updateTime(){
//        lblCurrentTime.text = String(count)
//        count += 1
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        
        let date = NSDate()
        
        lblCurrentTime.text = "현재 시간 : " + formatter.string(from: date as Date)
        
        //mission: 선택한 시간과 현재 시간이 같으면 1분 동안 배경색 어둡게 한 후, 시간 지나면 원상 복귀
        currentTime = formatter.string(from: date as Date)

        checkTime()
    }
    
    func checkTime(){
        if( pickerTime == currentTime ){
            view.backgroundColor = UIColor.gray
        }else{
            view.backgroundColor = UIColor.white
        }
    }
    
}

