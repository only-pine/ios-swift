//
//  ViewController.swift
//  Audio
//
//  Created by 장한솔 on 2022/06/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    var audioPlayer: AVAudioPlayer! //AVAudioPlayer 인스턴스 변수
    var audioFile: URL!             //재생할 오디오의 파일명 변수
    let MAX_VOLUME: Float = 10.0    //최대 볼륨, 실수형 상수
    var progressTimer: Timer!       //타이머를 위한 변수
    
    //재생 타이머를 위한 상수
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector: Selector = #selector(ViewController.updateRecordTime)
    
    /** 오디오 재생 변수 */
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    /** 녹음 변수 */
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder: AVAudioRecorder! //audioRecord 인스턴스 변수
    var isRecordMode = false            //녹음 모드 실행 여부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        
        if !isRecordMode {
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else {
            initRecord()
        }
    }
    
    //모드에 따라 파일을 선택하는 함수
    func selectAudioFile(){
        if !isRecordMode {  //재생 모드일 땐, 오디오 파일인 재생 파일 재생
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else {            //녹음 모드일 땐, 새 파일 생성
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    //녹음 초기화하는 함수
    func initRecord(){
        //녹음에 대한 설정
        let recordSettings = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000 ,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0] as [String: Any]
        
        //audioFile을 URL로 하는 audioRecorder 인스턴스 생성
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        
        audioRecorder.delegate = self
        
        /** 녹음을 할 때 필요한 모든 값 초기화 */
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        //AVAudioSession의 인스턴스 session 생성
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    }
    
    //오디오 재생 초기화하는 함수
    func initPlay(){
        //audioFile을 URL로 하는 audioPlayer 인스턴스를 생성
        //AVAudioPlayer함수는 입력 파라미터인 오디오 파일이 없을 때에 대비하여 do-try-catch문을 사용합니다.
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        /** 오디오를 재생할 때 필요한 모든 값 초기화 **/
        //슬라이더의 최대 볼륨을 상수 MAX_VOLUME의 값으로 초기화한다.
        slVolume.maximumValue = MAX_VOLUME
        //슬라이더의 현재 볼륨을 1.0로 초기화한다.
        slVolume.value = 1.0
        //프로그래스의 진행을 0으로 초기화한다.
        pvProgressPlay.progress = 0
        
        //audioPlayer의 델리게이트를 self로 한다.
        audioPlayer.delegate = self
        //prepareToPlay() 실행한다.
        audioPlayer.prepareToPlay()
        //audioPlayer의 볼륨을 슬라이더의 볼륨의 값으로 초기화한다.
        audioPlayer.volume = slVolume.value
        
        //곡 재생 시간을 나타내기 위해 초기화한다.
        //audioPlayer.duration은 초 단위 실수 값으로 원하는 형식으로 형태를 바꿔야 한다.
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        //재생버튼만 활성화처리
        setPlayButtons(true, pause: false, stop: false)
    }
    
    //재생, 일시정지, 정지 버튼에 대한 동작여부 설정하는 함수
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    //TimeInterval 값(초)을 받아 문자열로 돌려보내는 함수 convertNSTImeInterval2String 생성
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        //time을 60으로 나눈 몫을 정수 값으로 변환
        let min = Int(time/60)
        //time을 60으로 나눈 나머지 값을 정수 값으로 변환
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    //play 버튼
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        //0.1초 간격으로 타이머를 생성
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    //0.1초 간격으로 호출되면서 재생시간 업데이트 시키는 함수
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    //pause 버튼
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    
    //stop 버튼(초기화)
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        pvProgressPlay.progress = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate()  //타이머 무효화
    }
    
    //볼륨 조절하는 함수
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    //오디오 재생이 끝나면 맨 처음 상태로 돌아가도록 하는 함수
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        pvProgressPlay.progress = 0
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    //재생/녹음 모드 변경하는 함수
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn { //녹음 모드
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else {        //재생 모드
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        
        selectAudioFile()
        
        if !isRecordMode {
            initPlay()
        } else {
            initRecord()
        }
    }
    
    //녹음/정지하는 함수
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        } else {
            audioRecorder.stop()
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
}

