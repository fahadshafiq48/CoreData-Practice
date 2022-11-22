//
//  RemminderCVC.swift
//  Fahad Test
//
//  Created by Mac on 21/11/2022.
//

import UIKit
import SDWebImage

protocol RemminderCVCDelegate: AnyObject {
    func playBtnPressed(for cell: UICollectionViewCell)
}

class ReminderCVC: UICollectionViewCell {
    
    weak var delegate: RemminderCVCDelegate?

    @IBOutlet weak var myIMG: UIImageView!
    @IBOutlet weak var playBTN: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func playBtnPressed(_ sender: UIButton) {
        delegate?.playBtnPressed(for: self)
    }
    
    func setContent(item: ListModel) {
        //TODO: Hide play button based on centred cell
//        playBTN.isHidden = item.isCentred ? false : true
        
        if let img = item.imageURL, let imgURL = URL(string: img) {
            myIMG.sd_setImage(with: imgURL, placeholderImage: UIImage(named: "imagePlaceholder"))
        }
    }
}
