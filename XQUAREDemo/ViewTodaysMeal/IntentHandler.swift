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
                meal = self.deleteBracket(str: $0.joined(separator: ", ")) + "입니다."
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
    
    private func deleteBracket(str: String) -> String {
        var processedStr = str
        processedStr = processedStr.replacingOccurrences(of: "(", with: " #")
        for branket in processedStr.getArrayAfterRegex(regex: "#[^ ]+") {
            processedStr = processedStr.replacingOccurrences(of: branket, with: "")
        }
        return processedStr
    }
    
    private func nowPartTime() -> MealPartTime {
        let now = Date()
        var components = DateComponents(year: Calendar.current.dateComponents([.year], from: now).year!,
                                        month: Calendar.current.dateComponents([.month], from: now).month!,
                                        day: Calendar.current.dateComponents([.day], from: now).day!)
        components.hour = 8
        components.minute = 20
        let breakfastEndTime = Calendar.current.date(from: components)!
        components.hour = 13
        components.minute = 30
        let lunchEndTime = Calendar.current.date(from: components)!
        
        return now < breakfastEndTime ? .breakfast : now < lunchEndTime
             ? .lunch : .dinner
    }
    
}

extension String{
    func getArrayAfterRegex(regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
