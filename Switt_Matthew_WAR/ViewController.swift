//
//  ViewController.swift
//  Switt_Matthew_WAR
//
//  Created by Matthew Switt on 2019-04-14.
//  Copyright © 2019 Matthew Switt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //shuffle function is called, deck image is nothing and outlets and labels are hidden
        shuffle()
        flipOutlet.isHidden = true
        resetOutlet.isHidden = true
        warOutlet.isHidden = true
        deckImage.image = nil
        player1ScoreLabel.isHidden = true
        player2ScoreLabel.isHidden = true
        player1ValueLabel.isHidden = true
        player2ValueLabel.isHidden = true
        
    }

    //all my outlets/outlet collections
    @IBOutlet weak var deckImage: UIImageView!
    @IBOutlet weak var player1Card: UIImageView!
    @IBOutlet weak var player2Card: UIImageView!
    @IBOutlet weak var flipOutlet: UIButton!
    @IBOutlet weak var resetOutlet: UIButton!
    @IBOutlet weak var startOutlet: UIButton!
    @IBOutlet weak var warOutlet: UIButton!
    @IBOutlet var player1WarCards: [UIImageView]!
    @IBOutlet var player2WarCards: [UIImageView]!
    @IBOutlet var player1WarCardsV2: [UIImageView]!
    @IBOutlet var player2WarCardsV2: [UIImageView]!
    @IBOutlet weak var player1WarCardsV3: UIImageView!
    @IBOutlet weak var player2WarCardsV3: UIImageView!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var player1Value1: UILabel!
    @IBOutlet weak var player2Value1: UILabel!
    @IBOutlet weak var player1ValueLabel: UILabel!
    @IBOutlet weak var player2ValueLabel: UILabel!
    
    //declaration of global variables, an empty array, and a dictionary containing images of all the cards and their values
    var cardDeck: [UIImage:Int] = [#imageLiteral(resourceName: "2H"):2, #imageLiteral(resourceName: "2D"):2, #imageLiteral(resourceName: "2S"):2, #imageLiteral(resourceName: "2C"):2, #imageLiteral(resourceName: "3H"):3, #imageLiteral(resourceName: "3D"):3, #imageLiteral(resourceName: "3S"):3, #imageLiteral(resourceName: "3C"):3, #imageLiteral(resourceName: "4H"):4, #imageLiteral(resourceName: "4D"):4, #imageLiteral(resourceName: "4S"):4, #imageLiteral(resourceName: "4C"):4, #imageLiteral(resourceName: "5H"):5, #imageLiteral(resourceName: "5D"):5, #imageLiteral(resourceName: "5S"):5, #imageLiteral(resourceName: "5C"):5, #imageLiteral(resourceName: "6H"):6, #imageLiteral(resourceName: "6D"):6, #imageLiteral(resourceName: "6S"):6, #imageLiteral(resourceName: "6C"):6, #imageLiteral(resourceName: "7H"):7, #imageLiteral(resourceName: "7D"):7, #imageLiteral(resourceName: "7S"):7, #imageLiteral(resourceName: "7C"):7, #imageLiteral(resourceName: "8H"):8, #imageLiteral(resourceName: "8D"):8, #imageLiteral(resourceName: "8S"):8, #imageLiteral(resourceName: "8C"):8, #imageLiteral(resourceName: "9H"):9, #imageLiteral(resourceName: "9D"):9, #imageLiteral(resourceName: "9S"):9, #imageLiteral(resourceName: "9C"):9, #imageLiteral(resourceName: "10H"):10, #imageLiteral(resourceName: "10D"):10, #imageLiteral(resourceName: "10S"):10, #imageLiteral(resourceName: "10C"):10, #imageLiteral(resourceName: "JH"):11, #imageLiteral(resourceName: "JD"):11, #imageLiteral(resourceName: "JS"):11, #imageLiteral(resourceName: "JC"):11, #imageLiteral(resourceName: "QH"):12, #imageLiteral(resourceName: "QD"):12, #imageLiteral(resourceName: "QS"):12, #imageLiteral(resourceName: "QC"):12, #imageLiteral(resourceName: "KH"):13, #imageLiteral(resourceName: "KD"):13, #imageLiteral(resourceName: "KS"):13, #imageLiteral(resourceName: "KC"):13, #imageLiteral(resourceName: "AH"):14, #imageLiteral(resourceName: "AD"):14, #imageLiteral(resourceName: "AS"):14, #imageLiteral(resourceName: "AC"):14]
    var shuffledDeck : [UIImage] = []
    var score1 = 0
    var score2 = 0
    var player1WarValue = 0
    var player2WarValue = 0
    
    //shuffle function, takes the images from my dictionary, generates a random number from 1 - the number of cards in my deck, and based on the number generated, it will take the image at that index and add it to my empty array and then remove it from the array of cards
    func shuffle() {
        var cardImages = Array(cardDeck.keys)
        while cardImages.count > 0 {
            var randomNumber = Int.random(in: 0...cardImages.count - 1)
            shuffledDeck.append(cardImages[randomNumber])
            cardImages.remove(at: randomNumber)
        }
    }
    
    //animation for player one's cards and their war cards
    func animation1() {
        UIView.transition(with: player1Card, duration: 0.7, options: .transitionFlipFromTop, animations: nil, completion: nil)
        for transition in player1WarCards{
            UIView.transition(with: transition, duration: 0.7, options: .transitionFlipFromTop, animations: nil
                , completion: nil
            )
        }
    }
    
    //animation for player two's cards and their war cards
    func animation2() {
        UIView.transition(with: player2Card, duration: 0.7, options: .transitionFlipFromBottom, animations: nil
            , completion: nil)
        for transition2 in player2WarCards{
            UIView.transition(with: transition2, duration: 0.7, options: .transitionFlipFromBottom, animations: nil
                , completion: nil)
        }
    }
    
    //remove the cards that were used in war when the flip button is pressed
    func removeImages() {
        for items in player1WarCards {
            items.image = nil
        }
        for items in player2WarCards {
            items.image = nil
        }
    }
    
    //when the war can have six cards, display three cards on each player's sides,  then the value of each card displayed was obtained and added up and the total value of each player's war cards were displayed, the war button is hidden and the flip button is shown
    func warSixCardsLeft() {
        for images in player1WarCards{
            images.image = shuffledDeck.first
            shuffledDeck.removeFirst()
            animation1()
        }
        for valueOfCards in player1WarCards{
            var value = cardDeck[valueOfCards.image!]
            player1WarValue += value!
            player1Value1.text = String(player1WarValue)
        }
        for images in player2WarCards{
            images.image = shuffledDeck.first
            shuffledDeck.removeFirst()
            animation2()
        }
        for valueOfCards in player2WarCards{
            var value = cardDeck[valueOfCards.image!]
            player2WarValue += value!
            player2Value1.text = String(player2WarValue)
        }
        //function determining who wins is called and war outlet is displayed, flip outlet is hidden
        whoWins()
        warOutlet.isHidden = true
        flipOutlet.isHidden = false
    }
    
    
    func whoWins(){
        //if player 1's war value is greater than player 2's war value, add 2 to player 1's score, display their score and reset each player's war values
        if player1WarValue > player2WarValue {
            score1 += 2
            player1Score.text = String(score1)
            player1WarValue = 0
            player2WarValue = 0
        //if player 2's war value is greater than player 1's war value, add 2 to player 2's score, display their score and reset each player's war values
        } else if player2WarValue > player1WarValue {
            score2 += 2
            player2Score.text = String(score2)
            player1WarValue = 0
            player2WarValue = 0
        //if player 1's war value equals player 2's war value, add one to each pof their scores, display their current score and reset each player's war values
        } else {
            score1 += 1
            score2 += 1
            player1Score.text = String(score1)
            player2Score.text = String(score2)
            player1WarValue = 0
            player2WarValue = 0
        }
    }
    
    //deck image is set to empty, flip and war button are hidden, reset button is displayed and an alert pops up
    func endGame ()  {
        flipOutlet.isHidden = true
        resetOutlet.isHidden = false
        warOutlet.isHidden = true
        deckImage.image = nil
        let alert = UIAlertController(title: "Game Over", message: "Player One got a total score of \(score1) and Player Two got a total score of \(score2).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
    @IBAction func startAction(_ sender: UIButton) {
        //deck of cards is dispalyed using an animation
        UIView.transition(with: deckImage, duration: 1.0, options: .transitionCrossDissolve, animations: nil, completion: nil)
        //outlets and labels are shown except for the start outlet which is hidden, and the deck image is a deck of cards
        flipOutlet.isHidden = false
        startOutlet.isHidden = true
        deckImage.image = #imageLiteral(resourceName: "card back red.png")
        player1ScoreLabel.isHidden = false
        player2ScoreLabel.isHidden = false
        player1ValueLabel.isHidden = false
        player2ValueLabel.isHidden = false
        player1Score.text = "0"
        player2Score.text = "0"
    }
    
    @IBAction func flipAction(_ sender: UIButton) {
        
        //takes the first card from the shuffled array, displays it on player 1's side using the animation and then removes it from the array
        player1Card.image = shuffledDeck.removeFirst()
        animation1()
        
        //takes the first card from the shuffled array, displays it on player 2's side using the animation and then removes it from the array
        player2Card.image = shuffledDeck.removeFirst()
        animation2()
        
        //gets the values of each player's cards
        var player1Value = cardDeck[player1Card.image!]!
        var player2Value = cardDeck[player2Card.image!]!
        
        //if player 1's card value is greater than player 2's card value, add two to their score and display it as well as each player's card value and then remove cards if war just happened
        if player1Value > player2Value {
            score1 += 2
            player1Score.text = String(score1)
            player1Value1.text = String(player1Value)
            player2Value1.text = String(player2Value)
            removeImages()
            //if player 2's card value is greater than player 1's card value, add two to their score and display it as well as each player's card value and then remove cards if war just happened
        } else if player2Value > player1Value {
            score2 += 2
            player2Score.text = String(score2)
            player1Value1.text = String(player1Value)
            player2Value1.text = String(player2Value)
            removeImages()
            //if war occurs and their are no cards left, add one to each player's score, display their score and the value of each card and then end the game
        } else if player1Value == player2Value && shuffledDeck.count == 0 {
            player1Value1.text = String(player1Value)
            player2Value1.text = String(player2Value)
            score1 += 1
            player1Score.text = String(score1)
            score2 += 1
            player2Score.text = String(score2)
            endGame()
            //war occurs, display each player's card value, remove cards if war just happened, flip button dissappears and war button appears
        } else {
            player1Value1.text = String(player1Value)
            player2Value1.text = String(player2Value)
            removeImages()
            flipOutlet.isHidden = true
            warOutlet.isHidden = false
        }
        
        //if there are no cards left, end game
        if shuffledDeck.count == 0{
            endGame()
        }
    }
    
    @IBAction func warAction(_ sender: UIButton) {
        
        //remove each player's card
        player1Card.image = nil
        player2Card.image = nil
        
        //if the shuffled deck has 6 or more cards, the warSixCardsLeft function is called
        if shuffledDeck.count > 6{
            warSixCardsLeft()
        //if the shuffled deck has 6 cards, the warSixCardsLeft function is called and the game is ended
        } else if shuffledDeck.count == 6 {
            warSixCardsLeft()
            endGame()
        //when the war only has 4 cards to work with, display two cards on each player's sides, then the value of each card displayed was obtained and added up and the total value of each player's war cards were displayed
        } else if shuffledDeck.count == 4{
            for images in player1WarCardsV2{
                images.image = shuffledDeck.first
                shuffledDeck.removeFirst()
                animation1()
            }
            for images in player2WarCardsV2{
                images.image = shuffledDeck.first
                shuffledDeck.removeFirst()
                animation2()
            }
            for valueOfCards in player1WarCardsV2{
                var value = cardDeck[valueOfCards.image!]
                player1WarValue += value!
                player1Value1.text = String(player1WarValue)
            }
            for valueOfCards in player2WarCardsV2{
                var value = cardDeck[valueOfCards.image!]
                player2WarValue += value!
                player2Value1.text = String(player2WarValue)
            }
            //function determining who wins is called, the game is then ended and the war button disappears
            whoWins()
            endGame()
            warOutlet.isHidden = true
        //when the war can only use 2 cards, display one on each player's sides, then the value of each card displayed was obtained and added up and the total value of each player's war cards were displayed
        } else if shuffledDeck.count == 2 {
            player1WarCardsV3.image = shuffledDeck.first
            shuffledDeck.removeFirst()
            animation1()
            var value1 = cardDeck[player1WarCardsV3.image!]!
            player1WarValue = value1
            player1Value1.text = String(player1WarValue)
            player2WarCardsV3.image = shuffledDeck.first
            shuffledDeck.removeFirst()
            animation2()
            var value2 = cardDeck[player2WarCardsV3.image!]!
            player2WarValue = value2
            player2Value1.text = String(player2WarValue)
            //function determining who wins is called and the game is then ended and the war button disappears
            whoWins()
            endGame()
            warOutlet.isHidden = true
        }
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        //war card images are set to nil
        for items in player1WarCards {
            items.image = nil
        }
        for items in player2WarCards {
            items.image = nil
        }
        //dictionary is reset conatining the card's images and their values
        cardDeck = [#imageLiteral(resourceName: "2H"):2, #imageLiteral(resourceName: "2D"):2, #imageLiteral(resourceName: "2S"):2, #imageLiteral(resourceName: "2C"):2, #imageLiteral(resourceName: "3H"):3, #imageLiteral(resourceName: "3D"):3, #imageLiteral(resourceName: "3S"):3, #imageLiteral(resourceName: "3C"):3, #imageLiteral(resourceName: "4H"):4, #imageLiteral(resourceName: "4D"):4, #imageLiteral(resourceName: "4S"):4, #imageLiteral(resourceName: "4C"):4, #imageLiteral(resourceName: "5H"):5, #imageLiteral(resourceName: "5D"):5, #imageLiteral(resourceName: "5S"):5, #imageLiteral(resourceName: "5C"):5, #imageLiteral(resourceName: "6H"):6, #imageLiteral(resourceName: "6D"):6, #imageLiteral(resourceName: "6S"):6, #imageLiteral(resourceName: "6C"):6, #imageLiteral(resourceName: "7H"):7, #imageLiteral(resourceName: "7D"):7, #imageLiteral(resourceName: "7S"):7, #imageLiteral(resourceName: "7C"):7, #imageLiteral(resourceName: "8H"):8, #imageLiteral(resourceName: "8D"):8, #imageLiteral(resourceName: "8S"):8, #imageLiteral(resourceName: "8C"):8, #imageLiteral(resourceName: "9H"):9, #imageLiteral(resourceName: "9D"):9, #imageLiteral(resourceName: "9S"):9, #imageLiteral(resourceName: "9C"):9, #imageLiteral(resourceName: "10H"):10, #imageLiteral(resourceName: "10D"):10, #imageLiteral(resourceName: "10S"):10, #imageLiteral(resourceName: "10C"):10, #imageLiteral(resourceName: "JH"):11, #imageLiteral(resourceName: "JD"):11, #imageLiteral(resourceName: "JS"):11, #imageLiteral(resourceName: "JC"):11, #imageLiteral(resourceName: "QH"):12, #imageLiteral(resourceName: "QD"):12, #imageLiteral(resourceName: "QS"):12, #imageLiteral(resourceName: "QC"):12, #imageLiteral(resourceName: "KH"):13, #imageLiteral(resourceName: "KD"):13, #imageLiteral(resourceName: "KS"):13, #imageLiteral(resourceName: "KC"):13, #imageLiteral(resourceName: "AH"):14, #imageLiteral(resourceName: "AD"):14, #imageLiteral(resourceName: "AS"):14, #imageLiteral(resourceName: "AC"):14]
        //shuffled deck array is emptied
        shuffledDeck = []
        //global variables are reset
        score1 = 0
        score2 = 0
        player1WarValue = 0
        player2WarValue = 0
        //all images are reset, all labels are empty and all buttons are hidden except for the start game button
        deckImage.image = nil
        player1Card.image = nil
        player2Card.image = nil
        player1Score.text = ""
        player2Score.text = ""
        player1Value1.text = ""
        player2Value1.text = ""
        startOutlet.isHidden = false
        flipOutlet.isHidden = true
        resetOutlet.isHidden = true
        player1ScoreLabel.isHidden = true
        player2ScoreLabel.isHidden = true
        player1ValueLabel.isHidden = true
        player2ValueLabel.isHidden = true
        //shuffle function is called
        shuffle()
    }
    
    
    
    
}

