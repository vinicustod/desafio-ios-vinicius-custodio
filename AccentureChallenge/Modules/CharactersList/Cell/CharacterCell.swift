//
//  CharacterCell.swift
//  AccentureChallenge
//
//  Created by Vinicius Custodio on 26/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterAvatarImageView: UIImageView! {
        didSet {
            characterAvatarImageView.layer.cornerRadius = 30
        }
    }

    var character: CharactersList.LoadPage.ViewModel.DisplayableCharacter? {
        didSet {
            characterNameLabel.text = character?.name
            setImage(character!.avatarURL)
        }
    }

    private var dataTask: URLSessionDataTask?
    func setImage(_ imageURL: URL) {
        characterAvatarImageView.image = nil
        dataTask?.cancel()

        dataTask = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                let image = UIImage(data: data)

                DispatchQueue.main.async {
                    self.characterAvatarImageView.image = image
                }
            }
        })

        dataTask?.resume()
    }

}
