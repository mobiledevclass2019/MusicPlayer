//
//  AlbumVC.swift
//  MusicPlayer2
//
//  Created by 李超逸 on 2020/01/12.
//  Copyright © 2020 李超逸. All rights reserved.
//

import UIKit

class AlbumVC: UITableViewController {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var album: Album!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = album.name
        artistLabel.text = album.artist
        timeLabel.text = album.publish
        coverImageView.image = UIImage(named: album.cover)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return album.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let song = album.songs[indexPath.row]
        cell.textLabel?.text = song.name
        return cell
    }

}
