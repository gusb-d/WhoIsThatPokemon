//
//  ResultViewController.swift
//  WhoIsThatPKMN
//
//  Created by Gus Munguia on 26/04/23.
//

import UIKit
import Kingfisher

class ResultViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var finalScore: UILabel!
    
    @IBOutlet weak var afirmationLabel: UILabel!
    
    var pokemonName:String = ""
    var pokemonImageURL:String = ""
    var finalScoreVar:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        finalScore.text = "Loser! Your score is \(finalScoreVar)"
        afirmationLabel.text = "No, it´s \(pokemonName)"
        pokemonImage.kf.setImage(with: URL(string: pokemonImageURL))
    }
    
    
    @IBAction func playAgain(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
     
     }*/
}
