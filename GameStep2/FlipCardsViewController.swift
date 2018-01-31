//
//  FlipCardsViewController.swift
//  GameStep2
//
//  Created by Володимир Смульський on 1/11/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit

class FlipCardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
   
    
//    @IBAction func ResultButton(_ sender: Any) {
//        performSegue(withIdentifier: "ArrowToResult", sender: self)
//    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // fix this by get and set
    var flips = 0
    var getCardNumbers = 6
    var cellOfIndex:[IndexPath] = []
    var selectedIndex: IndexPath?
    
    var counter = 0.0 {
        didSet {
            timerItem.title = "Timer: \(counter)"
        }
    }
    var timer = Timer()
    var timerIsRuning = false
    
    
    @IBOutlet weak var flipsCount: UIBarButtonItem!
    
    @IBOutlet weak var timerItem: UIBarButtonItem!
    
    @IBAction func reloadItem(_ sender: UIBarButtonItem) {
        newGame()
    }
    
   
    
    var cartonImages : [UIImage] = [
        UIImage (named: "0")!,
        UIImage (named: "1")!,
        UIImage (named: "2")!,
        UIImage (named: "3")!,
        UIImage (named: "4")!,
        UIImage (named: "5")!,
        UIImage (named: "6")!,
        UIImage (named: "7")!,
        UIImage (named: "8")!,
        UIImage (named: "9")!,
        UIImage (named: "10")!,
        UIImage (named: "11")!,
        UIImage (named: "12")!,
        UIImage (named: "14")!,
        UIImage (named: "15")!,
        UIImage (named: "16")!,
        UIImage (named: "17")!,
        UIImage (named: "18")!,
        UIImage (named: "19")!,
        UIImage (named: "20")!,
        UIImage (named: "21")!,
        UIImage (named: "22")!,
        UIImage (named: "23")!,
        UIImage (named: "24")!,
        UIImage (named: "25")!,
        UIImage (named: "26")!,
        UIImage (named: "27")!,
        UIImage (named: "28")!,
        UIImage (named: "29")!,
        UIImage (named: "30")!,
        ]
    
    func shuffle () {
        var tempArrayOfImages = cartonImages
        cartonImages.removeAll()
        while !tempArrayOfImages.isEmpty {
            let randomIndex  =  Int(arc4random_uniform(UInt32(tempArrayOfImages.count - 1)))
            let image = tempArrayOfImages.remove(at: randomIndex)
            cartonImages.append(image)
        }
    }
    
    func oddArrayOfImages (){
        var tempArrayOfImages = cartonImages
        var unshuffled : [UIImage] = []
        cartonImages.removeAll()
        
        for i in 0 ..< getCardNumbers/2 {
            unshuffled.append(tempArrayOfImages[i])
            unshuffled.append(tempArrayOfImages[i])
        }
        while !unshuffled.isEmpty {
            let randomIndex  =  Int(arc4random_uniform(UInt32(unshuffled.count - 1)))
            let image = unshuffled.remove(at: randomIndex)
            cartonImages.append(image)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffle()
        oddArrayOfImages()
        
        flipsCount.title = "0"
        runTimer()
        UpdateTimer()
        
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.shareResults))
        self.navigationItem.rightBarButtonItem = rightButton
        // Do any additional setup after loading the view.
    }
    
    // кількість карток в рядку
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getCardNumbers
    }
    //FIXME - відступи  для селів
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
//    }
//
    // промальвуємо cell в collectionView
    
    //FIXME - розтягує картинки
//    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: <#T##Double#>, height: <#T##Double#>)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // змінна в яку будемо кидати картинки
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        // селі ми присвоюємо картинку  (indexPath.row - індекс картинки )(тобто беремо
        cell.ImageInCell.image = UIImage(named: "background")
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch selectedIndex {
//        case nil :
//            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
//            cell.flip(picture: cartonImages[indexPath.row])// image wich we chouse now
//            selectedIndex = indexPath
//        case indexPath? :
//            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
//            cell.flip(picture: UIImage (named: "background2")!)
//            self.selectedIndex = nil
//        default:
//            break
//        }
//
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flips += 1
        flipsCount.title = "\(flips)"
        if selectedIndex == nil {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.flip(picture: cartonImages[indexPath.row])// image wich we chouse now
            selectedIndex = indexPath
        } else
                {// two is chossen
            if self.selectedIndex == indexPath
                { // the same is selected
                let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                cell.flip(picture: UIImage (named: "background2")!)
                //                self.selectedIndex = nil
                //self.cardsCollection.isUserInteractionEnabled = false
            } else if self.cartonImages[indexPath.row] ==  self.cartonImages[(self.selectedIndex!.row)]
                {
                let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                cell.flip(picture: self.cartonImages[(indexPath.row)])
             //   DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    let cell1 = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                    let cell2 = collectionView.cellForItem(at: self.selectedIndex!) as! CollectionViewCell
                    cell1.remove()
                    cell2.remove()

              //  })
            } else
                {// if cellidendendefier is different
                let cell1 = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                cell1.flip(picture: self.cartonImages[(indexPath.row)])
              //  DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    let cell2 = collectionView.cellForItem(at: self.selectedIndex!) as! CollectionViewCell
                    cell1.flipDown(picture: UIImage (named: "background2")!)
                    cell2.flipDown(picture: UIImage (named: "background2")!)
                    //                self.selectedIndex = nil
              //  })

            }
                self.selectedIndex = nil
        }

    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = collectionView.frame.width
//        let screenHeight = collectionView.frame.height
//        //cellForRowAndCollomn - count of cards
//        // cellsAmount - 2 numbers colum and row
//        // cellsAmount - create tuple
////        let cellCounter = getCardNumbers[cellsAmount]
////        return CGSize(width: screenWidth/CGFloat(cellCounter![0]) - 10, height: screenHeight/CGFloat(cellCounter![1]) - 10)
//    }
    
    // for hiden status bar
    
    // sharing
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
    
    //FIXME:- Timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: (#selector(UpdateTimer)), userInfo: nil, repeats: true)
    }
    
  @objc func UpdateTimer() {
        counter += 0.2
    }
    
    // for reload game
    func newGame() {

        shuffle()
        oddArrayOfImages()
        counter = 0.0
        //relload cell 
        collectionView.reloadData()
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
