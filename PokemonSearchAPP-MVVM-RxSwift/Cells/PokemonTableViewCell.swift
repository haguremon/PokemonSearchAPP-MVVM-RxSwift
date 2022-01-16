//
//  PokemonTableViewCell.swift
//  PokemonSearchAPP-MVVM-RxSwift
//
//  Created by IwasakIYuta on 2022/01/16.
//

import UIKit
import SDWebImage

class PokemonTableViewCell: UITableViewCell {

   @IBOutlet weak var imagenmaeLabel: UILabel!
    
   @IBOutlet weak var typeLabel: UILabel!
    
   @IBOutlet weak var searchImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
 
}
