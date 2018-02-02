//
//  RecordsViewController.swift
//  GameStep2
//
//  Created by Володимир Смульський on 2/1/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit
import CoreData

class RecordsViewController: UIViewController {
    
    
    
    
    var temporyFlip = 0
    var variablesForData = ( time:0, flips:0, level:0, gamerName:"User")
    
    var results: [NSManagedObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //--------------------------DataBase
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Scores") //
        do {
            results = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print("Failed to fetch items", err)
        }
        saveNewResult()
        do {
            results = try managedContext.fetch(fetchRequest)
        } catch let err as NSError {
            print("Failed to fetch items", err)
        }
    }
    
    func saveNewResult() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        // variables wich we pass in DB
        let newResult = NSEntityDescription.insertNewObject(forEntityName: "Scores", into: context) // name of schame
        
        // newResult.setValue(cardsNumberFromGameController, forKey: "level") // тут жовтим атрибути в твоїй схемі
        newResult.setValue(variablesForData.flips, forKey: "flipCount")
        newResult.setValue(variablesForData.time, forKey: "time")
        newResult.setValue(variablesForData.level, forKey: "level")
        newResult.setValue(variablesForData.gamerName, forKey: "name")
        
        do {
            try context.save()
            results.append(newResult)
        } catch {
            print("error")
        }
    }
    //--------------------end DataBase
    
    // ---shring
    @objc func shareResults(){
        let screenForSharing = captureScreen()
        let activityVC = UIActivityViewController(activityItems: [screenForSharing!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func captureScreen() -> UIImage? {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
    
    
}
