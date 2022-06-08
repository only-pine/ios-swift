//
//  ViewController.swift
//  PageControl
//
//  Created by 장한솔 on 2022/06/08.
//

import UIKit

class ViewController: UIViewController {
    var images = [ "01.png", "02.png", "03.png", "04.png", "05.png", "06.png" ]
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //페이지 컨트롤의 전체 페이지 수
        pageControl.numberOfPages = images.count
        //현재 페이지
        pageControl.currentPage = 0
        //페이지 컨트롤의 색
        pageControl.pageIndicatorTintColor = UIColor.gray
        //현재 페이지를 나타내는 페이지 컨트롤의 색
        pageControl.currentPageIndicatorTintColor = UIColor.white
        //imgView의 이미지
        imgView.image = UIImage(named: images[0])
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
}

