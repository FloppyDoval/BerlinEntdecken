//
//  PracticeViewController.swift
//  BerlinEntdecken
//
//  Created by Florencia Doval on 4/22/25.
//

import UIKit

// MARK: - Exercise Types & Models
// Grammar case types
enum GrammarCase: String, CaseIterable {
    case nominativ = "Nominativ (Subject Case)"
    case akkusativ = "Akkusativ (Direct Object Case)"
    case dativ = "Dativ (Indirect Object Case)"
    case mixed = "Mixed Cases"
    
    var description: String {
        switch self {
        case .nominativ:
            return "The nominative case is the most commonly used case. It indicates the subject of the sentence, i.e., the person or thing doing the activity in the sentence."
        case .akkusativ:
            return "The accusative case denotes objects in sentences. The object is the thing in the sentence having something done to it."
        case .dativ:
            return "The dative case indicates the indirect object of a sentence, telling to whom or for whom something is done."
        case .mixed:
            return "Mixed practice using all three cases: Nominativ (subject), Akkusativ (direct object), and Dativ (indirect object). Identify and use the correct articles."
        }
    }
}

// Models for exercises and questions
struct Exercise {
    let grammarCase: GrammarCase
    let instructions: String
    var questions: [Question]
}

struct Question {
    let text: String
    let answer: String
    let options: [String]
    let explanation: String
}

