//
//  InfoViewController.swift
//  BerlinEntdecken
//
//  Created by Florencia Doval on 4/22/25.
//

import UIKit

class InfoViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var landmarkImageView: UIImageView!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var germanTextLabel: UILabel!
    @IBOutlet weak var englishTextLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    // MARK: - Properties
       var landmarkTitle: String = ""
       var isCardFlipped = false
       
       // MARK: - Lifecycle Methods
       override func viewDidLoad() {
           super.viewDidLoad()
           configureUI()
           setupLandmarkContent()
           setupCardTapGesture()
           setupAdaptiveLayout()
           viewDidLayoutSubviews()
       }
       
       // MARK: - Setup Methods
       private func configureUI() {
           // Configure navigation bar
           title = landmarkTitle
           navigationController?.navigationBar.prefersLargeTitles = false
           
           // Style image view
           landmarkImageView.layer.cornerRadius = 12
           landmarkImageView.clipsToBounds = true
           landmarkImageView.contentMode = .scaleAspectFill
           
           // Center image in container
           landmarkImageView.translatesAutoresizingMaskIntoConstraints = false
           
           // Remove any existing constraints that might interfere
           if let constraints = landmarkImageView.superview?.constraints {
               for constraint in constraints {
                   if constraint.firstItem === landmarkImageView || constraint.secondItem === landmarkImageView {
                       landmarkImageView.superview?.removeConstraint(constraint)
                   }
               }
           }
           
           // Add constraints to center and size the image
           if let superview = landmarkImageView.superview {
               NSLayoutConstraint.activate([
                landmarkImageView.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                landmarkImageView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0),
                landmarkImageView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 1.0),
                landmarkImageView.heightAnchor.constraint(equalTo: landmarkImageView.widthAnchor, multiplier: 0.6) // Aspect ratio constraint
               ])
           }
           
           titleLabel.text = landmarkTitle
           titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
           titleLabel.textColor = .label
           
           // Style card container
           cardContainerView.layer.cornerRadius = 16
           cardContainerView.backgroundColor = UIColor.systemBackground
           cardContainerView.layer.shadowColor = UIColor.black.cgColor
           cardContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
           cardContainerView.layer.shadowOpacity = 0.2
           cardContainerView.layer.shadowRadius = 6
           
           // Style text labels with identical formatting
           let bodyFont = UIFont.systemFont(ofSize: 17, weight: .regular)
           let textColor = UIColor.label
           
           // Configure German text label
           germanTextLabel.numberOfLines = 0
           germanTextLabel.font = bodyFont
           germanTextLabel.textColor = textColor
           germanTextLabel.textAlignment = .natural
           
           // Configure English text label (same formatting as German)
           englishTextLabel.numberOfLines = 0
           englishTextLabel.font = bodyFont
           englishTextLabel.textColor = textColor
           englishTextLabel.textAlignment = .natural
           
           // Initially hide the English text (back of card)
           englishTextLabel.isHidden = true
       }
       
    private func setupLandmarkContent() {
        // Content based on the landmark
        switch landmarkTitle {
        case "Brandenburg Tor":
            landmarkImageView.image = UIImage(named: "brandenburg_") ?? UIImage(systemName: "photo")
            
            let germanText = "Das Brandenburg Tor ist eines der bekanntesten Wahrzeichen Berlins. Es wurde zwischen 1788 und 1791 erbaut und steht für Frieden und Einheit.\n\nDas Tor überstand den Zweiten Weltkrieg, wurde aber schwer beschädigt. Von der ursprünglichen Quadriga blieb nur eine Statue erhalten, die bei den Restaurierungsarbeiten zwischen 1956 und 1958 als Modell für die Wiederherstellung des gesamten Ensembles verwendet wurde."
            
            let germanAttributedText = NSMutableAttributedString(string: germanText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.paragraphSpacing = 12
            germanAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: germanText.count))
            germanTextLabel.attributedText = germanAttributedText
            
            let englishText = "The Brandenburg Gate is one of Berlin's most famous landmarks. It was built between 1788 and 1791 and stands for peace and unity.\n\nThe Gate survived World War II but was severely damaged. Only one statue from the original Quadriga survived, and it was used as a model to recreate the entire ensemble during restoration works between 1956 and 1958."
            
            let englishAttributedText = NSMutableAttributedString(string: englishText)
            englishAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: englishText.count))
            englishTextLabel.attributedText = englishAttributedText
            
        case "Fernsehturm":
            landmarkImageView.image = UIImage(named: "fernsehturm_") ?? UIImage(systemName: "photo")
            
            // german text with grammar highlights
            let germanText = "Der Berliner Fernsehturm wurde am 3. Oktober 1969 – kurz vor dem 20. Geburtstag der DDR – eingeweiht. Für den damaligen DDR-Staatsratsvorsitzenden Walter Ulbricht war der Sendeturm, dessen Bau rund vier Jahre dauerte, eines der wichtigsten Symbole für die Überlegenheit der sozialistischen Gesellschaft."
            
            // paragraph styling
            let germanAttributedText = NSMutableAttributedString(string: germanText)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.paragraphSpacing = 8
            germanAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: germanText.count))
            
            // Highlight specific grammar elements
            let derRange1 = (germanText as NSString).range(of: "der ")
            let denRange = (germanText as NSString).range(of: "den ")
            let derSozRange = (germanText as NSString).range(of: "der sozialistischen")
            
            germanAttributedText.addAttribute(.foregroundColor, value: UIColor.systemRed, range: derRange1)
            germanAttributedText.addAttribute(.foregroundColor, value: UIColor.systemRed, range: denRange)
            germanAttributedText.addAttribute(.foregroundColor, value: UIColor.systemRed, range: derSozRange)
            
            germanTextLabel.attributedText = germanAttributedText
            
            let englishText = "The Berlin television tower was inaugurated on 3 October 1969 - shortly before the 20th birthday of the GDR. For the then GDR State Council Chairman Walter Ulbricht, the broadcasting tower, which took around four years to build, was one of the most important symbols of the superiority of socialist society."
            
            let englishAttributedText = NSMutableAttributedString(string: englishText)
            englishAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: englishText.count))
            englishTextLabel.attributedText = englishAttributedText
            
                       case "MuseumInsel":
                           landmarkImageView.image = UIImage(named: "Museuminsel_") ?? UIImage(systemName: "photo")
            germanTextLabel.text = "Die Museumsinsel ist eine Insel in der Spree im Zentrum Berlins. Sie beherbergt fünf weltberühmte Museen und ist UNESCO-Weltkulturerbe."
            englishTextLabel.text = "Museum Island is an island in the Spree in the center of Berlin. It houses five world-famous museums and is a UNESCO World Heritage Site."
            
                       case "Reichstag":
                           landmarkImageView.image = UIImage(named: "Reichstag_") ?? UIImage(systemName: "photo")
            
                           // text with highlighted grammar
                           let germanText = "Der Eintritt in den Reichstag ist kostenlos, allerdings sollten Sie sich im Voraus um die Eintrittskarten kümmern, denn das Reichstagsgebäude ist eine der meistbesuchten Sehenswürdigkeiten der Stadt."
                           let germanAttributedText = NSMutableAttributedString(string: germanText)
            
                           // paragraph styling
                           let paragraphStyle = NSMutableParagraphStyle()
                           paragraphStyle.lineSpacing = 4
                           paragraphStyle.paragraphSpacing = 8
                           germanAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: germanText.count))
            
                           // Highlight grammar element
                           let inDenRange = (germanText as NSString).range(of: "in den Reichstag")
                           germanAttributedText.addAttribute(.foregroundColor, value: UIColor.systemRed, range: inDenRange)
            
            germanTextLabel.attributedText = germanAttributedText
            
                           // English text with same paragraph styling
                           let englishText = "Admission to the Reichstag is free, but you should take care of the tickets in advance, as the Reichstag building is one of the most visited sights in the city."
                           let englishAttributedText = NSMutableAttributedString(string: englishText)
                           englishAttributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: englishText.count))
            englishTextLabel.attributedText = englishAttributedText
            
                       default:
                           landmarkImageView.image = UIImage(systemName: "photo")
                           titleLabel.text = "Berlin Landmark"
            germanTextLabel.text = "Information zu dieser Sehenswürdigkeit wird bald verfügbar sein."
            englishTextLabel.text = "Information about this sight will be available soon."
                       }

       }
       
       private func setupCardTapGesture() {
           // tap gesture recognizer to the card container
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flipCard))
           cardContainerView.addGestureRecognizer(tapGesture)
           cardContainerView.isUserInteractionEnabled = true
       }
       
       private func setupAdaptiveLayout() {
           // Add a tooltip if needed
           if landmarkTitle == "Fernsehturm" {
               // Create tooltip view
               let tooltipView = UIView()
               tooltipView.backgroundColor = UIColor.systemGray5
               tooltipView.layer.cornerRadius = 8
               tooltipView.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(tooltipView)
               
               // Position tooltip and its contents
               NSLayoutConstraint.activate([
                tooltipView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor, constant: -20),
                tooltipView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor, constant: -10),
                tooltipView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
                
               ])
           }
           
           // Ensure card has proper constraints for all screen sizes
           NSLayoutConstraint.activate([
               // Add any additional constraints needed for better layout
               cardContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               cardContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           ])
       }
       
       // MARK: - Actions
       @objc private func flipCard() {
           // Flip the card with animation
           isCardFlipped = !isCardFlipped
           
           // First fade out current text
           UIView.animate(withDuration: 0.2, animations: {
               if self.isCardFlipped {
                   self.germanTextLabel.alpha = 0
               } else {
                   self.englishTextLabel.alpha = 0
               }
           }) { _ in
               // Then flip
               UIView.transition(with: self.cardContainerView, duration: 0.5, options: .transitionFlipFromRight, animations: {
                   self.germanTextLabel.isHidden = self.isCardFlipped
                   self.englishTextLabel.isHidden = !self.isCardFlipped
                   
                   // Update background color to provide visual cue
                   if self.isCardFlipped {
                       self.cardContainerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.05)
                       self.englishTextLabel.alpha = 1
                   } else {
                       self.cardContainerView.backgroundColor = UIColor.systemBackground
                       self.germanTextLabel.alpha = 1
                   }
               }, completion: nil)
           }
       }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            // Ensure the image fills the width and maintains proper aspect ratio
            if let superview = landmarkImageView.superview {
                landmarkImageView.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: superview.bounds.width,
                    height: superview.bounds.width * 0.6 // 60% of width for aspect ratio
                )
            }
        }
   }
