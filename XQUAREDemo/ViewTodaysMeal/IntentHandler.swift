//
//  IntentHandler.swift
//  ViewTodaysMeal
//
//  Created by 김수완 on 2021/06/15.
//

import Intents
import MealIntentKit
import RxSchoolMeal
import RxSwift

class IntentHandler: INExtension {
    
    let disposeBag = DisposeBag()
    
    override func handler(for intent: INIntent) -> Any {
        if intent is ViewTodaysMealIntent {
            SchoolCommon.initSchool(schoolName: "대덕소")
            return ViewTodaysMealIntentHandler(timePart: getPartTimeStr() ,mealStr: getMealStr())
        }
        
        fatalError("Unhandled intent type: \(intent)")
    }
    
    private func getPartTimeStr() -> String {
        switch nowPartTime() {
        case .breakfast:
            return "아침"
        case .lunch:
            return "점심"
        case .dinner:
            return "저녁"
        }
    }
    
    private func getMealStr() -> String {
        var flag = true
        var meal: String?
        MEAL.getMeal(.today, timePart: nowPartTime()).subscribe(onSuccess: {
            if $0 == [] {
                meal = "없습니다."
            } else {
                meal = $0.joined(separator: ", ") + "입니다."
            }
            flag = false
        }, onFailure: { _ in
            meal = "없습니다."
            flag = false
        })
        .disposed(by: disposeBag)
        
        while flag {}
        return meal!
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
    
}
