
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var timeLable: UILabel!
    
    @IBOutlet weak var countFlipLabel: UILabel!
    
    public func setUpCell(name:String,level:Int,time:Int,flipCount:Int ){
        nameLable.text = name
        levelLabel.text = String(level)
        timeLable.text = String(time)
        countFlipLabel.text = String(flipCount)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
