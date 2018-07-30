//
//  FilmViewController.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 30/07/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var myFilm: film?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customTableView()
        self.navigationController?.navigationBar.tintColor = UIColor.white

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionFilmTableViewCell", for: indexPath) as!
        DescriptionFilmTableViewCell
        cell.selectionStyle = .none

        if myFilm?.episode_id == 7 {
            cell.productionLabel.text = "The Walt Disney Company"
        }

        cell.episodeLabel.text = "ÉPISODE \(String(myFilm?.episode_id ?? 0))"
        cell.titleLabel.text = myFilm?.title.uppercased()
        cell.producerLabel.text = "Réalisé par \((myFilm?.director)!)"
        cell.coverImg.image = UIImage(named: "episode_\((myFilm?.episode_id ?? 0))")
        let date = releaseDate(date: (myFilm?.release_date)!)
        cell.releaseLabel.text = "Sorti le \(date)"
        let synopsis = myFilm?.opening_crawl.replacingOccurrences(of: "\r\n", with: " ")

        cell.synopsisLabel.text = synopsis

        setSpacing(label: cell.synopsisLabel)
        setSpacing(label: cell.producerLabel)
        setSpacing(label: cell.personnageLabel)

        cell.personnageLabel.text = allPersonnage()

        return cell
    }

    func setSpacing(label: UILabel) {
        let attr = NSMutableAttributedString(string: label.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attr.length))
        label.attributedText = attr
    }

    func releaseDate(date: String) -> String {
        let years = String(date.prefix(4))
        let day = String(date.suffix(2))
        var month = String(date.prefix(7))
        month = String(month.suffix(2))
        var monthNumber = 01
        monthNumber = Int(month)!
        let dateFormatter = DateFormatter()
        let monthName = dateFormatter.monthSymbols[monthNumber - 1]
        return "\(day) \(monthName) \(years)"
    }

    func allPersonnage() -> String {
        var Arr = [String]()
        for perso in (myFilm?.personnages)! {
            Arr.append(perso.name)
        }
        return Arr.joined(separator: ", ")
    }

    func customTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }
}
