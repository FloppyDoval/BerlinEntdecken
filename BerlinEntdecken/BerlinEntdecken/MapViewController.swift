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
    @IBOutlet weak var challengeTypeLabel: UILabel!
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
        ("Brandenburg Tor", CLLocationCoordinate2D(latitude: 52.5163, longitude: 13.3777)),
        ("Fernsehturm", CLLocationCoordinate2D(latitude: 52.5208, longitude: 13.4094)),
        ("MuseumInsel", CLLocationCoordinate2D(latitude: 52.5192, longitude: 13.3728)),
        ("Reichstag", CLLocationCoordinate2D(latitude: 52.5186, longitude: 13.3762))
    ]
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        setupResponsiveUI()
        configureMap()
        setupDailyChallengeContainer()
        setupWordOfTheDayContainer()
        adjustForDeviceSize()
    }
    
    private func configureUIElements() {
        // Configure header
        headerLabel.text = "Berlin Entdecken!"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        headerLabel.textColor = UIColor.red
        headerLabel.textAlignment = .left
        
        // Style the daily challenge view
        dailyChallengeView.layer.cornerRadius = 12
        dailyChallengeView.layer.shadowColor = UIColor.black.cgColor
        dailyChallengeView.layer.shadowOffset = CGSize(width: 0, height: 2)
        dailyChallengeView.layer.shadowOpacity = 0.1
        dailyChallengeView.layer.shadowRadius = 4
        
        // Style the practice button
        practiceChallengeButton.layer.cornerRadius = 8
        practiceChallengeButton.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        practiceChallengeButton.setTitle("Start Practice", for: .normal)
        
        // Style the word of the day view
        wordOfTheDayView.layer.cornerRadius = 12
        wordOfTheDayView.layer.shadowColor = UIColor.black.cgColor
        wordOfTheDayView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wordOfTheDayView.layer.shadowOpacity = 0.1
        wordOfTheDayView.layer.shadowRadius = 4
        
        // Style the check word button
        checkWordButton.layer.cornerRadius = 8
        checkWordButton.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1.0)
        checkWordButton.setTitle("Save Word", for: .normal)
        
        // Round map view corners
        mapView.layer.cornerRadius = 20.0
        mapView.clipsToBounds = true
    }
    private func adjustForDeviceSize() {
        let screenSize = UIScreen.main.bounds.size
        
        // Adjust font sizes based on screen width
        if screenSize.width >= 428 { // iPhone Pro Max models
            headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
            challengeTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            wordOfTheDayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        } else {
            headerLabel.font = UIFont.boldSystemFont(ofSize: 22)
            challengeTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            wordOfTheDayLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
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
                                        latitudinalMeters: 1000,
                                        longitudinalMeters: 1000)
        mapView.layer.cornerRadius = 20.0;

        mapView.setRegion(region, animated: true)
        
        // Add annotations for Berlin landmarks
        addLandmarkAnnotations()
        
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
    private func setupResponsiveUI() {
        // Remove all existing subviews from the main view to start fresh
        view.subviews.forEach { if $0 != mapView && $0 != headerLabel && $0 != dailyChallengeView && $0 != wordOfTheDayView { $0.removeFromSuperview() } }
        
        // Create scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        // Style both container views with the same outer border and shadow
        [dailyChallengeView, wordOfTheDayView].forEach { container in
            container.layer.cornerRadius = 12
            container.layer.shadowColor = UIColor.black.cgColor
            container.layer.shadowOffset = CGSize(width: 0, height: 2)
            container.layer.shadowOpacity = 0.1
            container.layer.shadowRadius = 4
            container.backgroundColor = .white
            container.clipsToBounds = false // Allow shadow to show
        }
        // Add constraints for scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Create content view for scroll view
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        // Add constraints for content view
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Reset translations for all components
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        dailyChallengeView.translatesAutoresizingMaskIntoConstraints = false
        wordOfTheDayView.translatesAutoresizingMaskIntoConstraints = false
        
        // Make sure background colors are set
        view.backgroundColor = .white
        contentView.backgroundColor = .white
        dailyChallengeView.backgroundColor = .white
        wordOfTheDayView.backgroundColor = .white
        
        // Add components to content view
        contentView.addSubview(headerLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(dailyChallengeView)
        contentView.addSubview(wordOfTheDayView)
        
        // Configure header label constraints
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // Configure map view constraints
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        // Configure daily challenge view constraints
        NSLayoutConstraint.activate([
            dailyChallengeView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 24),
            dailyChallengeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dailyChallengeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        // Configure word of the day view constraints
        NSLayoutConstraint.activate([
            wordOfTheDayView.topAnchor.constraint(equalTo: dailyChallengeView.bottomAnchor, constant: 40),  // Extra spacing
            wordOfTheDayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wordOfTheDayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wordOfTheDayView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
        // Style both container views with the same outer border and shadow
            [dailyChallengeView, wordOfTheDayView].forEach { container in
                container.layer.cornerRadius = 12
                container.layer.shadowColor = UIColor.black.cgColor
                container.layer.shadowOffset = CGSize(width: 0, height: 2)
                container.layer.shadowOpacity = 0.1
                container.layer.shadowRadius = 4
                container.backgroundColor = .white
                container.clipsToBounds = false // Allow shadow to show
            }
        // Ensure content size is correct
        let bottomConstraint = wordOfTheDayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }
    
    private func setupDailyChallengeContainer() {
        // Clear any existing subviews if recreating the layout
        dailyChallengeView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create stack view for challenge content
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        dailyChallengeView.addSubview(stackView)
        
        // Add constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: dailyChallengeView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: dailyChallengeView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: dailyChallengeView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: dailyChallengeView.bottomAnchor, constant: -12)
        ])
        
        // Create header stack (horizontal) for title
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center
        
        // Configure challenge title
        challengeTitleLabel.text = "Daily Challenge"
        challengeTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        challengeTitleLabel.textColor = .red
        
        // Add title to header stack
        headerStack.addArrangedSubview(challengeTitleLabel)
        
        // Configure type label
        challengeTypeLabel.text = "Practice Akkusativ in German"
        challengeTypeLabel.font = UIFont.systemFont(ofSize: 14)
        
        // Create a content container with colored background (like in Word of the Day)
        let contentContainer = UIView()
        contentContainer.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.1) // Light blue background
        contentContainer.layer.cornerRadius = 12
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Create stack for content
        let contentStack = UIStackView()
        contentStack.axis = .vertical
        contentStack.spacing = 8
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(contentStack)
        
        // Add constraints for content stack
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 12),
            contentStack.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 12),
            contentStack.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -12),
            contentStack.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -12)
        ])
        
        [dailyChallengeView, wordOfTheDayView].forEach { container in
            container.layer.cornerRadius = 12
            container.layer.shadowColor = UIColor.black.cgColor
            container.layer.shadowOffset = CGSize(width: 0, height: 2)
            container.layer.shadowOpacity = 0.1
            container.layer.shadowRadius = 4
            container.backgroundColor = .white
            container.clipsToBounds = false // Allow shadow to show
        }
        
        // Create example label with attributed text
        let practiceExample = "\"Der Eintritt in den Reichstag ist kostenlos\""
        let attributedText = NSMutableAttributedString(string: practiceExample)
        let range = (practiceExample as NSString).range(of: "den Reichstag")
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        challengeDescriptionLabel.attributedText = attributedText
        challengeDescriptionLabel.numberOfLines = 0
        challengeDescriptionLabel.textAlignment = .center
        
        // Add content to the content stack
        contentStack.addArrangedSubview(challengeDescriptionLabel)
        
        // Configure button
        practiceChallengeButton.setTitle("Start Practice", for: .normal)
        
        // Add all elements to main stack
        stackView.addArrangedSubview(headerStack)
        stackView.addArrangedSubview(challengeTypeLabel)
        stackView.addArrangedSubview(contentContainer)
        stackView.addArrangedSubview(practiceChallengeButton)
        
        // Set content hugging priorities
        challengeTitleLabel.setContentHuggingPriority(.required, for: .vertical)
        challengeTypeLabel.setContentHuggingPriority(.required, for: .vertical)
        challengeDescriptionLabel.setContentHuggingPriority(.required, for: .vertical)
