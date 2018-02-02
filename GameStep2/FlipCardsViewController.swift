
import UIKit
import CoreData

class FlipCardsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var flips = 0
    var getCardNumbers = 6
    var cellOfIndex:[IndexPath] = []
    var selectedIndex: IndexPath?
    var cardCounter = 0
    var timerCounter = 0 {
        didSet {
            timerItem.title = "Time: \(timerCounter)"
        }
    }
    var timer = Timer()
    var timerIsRuning = false
    
    @IBOutlet weak var flipsCount: UIBarButtonItem!
    
    @IBOutlet weak var timerItem: UIBarButtonItem!
    
    @IBAction func pauseItem(_ sender: Any) {
        pause()
    }
    
    @IBAction func reloadItem(_ sender: UIBarButtonItem) {
        reloadGame()
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
    //MARK: Shuffle cards
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getCardNumbers
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAllert()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // змінна в яку будемо кидати картинки
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        // селі ми присвоюємо картинку  (indexPath.row - індекс картинки )(тобто беремо
        cell.ImageInCell.image = UIImage(named: "background")
        return cell
    }
    
    //Mark: Game Logic
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flips += 1
        flipsCount.title = "Flip:\(flips)"
        if selectedIndex == nil {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.flip(picture: cartonImages[indexPath.row])// image wich we chouse now
            selectedIndex = indexPath
        } else
        {// two is chossen
            if self.selectedIndex == indexPath
            { // the same is selected
                let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                cell.flip(picture: UIImage (named: "background2")!)} else if self.cartonImages[indexPath.row] ==  self.cartonImages[(self.selectedIndex!.row)] {
                let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                cell.flip(picture: self.cartonImages[(indexPath.row)])
                let cell1 = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                let cell2 = collectionView.cellForItem(at: self.selectedIndex!) as! CollectionViewCell
                cell1.remove()
                cell2.remove()
                cardCounter += 2
                if (cardCounter == getCardNumbers) {
                    //allertGameDone()
                    stopTimer()
                }
            } else {   // if cellidendendefier is different
                let cell1 = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
                cell1.flip(picture: self.cartonImages[(indexPath.row)])
                let cell2 = collectionView.cellForItem(at: self.selectedIndex!) as! CollectionViewCell
                cell1.flipDown(picture: UIImage (named: "background2")!)
                cell2.flipDown(picture: UIImage (named: "background2")!)
            }
            self.selectedIndex = nil
        }
        
    }
    
    //MARK: Pause game
    func pause() {
        if !(timer.isValid ) {
            timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
            self.collectionView.isUserInteractionEnabled = true
        } else {
            timer.invalidate()
            self.collectionView.isUserInteractionEnabled = false
        }
    }
    
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
    
    //MARK: timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(UpdateTimer)), userInfo: nil, repeats: true)
    }
    @objc func UpdateTimer() {
        timerCounter += 1
    }
    func stopTimer() -> Int {
        timer.invalidate()
        return timerCounter
    }
    
    //MARK: Reload Game
    func reloadGame() {
        shuffle()
        oddArrayOfImages()
        flips = 0
        flipsCount.title = "Flip:\(flips)"
        timerCounter = 0
        //relload cell 
        collectionView.reloadData()
        runTimer()
    }
    
   
   
    //MARK: saving in DB
    func saveResult(name:String)  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let newResult = NSEntityDescription.insertNewObject(forEntityName: "Scores", into: context)
        
        newResult.setValue(segueData.userName, forKey: "name")
        newResult.setValue(segueData.timer, forKey: "time")
        newResult.setValue(segueData.level, forKey: "level")
        newResult.setValue(segueData.flips, forKey: "flipcount")
    }
    
    //MARK: - alert
    func showAllert() {
        let alertController = UIAlertController(title: "Welcome ", message: "Please save your result:", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let fNameField = alertController.textFields![0] as UITextField
            if fNameField.text != "" {
                segueData.userName = fNameField.text!
                print(segueData.userName)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "Please input both a first AND last name", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "name"
            textField.textAlignment = .center
        })
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}

//Mark: sending data in records
var segueData = (timer:0, flips:0, level:0, userName:"user")
func prepare(for segue: UIStoryboardSegue, sender: Any?){
    let recordsSegue = segue.destination as! RecordsViewController
    recordsSegue.variablesForData = segueData as! (time: Int, flips: Int, level: Int, gamerName: String)
}
var prefersStatusBarHidden: Bool{
    return true
}

