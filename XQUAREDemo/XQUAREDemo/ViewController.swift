//
//  ViewController.swift
//  XQUAREDemo
//
//  Created by 김수완 on 2021/06/15.
//

import UIKit
import MealIntentKit
import Intents
import IntentsUI
import RxSchoolMeal
import RxSwift

class ViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        super.restoreUserActivityState(activity)
        
        
    }

    @IBAction func addShortcutBtn(_ sender: Any) {
        guard let shortcut = INShortcut(intent: ViewTodaysMealIntent()) else {
            return
        }
        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            print("Error adding voice shortcut: \(error)")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
