//
//  MusicViewController.swift
//  MusicPlayer2
//
//  Created by 李超逸 on 2019/12/08.
//  Copyright © 2019 李超逸. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var fileData: FileRoot? {
        didSet {
            collectionView?.reloadSections([2])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "albums", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                fileData = try decoder.decode(FileRoot.self, from: data)
            } catch {
                print("parse error")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushAlbum" {
            guard let destination = segue.destination as? AlbumVC else { return }
            guard let album = sender as? Album else { return }
            destination.album = album
        }
    }
}

extension MusicViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 4
        } else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promotionCell", for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath)
            if let cell = cell as? ButtonCell,
                let cellType = ButtonCell.ButtonType(rawValue: indexPath.row) {
                cell.type = cellType
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
            if let data = fileData?.albums[indexPath.row] {
                cell.imageView.image = UIImage(named: data.cover)
                cell.label.text = data.name
            }
            return cell
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            if let data = fileData?.albums[indexPath.row] {
                performSegue(withIdentifier: "pushAlbum", sender: data)
            }
        default:
            break
        }
    }
}

extension MusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        if indexPath.section == 0 {
            let ratio = CGFloat(170) / CGFloat(740)
            return CGSize(width: screenWidth, height: screenWidth * ratio)
        } else if indexPath.section == 1 {
            let width = (screenWidth - 30.0) / 4.0
            return CGSize(width: width, height: width)
        } else {
            let width = (screenWidth - 21.0) / 3.0
            return CGSize(width: width, height: width)
        }
    }
}
