//
//  ViewController.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 30/07/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filtreLabel: UILabel!
    
    var myFilms: allFilms = allFilms(count: 0, results: [film]())
    var filtre = false

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        customTableView()
    }

    func customTableView() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myFilms.count == 0 {
            return 0
        }
        return myFilms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as!
        FilmTableViewCell

        let film = myFilms.results[indexPath.row]

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
        self.myFilms.results.sort(by: { $0.release_date < $1.release_date })
    }

    func filtreByStory() {
        self.myFilms.results.sort(by: { $0.episode_id < $1.episode_id })
    }

    func getData() {
        let urlJson = "https://swapi.co/api/films/?format=json"
        guard let url = URL(string: urlJson) else { return  }

        URLSession.shared.dataTask(with: url) { (data, _, err) in
            guard let data = data else {
                print("Error download")
                return }
            do {
                let films = try JSONDecoder().decode(allFilms.self, from: data)
                self.myFilms = films
                self.filtreByStory()
                DispatchQueue.main.async {
                    for id in 0..<self.myFilms.results.count {
                        self.donwloadPersonnages(id: id)
                    }
                    self.tableView.reloadData()
                }
            } catch let err {
                print("some errors =\(err)")
            }
        }.resume()
    }

    func donwloadPersonnages(id: Int) {
        self.myFilms.results[id].personnages = [personnage]()
        for urlJson in myFilms.results[id].characters {
            guard let url = URL(string: urlJson) else { return  }
            URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard let data = data else {
                    print("Error download")
                    return }
                do {
                    let perso = try JSONDecoder().decode(personnage.self, from: data)
                    DispatchQueue.main.async {
                        self.myFilms.results[id].personnages?.append(perso)
                    }
                } catch let err {
                    print("some errors =\(err)")
                }
            }.resume()
        }
    }

    func nextView(id: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FilmViewController")
            as! FilmViewController
        newViewController.myFilm = myFilms.results[id]
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
