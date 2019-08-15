//
//  songDetailsViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Tia Lendor on 8/15/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class songDetailsViewController: UIViewController {

    var song: Song!
    
    @IBOutlet weak var songImage: UIImageView!
    
    @IBOutlet weak var songTitleLabel: UILabel!
    
    @IBOutlet weak var songArtistLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songImage.image = UIImage(named: "loveSongs")
        songTitleLabel.text = song.name
        songArtistLabel.text = song.artist

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
