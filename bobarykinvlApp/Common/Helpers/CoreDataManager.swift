//
//  CoreDataManager.swift
//  bobarykinvlApp
//
//  Created by Vladislav Bobarykin on 8.01.23.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Animation> = Animation.fetchRequest()
    
    func fetchRequestAnimation() {
        let fetchRequest: NSFetchRequest<Animation> = Animation.fetchRequest()
        
        do {
            animations = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func saveAnimation(title: String, imageURL: String, animationType: Int) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Animation", in: context) else { return }
        let taskObject = Animation(entity: entity, insertInto: context)
        taskObject.title = title
        taskObject.imageURL = imageURL
        taskObject.animationTransitionType = Int32(animationType)
        
        do {
            try context.save()
            animations.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAnimation(animation: Animation) {
        context.delete(animation)
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getDataFromFile() {
        var records = 0
        do {
            records = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        guard let pathToFile = Bundle.main.path(forResource: "animationsData", ofType: "plist"),
              let dataArray = NSArray(contentsOf: URL(fileURLWithPath: pathToFile)) else { return }
        
        for dictionary in dataArray {
            guard let entity = NSEntityDescription.entity(forEntityName: "Animation", in: context) else { return }
            let taskObject = Animation(entity: entity, insertInto: context)
            let animationDictionary = dictionary as! [String: AnyObject]
            
            taskObject.title = animationDictionary["title"] as? String
            taskObject.descriptionAnimation = animationDictionary["descriptionAnimation"] as? String
            taskObject.imageURL = animationDictionary["imageURL"] as? String
            taskObject.animationTransitionType = animationDictionary["animationTransitionType"] as? Int32 ?? 0
            
            do {
                try context.save()
                animations.append(taskObject)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
}
