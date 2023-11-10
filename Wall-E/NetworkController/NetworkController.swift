//
//  NetworkController.swift
//  Wall-E
//
//  Created by Briana Bayne on 6/17/23.
//

import UIKit

struct NetworkController {
    
    func fetchRover(with searchTerm: String, completion: @escaping ([Rover]?) -> Void) {
        
        guard let baseURL = URL(string:"https://api.nasa.gov/mars-photos/api/v1/" ) else {return}
        let spaceURL = baseURL.appending(path:"rovers/curiosity/photos") // componets
        var urlComponets = URLComponents(url: spaceURL, resolvingAgainstBaseURL: true)
        let apiQueryItem = URLQueryItem(name: "earth_date", value: searchTerm)
        let apitQueryItemsOne = URLQueryItem(name: "api_key", value: "QCQVVllUGeAXP776pfgJy5eCvFGw5lJoJlIKl5cF")
        urlComponets?.queryItems = [apiQueryItem, apitQueryItemsOne]
        guard let finalURL = urlComponets?.url else {return}
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error {
                print(" Oh no! Something went wrong", error.localizedDescription)
                completion(nil)
            }
            
            guard let spaceData = data
            
            else {
                print("There was an error checking for Data.")
                completion(nil)
                return
            }
            do {
                
                guard let topLevelDictionary = try JSONSerialization.jsonObject(with: spaceData) as? [String:Any]
                else {completion(nil); return }
                guard let photos = topLevelDictionary["photos"] as? [[String:Any]] else { return }
                var roverArray:[Rover] = []
                for photosDict in photos {
                    
                    guard let rover = Rover(photosDictonary:photosDict) else { return }
                    roverArray.append(rover)
                }
                completion(roverArray)
                
            } catch {
                completion(nil); return
            }
            
        }.resume()
    }
    
    // MARK: - Second Fetch
    
    static func fetchRoverImage(rover: Rover, completion: @escaping(UIImage?) -> Void) {
        
        guard let roverURL = URL(string: rover.imageURL) else
        {completion(nil); return }
        
        URLSession.shared.dataTask(with: roverURL) { data, _, error in
            
            if let error {
                print("Error fetching Image!", error.localizedDescription)
                completion(nil)
            }
            
            guard let imageData = data else {completion(nil); return }
            let imageURL = UIImage(data: imageData)
            completion(imageURL)
        }.resume()
    }
}
