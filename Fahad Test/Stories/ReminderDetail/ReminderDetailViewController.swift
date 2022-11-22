//
//  ReminderDetailViewController.swift
//  Fahad Test
//
//  Created by Mac on 21/11/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import AVFoundation

protocol ReminderDetailDisplayLogic: AnyObject {}

class ReminderDetailViewController: BaseViewController, ReminderDetailDisplayLogic {
    
    var reminderDetail: ListModel?
    let synthesizer = AVSpeechSynthesizer()
    
    var interactorReminderDetail: ReminderDetailInteractor? {
        return interactor as? ReminderDetailInteractor
    }
    
    var routerReminderDetail: ReminderDetailRouter? {
        return router as? ReminderDetailRouter
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var itsTimeVU: UIView!
    @IBOutlet weak var startEndTimeVU: UIStackView!
    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var reminderIMG: UIImageView!
    @IBOutlet weak var startTimeBTN: UIButton!
    @IBOutlet weak var nowTimeBTN: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressTimerLBL: UILabel!
    @IBOutlet weak var goBtnIMG: UIImageView!
    @IBOutlet weak var goBtnTitleLBL: UILabel!
        
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Functions
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func volumeBtnPressed(_ sender: UIButton) {
        guard let name = reminderDetail?.name else { return }
        doText2Speech(text: name)
    }
}

extension ReminderDetailViewController {
    func setupUI() {
        let currentDay = Date().convertUtcDateToString(desiredFormat: Constants.DAYNAME)
        let currentTime = Date().convertUtcDateToString(desiredFormat: Constants.TIME12HOURFORMAT)
        print(currentDay)
        nowTimeBTN.setTitle(currentTime, for: .normal)
        
        if let days = reminderDetail?.schedule?.dayTime {
            let keys: [String] = days.map{($0.key.lowercased())}
            if keys.contains(currentDay.prefix(3).lowercased()) {
                for i in days {
                    if i.key.lowercased() == currentDay.prefix(3).lowercased() {
                        startTimeBTN.setTitle(i.value, for: .normal)
                        if i.value == currentTime {
                            //TODO: Start Timer
                        }
                    }
                }
            } else {
                startTimeBTN.setTitle("\(days.first?.key ?? "-") \(days.first?.value ?? "-")", for: .normal)
            }
        }
        
        nameLBL.text = reminderDetail?.name ?? "-"
        if let img = reminderDetail?.imageURL, let imgURL = URL(string: img) {
            reminderIMG.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "imagePlaceholder"))
        }
    }
    
    func doText2Speech(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.1
        
        synthesizer.speak(utterance)
    }
}
