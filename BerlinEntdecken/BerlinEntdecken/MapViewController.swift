//
//  MapViewController.swift
//  BerlinEntdecken
//
//  Created by Florencia Doval on 4/22/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var dailyChallengeView: UIView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    @IBOutlet weak var practiceChallengeButton: UIButton!
    @IBOutlet weak var wordOfTheDayView: UIView!
    @IBOutlet weak var wordOfTheDayLabel: UILabel!
    @IBOutlet weak var wordOfTheDayGermanLabel: UILabel!
    @IBOutlet weak var wordOfTheDayTranslationLabel: UILabel!
    @IBOutlet weak var checkWordButton: UIButton!
    
    // MARK: - Properties
    let berlinCenter = CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050)
    let landmarks: [(title: String, coordinate: CLLocationCoordinate2D)] = [
        ("Brandenburger Tor", CLLocationCoordinate2D(latitude: 52.5163, longitude: 13.3777)),
        ("Fernsehturm", CLLocationCoordinate2D(latitude: 52.5208, longitude: 13.4094)),
        ("Museum", CLLocationCoordinate2D(latitude: 52.5192, longitude: 13.3728)),
        ("Currywurst", CLLocationCoordinate2D(latitude: 52.5295, longitude: 13.3920)),
        ("Reichstag", CLLocationCoordinate2D(latitude: 52.5186, longitude: 13.3762))
    ]
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureMap()
        setupDailyChallenge()
        setupWordOfTheDay()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        // Configure header
        headerLabel.text = "BerlinEntdecken!"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        headerLabel.textColor = UIColor.red
        
        // Style the daily challenge view
        dailyChallengeView.layer.cornerRadius = 12
        dailyChallengeView.layer.shadowColor = UIColor.black.cgColor
        dailyChallengeView.layer.shadowOffset = CGSize(width: 0, height: 2)
        dailyChallengeView.layer.shadowOpacity = 0.1
        dailyChallengeView.layer.shadowRadius = 4
        
        // Style the practice button
        practiceChallengeButton.layer.cornerRadius = 8
        practiceChallengeButton.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        
        // Style the word of the day view
        wordOfTheDayView.layer.cornerRadius = 12
        wordOfTheDayView.layer.shadowColor = UIColor.black.cgColor
        wordOfTheDayView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wordOfTheDayView.layer.shadowOpacity = 0.1
        wordOfTheDayView.layer.shadowRadius = 4
        
        // Style the check word button
        checkWordButton.layer.cornerRadius = 8
        checkWordButton.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
    }
    
    private func configureMap() {
        // Set initial region to Berlin
        let region = MKCoordinateRegion(center: berlinCenter,
                                        latitudinalMeters: 5000,
                                        longitudinalMeters: 5000)
        mapView.setRegion(region, animated: true)
        
        // Add annotations for Berlin landmarks
        addLandmarkAnnotations()
        
        // Set delegate to customize annotation views
        // Set delegate to customize annotation views
        mapView.delegate = self
    }
    
    private func addLandmarkAnnotations() {
        var annotations = [MKPointAnnotation]()
        
        for landmark in landmarks {
            let annotation = MKPointAnnotation()
            annotation.title = landmark.title
            annotation.coordinate = landmark.coordinate
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
    }
    
    private func setupDailyChallenge() {
        challengeTitleLabel.text = "Daily Challenge"
        challengeTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        challengeDescriptionLabel.text = "Practise Akkusativ in German"
        challengeDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        
        let practiceExample = "\"Der Eintritt in den Reichstag ist kostenlos\""
        let attributedText = NSMutableAttributedString(string: practiceExample)
        let range = (practiceExample as NSString).range(of: "den Reichstag")
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        
        // Add a description label below the example
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Start Practice"
        practiceChallengeButton.setTitle("Start Practice", for: .normal)
    }
    
    private func setupWordOfTheDay() {
        wordOfTheDayLabel.text = "Word of the Day"
        wordOfTheDayLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        wordOfTheDayGermanLabel.text = "Kaufen Sie die Eintrittskarten im Voraus"
        
        // Highlight the specific word
        let attributedText = NSMutableAttributedString(string: wordOfTheDayGermanLabel.text ?? "")
        if let text = wordOfTheDayGermanLabel.text {
            let range = (text as NSString).range(of: "Eintrittskarten")
            attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        }
        wordOfTheDayGermanLabel.attributedText = attributedText
        
        wordOfTheDayTranslationLabel.text = "\"Buy your entrance tickets in advance\""
        wordOfTheDayTranslationLabel.font = UIFont.italicSystemFont(ofSize: 14)
        wordOfTheDayTranslationLabel.textColor = UIColor.darkGray
        
        checkWordButton.setTitle("Check Word", for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func practiceChallengeButtonTapped(_ sender: UIButton) {
        // Navigate to practice page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let practiceVC = storyboard.instantiateViewController(withIdentifier: "PracticeViewController") as? PracticeViewController {
            practiceVC.practiceType = .akkusativ
            navigationController?.pushViewController(practiceVC, animated: true)
        }
    }
    
    @IBAction func checkWordButtonTapped(_ sender: UIButton) {
        // Navigate to word detail page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let wordDetailVC = storyboard.instantiateViewController(withIdentifier: "WordDetailViewController") as? WordDetailViewController {
            wordDetailVC.word = "Eintrittskarten"
            wordDetailVC.translation = "entrance tickets"
            navigationController?.pushViewController(wordDetailVC, animated: true)
        }
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "LandmarkAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // Add a button to the callout
            let button = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = button
        } else {
            annotationView?.annotation = annotation
        }
        
        // Customize marker color based on landmark type
        if let markerAnnotationView = annotationView as? MKMarkerAnnotationView {
            switch annotation.title ?? "" {
            case "Brandenburger Tor":
                markerAnnotationView.markerTintColor = .blue
            case "Fernsehturm":
                markerAnnotationView.markerTintColor = .red
            case "Museum":
                markerAnnotationView.markerTintColor = .purple
            case "Currywurst":
                markerAnnotationView.markerTintColor = .orange
            default:
                markerAnnotationView.markerTintColor = .green
            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        
        // Navigate to info page for the selected landmark
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let infoVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController {
            infoVC.landmarkTitle = (annotation.title ?? "")!
            navigationController?.pushViewController(infoVC, animated: true)
        }
    }
}