//        dailyChallengeView.clipsToBounds = true
    }
    private func setupWordOfTheDayContainer() {
        // Clear any existing subviews
        wordOfTheDayView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create main stack for the container
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        wordOfTheDayView.addSubview(mainStack)
        
        // Add constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: wordOfTheDayView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: wordOfTheDayView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: wordOfTheDayView.trailingAnchor, constant: -12),
            mainStack.bottomAnchor.constraint(equalTo: wordOfTheDayView.bottomAnchor, constant: -12)
        ])
        
        // Create header stack (horizontal) for title and word
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.distribution = .equalSpacing
        headerStack.alignment = .center
        
        // Configure title label
        wordOfTheDayLabel.text = "Word of the Day"
        wordOfTheDayLabel.font = UIFont.boldSystemFont(ofSize: 18)
        wordOfTheDayLabel.textColor = .red
        
        // Create word type label
        let wordTypeLabel = UILabel()
        wordTypeLabel.text = "Eintrittskarte"
        wordTypeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // Add labels to header stack
        headerStack.addArrangedSubview(wordOfTheDayLabel)
        headerStack.addArrangedSubview(wordTypeLabel)
        
        // Create pink background container for German text
        let pinkContainer = UIView()
        pinkContainer.backgroundColor = UIColor.systemPink.withAlphaComponent(0.1)
        pinkContainer.layer.cornerRadius = 12
        
        // Create stack for German text content
        let germanStack = UIStackView()
        germanStack.axis = .vertical
        germanStack.spacing = 8
        germanStack.alignment = .center
        germanStack.translatesAutoresizingMaskIntoConstraints = false
        pinkContainer.addSubview(germanStack)
        
        // Add constraints
        NSLayoutConstraint.activate([
            germanStack.topAnchor.constraint(equalTo: pinkContainer.topAnchor, constant: 12),
            germanStack.leadingAnchor.constraint(equalTo: pinkContainer.leadingAnchor, constant: 12),
            germanStack.trailingAnchor.constraint(equalTo: pinkContainer.trailingAnchor, constant: -12),
            germanStack.bottomAnchor.constraint(equalTo: pinkContainer.bottomAnchor, constant: -12)
        ])
        
        // Configure German text
        let germanText = "Kaufen Sie die Eintrittskarten im Voraus"
        let attributedText = NSMutableAttributedString(string: germanText)
        let range = (germanText as NSString).range(of: "Eintrittskarten")
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        wordOfTheDayGermanLabel.attributedText = attributedText
        wordOfTheDayGermanLabel.numberOfLines = 0
        wordOfTheDayGermanLabel.textAlignment = .center
        
        // Configure translation
        wordOfTheDayTranslationLabel.text = "\"Buy your entrance tickets in advance\""
        wordOfTheDayTranslationLabel.font = UIFont.italicSystemFont(ofSize: 14)
        wordOfTheDayTranslationLabel.textColor = UIColor.darkGray
        wordOfTheDayTranslationLabel.numberOfLines = 0
        wordOfTheDayTranslationLabel.textAlignment = .center
        
        // Add German text and translation to the stack
        germanStack.addArrangedSubview(wordOfTheDayGermanLabel)
        germanStack.addArrangedSubview(wordOfTheDayTranslationLabel)
        
        // Configure save button
        checkWordButton.setTitle("Save Word", for: .normal)
        
        // Add all components to main stack
        mainStack.addArrangedSubview(headerStack)
        mainStack.addArrangedSubview(pinkContainer)
        mainStack.addArrangedSubview(checkWordButton)
    }
    
    // MARK: - Actions
    @IBAction func practiceChallengeButtonTapped(_ sender: UIButton) {
        // Navigate to practice page with randomly shuffled exercises
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let practiceVC = storyboard.instantiateViewController(withIdentifier: "PracticeViewController") as? PracticeViewController {
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
            case "Brandenburg Tor":
                markerAnnotationView.markerTintColor = .blue
            case "Fernsehturm":
                markerAnnotationView.markerTintColor = .red
            case "MuseumInsel":
                markerAnnotationView.markerTintColor = .purple
            default:
                markerAnnotationView.markerTintColor = .green
            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "showInfoVC", sender: view.annotation)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfoVC",
           let annotation = sender as? MKAnnotation,
           let infoVC = segue.destination as? InfoViewController {
            infoVC.landmarkTitle = (annotation.title ?? "")!
        }
    }


}