// MARK: - Practice View Controller
class PracticeViewController: UIViewController {
    // MARK: - Properties
    private var allExercises: [Exercise] = []
    private var currentExerciseIndex = 0
    private var currentQuestionIndex = 0
    private var score = 0
    private var totalAnswered = 0
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let tableImageView = UIImageView()
    private let caseLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let instructionsLabel = UILabel()
    private let questionLabel = UILabel()
    private let optionsStackView = UIStackView()
    private let feedbackLabel = UILabel()
    private let scoreLabel = UILabel()
    private let nextButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupExercises()
        setupUI()
        shuffleAndLoadExercise()
    }
    
    // MARK: - Setup Methods
    private func setupExercises() {
        
        // Nominativ Exercises
        let nominativExercise = Exercise(
            grammarCase: .nominativ,
            instructions: "Fill in the blanks with the correct form of the article:",
            questions: [
                Question(
                    text: "_____ Brandenburg Tor ist ein Symbol der deutschen Einheit. (das)",
                    answer: "Das",
                    options: ["Der", "Die", "Das", "Den"],
                    explanation: "Brandenburg Tor is neuter, so it uses 'das' in nominativ case."
                ),
                Question(
                    text: "_____ Fernsehturm bietet einen herrlichen Blick über die Stadt. (der)",
                    answer: "Der",
                    options: ["Der", "Die", "Das", "Den"],
                    explanation: "Fernsehturm is masculine, so it uses 'der' in nominativ case."
                ),
                Question(
                    text: "_____ East Side Gallery zeigt beeindruckende Kunstwerke. (die)",
                    answer: "Die",
                    options: ["Der", "Die", "Das", "Den"],
                    explanation: "Gallery is feminine, so it uses 'die' in nominativ case."
                ),
                Question(
                    text: "_____ Holocaust-Mahnmal erinnert an die Opfer des Nationalsozialismus. (das)",
                    answer: "Das",
                    options: ["Der", "Die", "Das", "Den"],
                    explanation: "Holocaust-Mahnmal is neuter, so it uses 'das' in nominativ case."
                )
            ]
        )
        
        // Akkusativ Exercises
        let akkusativExercise = Exercise(
            grammarCase: .akkusativ,
            instructions: "Select the correct accusative article for these direct objects:",
            questions: [
                Question(
                    text: "Ich besuche _____ Reichstagsgebäude. (das)",
                    answer: "das",
                    options: ["der", "die", "das", "den"],
                    explanation: "Reichstagsgebäude is neuter, so it remains 'das' in accusative case."
                ),
                Question(
                    text: "Die Touristen fotografieren _____ Berliner Dom. (der)",
                    answer: "den",
                    options: ["der", "die", "das", "den"],
                    explanation: "Berliner Dom is masculine, so 'der' changes to 'den' in accusative case."
                ),
                Question(
                    text: "Wir bewundern _____ Museumsinsel mit ihren Kunstschätzen. (die)",
                    answer: "die",
                    options: ["der", "die", "das", "den"],
                    explanation: "Museumsinsel is feminine, so it remains 'die' in accusative case."
                ),
                Question(
                    text: "Er sieht _____ Gendarmenmarkt im Schnee. (der)",
                    answer: "den",
                    options: ["der", "die", "das", "den"],
                    explanation: "Gendarmenmarkt is masculine, so 'der' changes to 'den' in accusative case."
                )
            ]
        )
        
        // Dativ Exercises
        let dativExercise = Exercise(
            grammarCase: .dativ,
            instructions: "Complete the sentences with the correct Dativ form:",
            questions: [
                Question(
                    text: "Der Guide gibt _____ Touristen Informationen über das Brandenburg Tor. (die)",
                    answer: "den",
                    options: ["der", "den", "dem", "des"],
                    explanation: "Touristen is plural, so 'die' changes to 'den' in dative case."
                ),
                Question(
                    text: "Wir nähern uns _____ Holocaust-Mahnmal. (das)",
                    answer: "dem",
                    options: ["der", "die", "das", "dem"],
                    explanation: "Holocaust-Mahnmal is neuter, so 'das' changes to 'dem' in dative case."
                ),
                Question(
                    text: "Gegenüber _____ Berliner Dom liegt das Alte Museum. (der)",
                    answer: "dem",
                    options: ["der", "die", "dem", "den"],
                    explanation: "Berliner Dom is masculine, so 'der' changes to 'dem' in dative case."
                ),
                Question(
                    text: "Sie erzählt von _____ Gemälden an der East Side Gallery. (die)",
                    answer: "den",
                    options: ["der", "den", "dem", "des"],
                    explanation: "Gemälden is plural, so 'die' changes to 'den' in dative case."
                )
            ]
        )
        
        // Mixed Cases Exercise
        let mixedExercise = Exercise(
            grammarCase: .mixed,
            instructions: "Identify the case of the underlined articles and correct them if necessary:",
            questions: [
                Question(
                    text: "**Der** Reichstag wurde nach **dem** Wiedervereinigung renoviert.",
                    answer: "der",
                    options: ["der", "die", "das", "den"],
                    explanation: "Wiedervereinigung is feminine, so it should be 'der' in dative case, not 'dem'."
                ),
                Question(
                    text: "**Die** Besucher bewundern **das** Architektur **des** Fernsehturms.",
                    answer: "die",
                    options: ["der", "die", "das", "den"],
                    explanation: "Architektur is feminine, so it should be 'die' in accusative case, not 'das'."
                ),
                Question(
                    text: "**Der** Guide führt **die** Gruppe durch **der** Gendarmenmarkt.",
                    answer: "den",
                    options: ["der", "die", "das", "den"],
                    explanation: "The preposition 'durch' requires accusative case, so it should be 'den' not 'der'."
                ),
                Question(
                    text: "Neben **die** Museumsinsel fließt **die** Spree durch **das** Zentrum Berlins.",
                    answer: "der",
                    options: ["der", "die", "das", "den"],
                    explanation: "The preposition 'neben' requires dative case here, so it should be 'der' not 'die'."
                )
            ]
        )
        
        allExercises = [nominativExercise, akkusativExercise, dativExercise, mixedExercise]
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "German Grammar Practice"
        
        // scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        tableImageView.translatesAutoresizingMaskIntoConstraints = false
        tableImageView.contentMode = .scaleAspectFit
        tableImageView.image = UIImage(named: "table_")
        contentView.addSubview(tableImageView)
        
        // Case label (to show which case we're practicing)
        caseLabel.translatesAutoresizingMaskIntoConstraints = false
        caseLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        caseLabel.textColor = .systemRed
        caseLabel.textAlignment = .center
        contentView.addSubview(caseLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .label
        descriptionLabel.backgroundColor = .systemGray6
        descriptionLabel.layer.cornerRadius = 12
        descriptionLabel.clipsToBounds = true
        descriptionLabel.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentView.addSubview(descriptionLabel)
        
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textAlignment = .left
        instructionsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        instructionsLabel.textColor = .label
        contentView.addSubview(instructionsLabel)
        
        // Question label
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(questionLabel)
        
        optionsStackView.translatesAutoresizingMaskIntoConstraints = false
        optionsStackView.axis = .vertical
        optionsStackView.spacing = 12
        optionsStackView.distribution = .fillEqually
        contentView.addSubview(optionsStackView)
        
        // Feedback label
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        feedbackLabel.numberOfLines = 0
        feedbackLabel.textAlignment = .center
        feedbackLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        feedbackLabel.isHidden = true
        contentView.addSubview(feedbackLabel)
        
        // Score label
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0/0"
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        contentView.addSubview(scoreLabel)
        
        // Next button
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0) // Yellow color
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.isHidden = true
        contentView.addSubview(nextButton)
        
        // Layout constraints (for other screens)
        NSLayoutConstraint.activate([
            tableImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            tableImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tableImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tableImageView.heightAnchor.constraint(equalToConstant: 220),
            
            caseLabel.topAnchor.constraint(equalTo: tableImageView.bottomAnchor, constant: 16),
            caseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            caseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: caseLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            instructionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            questionLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 24),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            optionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            optionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            feedbackLabel.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 24),
            feedbackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            feedbackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            scoreLabel.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 16),
            scoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nextButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 24),
            nextButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    // MARK: - Game Logic
    private func shuffleAndLoadExercise() {
        // Shuffle the exercises if this is the first time
        if currentExerciseIndex == 0 && currentQuestionIndex == 0 {
            allExercises.shuffle()
            
            // Also shuffle the questions within each exercise
            for i in 0..<allExercises.count {
                allExercises[i].questions.shuffle()
            }
        }
        
        loadCurrentQuestion()
    }
    //IN PROGRESS!!!!
    private func loadCurrentQuestion() {
        // reset UI state
        feedbackLabel.isHidden = true
        nextButton.isHidden = true
        
        // clear existing option buttons
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if currentExerciseIndex < allExercises.count {
            let exercise = allExercises[currentExerciseIndex]
            
            // set exercise info
            caseLabel.text = exercise.grammarCase.rawValue
            descriptionLabel.text = exercise.grammarCase.description
            instructionsLabel.text = exercise.instructions
            
            if currentQuestionIndex < exercise.questions.count {
                let question = exercise.questions[currentQuestionIndex]
                
                // Update question label - support for rich text with Markdown-like syntax
                if question.text.contains("**") {
                    let attributedString = formatBoldText(question.text)
                    questionLabel.attributedText = attributedString
                } else {
                    questionLabel.text = question.text
                }
                
                // Create option buttons
                for option in question.options {
                    let button = UIButton(type: .system)
                    button.setTitle(option, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                    button.backgroundColor = .systemBlue
                    button.setTitleColor(.white, for: .normal)
                    button.layer.cornerRadius = 8
                    button.tag = option == question.answer ? 1 : 0
                    button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
                    
                    // Set height constraint
                    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                    
                    optionsStackView.addArrangedSubview(button)
                }
                
                // Update score label
                scoreLabel.text = "Score: \(score)/\(totalAnswered)"
            } else {
                // Move to next exercise or end
                currentExerciseIndex += 1
                currentQuestionIndex = 0
                loadCurrentQuestion()
            }
        } else {
            // Game over - show final score
            instructionsLabel.text = ""
            questionLabel.text = "Practice Complete!"
            feedbackLabel.text = "Final Score: \(score)/\(totalAnswered)"
            feedbackLabel.textColor = .systemGreen
            feedbackLabel.isHidden = false
            
            // Create restart button
            let restartButton = UIButton(type: .system)
            restartButton.setTitle("Practice Again", for: .normal)
            restartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            restartButton.backgroundColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
            restartButton.setTitleColor(.black, for: .normal)
            restartButton.layer.cornerRadius = 8
            restartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            restartButton.addTarget(self, action: #selector(restartPractice), for: .touchUpInside)
            
            optionsStackView.addArrangedSubview(restartButton)
        }
    }
    
    // Format text with bold sections (between ** **)
    private func formatBoldText(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let boldPattern = "\\*\\*(.*?)\\*\\*"
        
        do {
            let regex = try NSRegularExpression(pattern: boldPattern, options: [])
            let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
            
            // Process matches in reverse order to avoid range issues
            for match in matches.reversed() {
                if let range = Range(match.range, in: text) {
                    let boldText = String(text[range])
                    let cleanBoldText = boldText.replacingOccurrences(of: "**", with: "")
                    
                    // Replace the ** bold ** with plain bold text
                    attributedString.replaceCharacters(in: match.range, with: NSAttributedString(
                        string: cleanBoldText,
                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                                    NSAttributedString.Key.foregroundColor: UIColor.systemRed]
                    ))
                }
            }
        } catch {
            print("Error creating regular expression: \(error)")
        }
        
        return attributedString
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        let isCorrect = sender.tag == 1
        let currentQuestion = allExercises[currentExerciseIndex].questions[currentQuestionIndex]
        
        // Update UI based on answer
        if isCorrect {
            feedbackLabel.text = "Correct! 👍\n\n" + currentQuestion.explanation
            feedbackLabel.textColor = .systemGreen
            score += 1
        } else {
            feedbackLabel.text = "Wrong! The correct answer is: \(currentQuestion.answer)\n\n" + currentQuestion.explanation
            feedbackLabel.textColor = .systemRed
        }
        
        totalAnswered += 1
        
        // Show feedback and next button
        feedbackLabel.isHidden = false
        nextButton.isHidden = false
        
        // Disable all option buttons
        optionsStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.isEnabled = false
                
                // Highlight correct answer
                if button.tag == 1 {
                    button.backgroundColor = .systemGreen
                } else if button == sender {
                    button.backgroundColor = .systemRed
                }
            }
        }
        
        scoreLabel.text = "Score: \(score)/\(totalAnswered)"
    }
    
    @objc private func nextButtonTapped() {
        currentQuestionIndex += 1
        loadCurrentQuestion()
    }
    
    @objc private func restartPractice() {
        currentExerciseIndex = 0
        currentQuestionIndex = 0
        score = 0
        totalAnswered = 0
        
        // Reshuffle everything for a new practice session
        allExercises.shuffle()
        for i in 0..<allExercises.count {
            allExercises[i].questions.shuffle()
        }
        
        loadCurrentQuestion()
    }
}
