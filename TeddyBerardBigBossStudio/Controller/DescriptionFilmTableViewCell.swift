//
//  DescriptionFilmTableViewCell.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 30/07/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import UIKit

class DescriptionFilmTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var personnageLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        synopsisLabel.numberOfLines = 0
        personnageLabel.numberOfLines = 0
        producerLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
