//
//  MenuViewController.swift
//  GameStep2
//
//  Created by Володимир Смульський on 1/11/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    enum chosenDrum: Int {
        case Levels = 0
        case Cards = 1
    }
    
    typealias Level = ( name:String, cards: [Int])
    var levels : [Level] =  [("Easy", [2,4,6,8]),
                             ("Normal", [12,16,20,24]),
                             ("Hard", [28,30,32,36])]
    
    let complexityOFGame = ["Easy","Normal","Hard"]
    let numberOfCards = ["4","6","8","12","16","20","24","26","28","32","36","40"]
    //FIXME: - WRITE INIT FOR THIS
    var numberOfCardsFromPicker:Int = 0
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func playButton(_ sender: UIButton) {
        //під час натискання кнопки переходимо на наступний контроллер
        performSegue(withIdentifier: "ArrowNumberOfCards", sender: self)
        numberOfCardsFromPicker = 6
    }
    
    
    
    
    // override перевизначає функцію з якогось протоколу
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //  as! FlipCardsViewController куди ми будемо передавати
        // if  write destination.view - it innitsialization all variaebles in next controller
        let temporaryVariableOfPicker = segue.destination as! FlipCardsViewController
        //тут ми вказуємо що ми змінну з нашого контроллера передаємо в іншу змінну в наступному контороллері
        temporaryVariableOfPicker.getCardNumbers = numberOfCardsFromPicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //return components in each drum
        switch component {
        case chosenDrum.Levels.rawValue:
            return levels.count
        case chosenDrum.Cards.rawValue:
            let level = levels[component]
            return level.cards.count
        default:
            fatalError("Don't return count of components in drum.")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let numberInPicker = UILabel()
        
        switch component {
        case chosenDrum.Levels.rawValue:
            let level = levels[row]
            numberInPicker.text = level.name
        case chosenDrum.Cards.rawValue:
            let index = pickerView.selectedRow(inComponent: 0)
            let level = levels[index]
            let card = level.cards[row]
            numberInPicker.text = "\(card)"//String(card)
            numberOfCardsFromPicker = level.cards[row]
        default:
            assertionFailure("It is don't chosen any picker drum.")
        }
        
        numberInPicker.frame = CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 50)
        numberInPicker.font = UIFont.boldSystemFont(ofSize: 30)
        numberInPicker.textAlignment = .center
        return numberInPicker
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100//pickerView.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // IF we chose level reload number of cards
        if component == chosenDrum.Levels.rawValue {
            pickerView.reloadComponent(chosenDrum.Cards.rawValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
        //            self.pickerView.selectRow(1000/2, inComponent: 0, animated: false)
        //        }
        numberOfCardsFromPicker = 28
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}



