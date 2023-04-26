//
//  ImageManager.swift
//  WhoIsThatPKMN
//
//  Created by Gus Munguia on 19/04/23.
//

import Foundation

protocol ImageManagerDelegate{
    
    func didUpdateImage(image:ImageModel)
    func didFailWithErrorImage(error:Error)
    
}



struct ImageManager{

    var delegate:ImageManagerDelegate?
    
    func fetchImage(url:String){
           
        preformRequest(with: url)
        
    }
    
    
    private func preformRequest(with urlString:String){
        //        1.- Create/get url
        //        if let helps to avoid errors on the code
        if let url = URL(string: urlString){
            //        2.- Create URL Session
           
            let session = URLSession(configuration: .default)
            //            3.- Give the session a task
            let task = session.dataTask(with: url){data,response,error in
                
                if error != nil{
                    self.delegate?.didFailWithErrorImage(error: error!)
                    
                }
                else{
                    
                    if let safeData = data{
                     
                        
                        if let image = self.parseJSON(imageData:safeData){
                            
                            
                            self.delegate?.didUpdateImage(image: image)
                            
                        }
                        
                        
                        
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
    }
    
    
    
    
     private func parseJSON(imageData:Data) ->ImageModel?{
        let decoder = JSONDecoder()
        
        do{
            
            let decodeData = try decoder.decode(ImageData.self, from: imageData)
        
            let image = decodeData.sprites?.other?.officialArtwork?.frontDefault ?? "Hola"
            return ImageModel(pokemonImage:image)
            
        }catch{
            return nil
        }
    }
}
