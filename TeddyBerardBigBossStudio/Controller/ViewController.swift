//
//  ViewController.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 30/07/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filtreLabel: UILabel!
    
    var myMovies = AllMovie()
    var countMovie = 0
    var filtre = false

    override func viewDidLoad() {
        super.viewDidLoad()

        getNotif()
        getData()
        customTableView()
    }
    
    func getNotif() {
        let name = Notification.Name(rawValue: "movieDonwload")
        NotificationCenter.default.addObserver(
        self, selector: #selector(reloadViewWhenMovieDownloaded),
        name: name, object: nil)
    }
    
    @objc func reloadViewWhenMovieDownloaded() {
        self.filtreByStory()
        countMovie += 1
        tableView.reloadData()
    }

    func customTableView() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countMovie
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as!
        FilmTableViewCell

        let film = myMovies.results[indexPath.row]

        let id = film.episode_id

        cell.titleLabel.text = film.title.uppercased()
        cell.episodeLabel.text = "ÉPISODE \(id)"
        cell.producerLabel.text = film.director
        cell.yearsLabel.text = String(film.release_date.prefix(4))
        cell.coverImg.image = UIImage(named: "episode_\(id)")
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.nextView(id: indexPath.row)
    }

    @IBAction func filtreAction(_ sender: Any) {
        if filtre == false {
            filtreByRelease()
            filtre = true
            filtreLabel.text = "Dans l'ordre chronologique"
        } else {
            filtreByStory()
            filtre = false
            filtreLabel.text = "Dans l’ordre de l’histoire"
        }
        tableView.reloadData()
    }

    func filtreByRelease() {
        self.myMovies.results.sort(by: { $0.release_date < $1.release_date })
    }

    func filtreByStory() {
        self.myMovies.results.sort(by: { $0.episode_id < $1.episode_id })
    }

    func getData() {
        Alamofire.request("https://swapi.co/api/films/?format=json").responseJSON { response in
            let jsonResult = JSON(response.data!)
            self.myMovies.setMovies(json: jsonResult)
        }
    }
    
    

    func nextView(id: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FilmViewController")
            as! FilmViewController
        newViewController.myFilm = myMovies.results[id]
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
