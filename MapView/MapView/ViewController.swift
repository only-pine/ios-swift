//
//  ViewController.swift
//  MapView
//
//  Created by 장한솔 on 2022/06/06.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   //정확도 최고로 설정
        locationManager.requestWhenInUseAuthorization() //위치 데이터 추적을 위해 사용자에게 승인 요구
        locationManager.startUpdatingLocation() //위치 업데이트 시작
        myMap.showsUserLocation = true  //위치 보기 값을 true로 설정
    }
    
    //사용자가 원하는 위도/경도를 보여주는 함수
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D{
        //위도/경도 값을 매개변수로 하여, CLLocationCoordinate2DMake 함수 호출
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        //범위 값을 매개변수로 하여, MKCoordinateSpanMake 함수 호출
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        //pLocation, spanValue 값을 매개변수로 하여, MKCoordinateRegion 함수 호출
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        //pRegion값을 매개변수로 하여, myMap.setRegion 함수 호출
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    //특정 위치에 핀 설치하는 함수
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle :String, subtitle strSubTitle :String){
        //핀을 설치하기 위해 MKPointAnnotation 함수 호출
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubTitle
        myMap.addAnnotation(annotation)
    }
    
    //위치가 업데이트되었을 때, 지도에 위치를 나타내기 위한 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치가 업데이트되면, 먼저 마지막 위치 값을 찾아냄
        let pLocation = locations.last
        //마지막 위치의 위경도 값을 가지고 goLocation 함수 호출
        //delta의 값은 지도의 크기를 정하는데, 값이 작을수록 확대됨
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        //위경도 값으로, 주소 찾기
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            //country : 나라
            //locality : 지역
            //thoroughfare : 도로
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
        })
        
        //위치가 업데이트 되는 것을 멈춤
        locationManager.stopUpdatingLocation()
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {           //현재 위치
            lblLocationInfo1.text = ""
            lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {    //우리집 위치
            setAnnotation(latitudeValue: 37.4666477034569, longitudeValue: 126.89387866198325, delta: 0.01, title: "한솔이네 집", subtitle: "서울특별시 금천구 범안로 1189")
            lblLocationInfo1.text = "보고 계신 위치"
            lblLocationInfo2.text = "그랑드 오피스텔"
        } else if sender.selectedSegmentIndex == 2 {    //회사 위치
            setAnnotation(latitudeValue: 37.472402410206854, longitudeValue: 126.88150590460498, delta: 0.01, title: "한솔이네 회사", subtitle: "서울특별시 금천구 가산동 554-2")
            lblLocationInfo1.text = "보고 계신 위치"
            lblLocationInfo2.text = "가산 한화 비즈 메트로 2차"
        }
    }
    
}

