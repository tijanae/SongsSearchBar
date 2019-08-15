//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    MARK -- Outlets
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
//    MARK -- Data Source
    let songs = Song.loveSongs
    var songSearchString: String? = nil {
        didSet{
            print(songSearchString)
            self.tableView.reloadData()
        }
    }
    
    var userRequestedSearch: [Song] {
        guard let searchedString = songSearchString else{
            return songs
        }
        guard searchedString != "" else{
            return songs
        }
        
        if let scopeTitles = searchBarOutlet.scopeButtonTitles {
            let currentScopeIndex = searchBarOutlet.selectedScopeButtonIndex
            switch scopeTitles[currentScopeIndex] {
            case "song title":
//                filtered all the name letters in the database to lowercased to be equal the letters in SongSearchString
                return songs.filter{$0.name.lowercased().contains(searchedString.lowercased())}
            case "artist name":
                return songs.filter{$0.artist.lowercased().contains(searchedString.lowercased())}
            default:
                return songs.filter{$0.name.contains(searchedString.lowercased()) || $0.artist.contains(searchedString.lowercased())}
            }
        }
        return songs
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        searchBarOutlet.delegate = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier else{
            fatalError("No identifier in segue")
        }
        
        
        switch segueIdentifier {
        case "mainCellsToDetailSegue":
            guard let songDetailsVC = segue.destination as? songDetailsViewController else {
                fatalError("Unexpected error: no VC")
            }
            guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else{
                fatalError("No row selected")
            }
            songDetailsVC.song = songs[selectedIndexPath.row]
            
        default:
            fatalError("Unexpected Identifier")
        }
        
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRequestedSearch.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = userRequestedSearch[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
            cell.textLabel?.text = song.name
            cell.detailTextLabel?.text = song.artist
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        songSearchString = searchBar.text
    }
}
