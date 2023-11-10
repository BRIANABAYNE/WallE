//
//  Rover.swift
//  Wall-E
//
//  Created by Briana Bayne on 6/18/23.
//

import Foundation

class Rover {
    
    var cameraName: String
    var roverName: String
    var earthDate: String
    var imageURL: String

    init( cameraName: String, roverName: String, earthDate: String, imageURL: String) {
        self.cameraName = cameraName
        self.roverName = roverName
        self.earthDate = earthDate
        self.imageURL = imageURL
    }
}

// MARK: - Extension

extension Rover {
    convenience init?(photosDictonary: [String:Any])  {
        guard let cameraDict = photosDictonary["camera"] as? [String:Any],
              let cameraName = cameraDict["full_name"] as? String,
              let roverDict = photosDictonary["rover"] as? [String:Any],
              let roverName = roverDict["name"] as? String,
              let imageURL = photosDictonary["img_src"] as? String,
              let earthDate = photosDictonary["earth_date"] as? String else {return nil}
        
        self.init( cameraName: cameraName, roverName: roverName, earthDate: earthDate, imageURL: imageURL)
    }
}
