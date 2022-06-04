//
//  ViewController.swift
//  WebView
//
//  Created by 장한솔 on 2022/06/04.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var myWebView: WKWebView!
    
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)            //url을 URL형으로 선언
        let myRequest = URLRequest(url: myUrl!) //myUrl을 받아 URLRequest형으로 선언
        myWebView.load(myRequest)               //myWebView 클래스의 load 메소드 호출
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self
        loadWebPage("https://www.naver.com")
    }
    
    //로딩 중인지 확인하기 위한 함수
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //웹뷰가 로딩 중일 때 인디케이터를 실행하고 화면에 나타나게 함
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    //로딩이 완료되었을 때 인디케이터 중지하는 함수
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    //로딩 실패시 동작하는 함수
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    //https:// 자동 삽입해주는 함수
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("https://")
        if !flag {
            strUrl = "https://" + strUrl
        }
        return strUrl
    }

    //Go 버튼
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    //Site1 버튼
    @IBAction func btnGosite1(_ sender: UIButton) {
        loadWebPage("https://www.daum.net")
    }
    
    //Site2 버튼
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("https://www.youtube.com")
    }
    
    //HTML 버튼
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        //loadHTMLString 함수를 이용하여 변수에 저장된 HTML문을 웹 뷰에 나타냄
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    //File 버튼
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        //htmlView.html 파일에 대한 path를 변수에 저장
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        //URL 변수 생성
        let myUrl = URL(fileURLWithPath: filePath!)
        //URLRequest 변수 생성
        let myRequest = URLRequest(url: myUrl)
        //HTML 파일 로딩
        myWebView.load(myRequest)
    }
    
    //Stop 버튼
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    
    //Reload 버튼
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    
    //뒤로가기 버튼
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    
    //앞으로가기 버튼
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
}

