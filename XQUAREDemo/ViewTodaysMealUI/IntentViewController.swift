//
//  IntentViewController.swift
//  ViewTodaysMealUI
//
//  Created by 김수완 on 2021/06/15.
//

import IntentsUI
import MealIntentKit
import RxSwift
import RxSchoolMeal

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var timeTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SchoolCommon.initSchool(schoolName: "대덕소")
        setTimeTypeLabel()
        setMenuLabel()
        setDateLabel()
        
    }
    
    func setTimeTypeLabel() {
        switch nowPartTime() {
        case .breakfast:
            timeTypeLabel.text = "아침"
        case .lunch:
            timeTypeLabel.text = "점심"
        case .dinner:
            timeTypeLabel.text = "저녁"
        }
    }
    
    func setMenuLabel() {
        MEAL.getMeal(.today, timePart: nowPartTime()).subscribe(onSuccess: {
            self.menuLabel.text = $0 == [] ? "없습니다." : $0.joined(separator: ", ")
        })
        .disposed(by: disposeBag)
    }
    
    func setDateLabel() {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = fomatter.string(from: Date())
    }
    
    private func nowPartTime() -> MealPartTime {
        let hourFomatter = DateFormatter()
        hourFomatter.dateFormat = "HH"
        let minuteFomatter = DateFormatter()
        minuteFomatter.dateFormat = "mm"
        let nowTime = (
            Int(hourFomatter.string(from: Date()))!,
            Int(minuteFomatter.string(from: Date()))!
        )
        return ((nowTime.0 >= 0 && nowTime.1 >= 0) && (nowTime.0 <= 8 && nowTime.1 <= 20)) ? .breakfast : (nowTime.0 <= 13 && nowTime.1 <= 30) ? .lunch : .dinner
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.
        if interaction.intentHandlingStatus == .success {
            if let _ = interaction.intentResponse as? ViewTodaysMealIntentResponse {
            }
            //completion(false, parameters, self.desiredSize)
            completion(true, parameters, CGSize(width: 320, height: 120))
        }
        
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
