//
//  ViewController.swift
//  WhoIsThatPKMN
//
//  Created by Gus Munguia on 13/04/23.
//

import UIKit
import Kingfisher


class PokemonViewController: UIViewController{
    
    
    @IBOutlet weak var shadowPokemonImage:UIImageView!
    @IBOutlet weak var scoreLabel:UILabel!
    @IBOutlet weak var pokemonAffirmationLabel:UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    //   lazy allows execution only in the right moment. Not before not after
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    lazy var game = GameModel()
    var random4Pokemons:[PokemonModel] = [] {
        
        didSet{
            setButtonTitles()
        }
        
    }
    var correctAnswer:String=""
    var correctAnswerImage:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pokemonManager.delegate = self
        imageManager.delegate = self
        print(game.getScore())
     CustomAnswerButtons()
    pokemonManager.fetchPokemon()
        pokemonAffirmationLabel.text = ""
    
    }
    
    
    
    @IBAction func buttonPressed(_ sender:UIButton){
        
        let userAnswer = sender.title(for: .normal)!
        
        
        if game.checkAnswer(userAnswer, correctAnswer){
            pokemonAffirmationLabel.text = "Yes, it´s one \(userAnswer.capitalized)"
            scoreLabel.text = "Score: \(game.score)"
            
            sender.layer.borderColor = UIColor(red:41.0/255.0,green: 191.0/255.0,blue: 18.0/255.0,alpha: 1.0).cgColor
            
            sender.layer.borderWidth = 2
            
            
            let url = URL(string: correctAnswerImage)
            shadowPokemonImage.kf.setImage(with: url)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
                
                self.pokemonManager.fetchPokemon()
                
                sender.layer.borderWidth = 0
                
                self.pokemonAffirmationLabel.text = ""
                
                
                
            }
            
            
        }
        else{
//            pokemonAffirmationLabel.text = "No, it´s one \(correctAnswer.capitalized)"
//            sender.layer.borderColor = UIColor.systemRed.cgColor
//            sender.layer.borderWidth = 2
//            let url = URL(string: correctAnswerImage)
//            shadowPokemonImage.kf.setImage(with: url)
//
//
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
//
//                self.resetGame()
//                sender.layer.borderWidth = 0
//
//
//
//            }
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "goToResult"{
            let destination = segue.destination as! ResultViewController
            destination.pokemonName = correctAnswer
            destination.pokemonImageURL = correctAnswerImage
            destination.finalScoreVar = game.score
            resetGame()
        }
        
    }
    
    
    func resetGame(){
        self.pokemonManager.fetchPokemon()
        game.setScore(score: 0)
        scoreLabel.text = "Puntaje \(game.score)"
    }
    
    
    func CustomAnswerButtons(){
        
        for button in answerButtons{
            
            button.layer.cornerRadius = 10.0
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            
        }
      
        
    }
    
    
    func setButtonTitles(){
        
        for (index , button) in answerButtons.enumerated(){
            DispatchQueue.main.async {[self] in
                button.setTitle(random4Pokemons[safe: index]?.name.capitalized, for: .normal)
            }
        }
    }
    

}

extension PokemonViewController:PokemonManagerDelegate{
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        
        random4Pokemons =  pokemons.choose(4)
        let index = Int.random(in: 0...3)
        
        let imageData = random4Pokemons[index].imageUrl
       
        correctAnswer = random4Pokemons[index].name
        
        
        imageManager.fetchImage(url:imageData)
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
    
}

extension PokemonViewController:ImageManagerDelegate{
    func didUpdateImage(image: ImageModel) {
        correctAnswerImage = image.pokemonImage
        
        DispatchQueue.main.async {[self] in
            let url = URL(string:image.pokemonImage)
            let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
            
            shadowPokemonImage.kf.setImage(with: url,options: [.processor(effect)])
        }
    }
    
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
    
    
}


extension Collection where Indices.Iterator.Element == Index{
    
    
    public subscript(safe index:Index)->Iterator.Element?{
        return(startIndex<=index && index<endIndex) ? self[index] : nil
    }
    
}


extension Collection{
    func choose(_ n:Int)->Array<Element>{
        Array(shuffled().prefix(n))
    }
}
