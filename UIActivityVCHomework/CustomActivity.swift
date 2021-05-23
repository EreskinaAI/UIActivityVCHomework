//
//  CustomActivity.swift
//  UIActivityVCHomework
//
//  Created by Анна Ереськина on 23.05.2021.
//

import UIKit

/// Кастомная Activity
class CustomActivity: UIActivity {
    
    // MARK: Properties
    
    /// Тип
    var customActivityType: UIActivity.ActivityType
    /// Переданные итемы
    var activityItems: [Any] = []
    /// Название
    var activityName: String
    /// Картинка
    var activityImageName: String
    /// Действие по нажатию
    var activityTapped: ([Any]) -> Void
    
    init(title: String, imageName: String, performAction: @escaping ([Any]) -> Void) {
        self.activityName = title
        self.activityImageName = imageName
        self.customActivityType = UIActivity.ActivityType(rawValue: "Action \(title)")
        self.activityTapped = performAction
        super.init()
    }
    
    override var activityType: UIActivity.ActivityType? {
        return customActivityType
    }
    
    override var activityTitle: String? {
        return activityName
    }
    
    override class var activityCategory: UIActivity.Category {
        return .share
    }
    
    override var activityImage: UIImage? {
        return UIImage(named: activityImageName)
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        self.activityItems = activityItems
    }
    
    override func perform() {
        activityTapped([activityItems])
    }
}
