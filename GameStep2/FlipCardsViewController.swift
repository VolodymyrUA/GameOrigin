//
//  FlipCardsViewController.swift
//  GameStep2
//
//  Created by Володимир Смульський on 1/11/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.
//

import UIKit

class FlipCardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
   
    
    @IBAction func ResultButton(_ sender: Any) {
        performSegue(withIdentifier: "ArrowToResult", sender: self)
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    var getCardNumbers = 6
    var cellOfIndex:[IndexPath] = []
    
    // масив UIImage наших карточок із їх ідентифаєром
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
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // кількість карток в рядку
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getCardNumbers
    }
    // промальвуємо cell в collectionView
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // змінна в яку будемо кидати картинки
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        // селі ми присвоюємо картинку  (indexPath.row - індекс картинки )(тобто беремо
        cell.ImageInCell.image = UIImage(named: "background")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // logic of flipping
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if cell.isFaceUp == true {
            cell.flip(picture: UIImage (named: "background2")!)
            //  cell.isFaceUp = false
        } else {
            cell.flip(picture: cartonImages[indexPath.row])
            //   cell.isFaceUp = true
        }
        
    }
    
    // for hiden status bar
    override var prefersStatusBarHidden: Bool{
        return true
    }

}
