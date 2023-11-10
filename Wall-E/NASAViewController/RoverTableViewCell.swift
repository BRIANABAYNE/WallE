//
//  RoverTableViewCell.swift
//  Wall-E
//
//  Created by Briana Bayne on 6/30/23.
//

import UIKit

class RoverTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var roverNameLabel: UILabel!
    @IBOutlet weak var roverImageView: UIImageView!
    @IBOutlet weak var roverCameraName: UILabel!
    
    // MARK: - Properties
    var rover: Rover?
   
    // MARK: - Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: - Functions
    func updateView() {
        guard let rover = rover else { return }
        NetworkController.fetchRoverImage(rover: rover) { image in
        guard let image = image else { return }
            DispatchQueue.main.async {
                self.roverImageView.image = image // self is this file.
                self.roverNameLabel.text = rover.roverName
                self.roverCameraName.text = rover.cameraName
            }
        }
    }
    
}
