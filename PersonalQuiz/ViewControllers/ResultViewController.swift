//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 07.07.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var resultTitleLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    
    // MARK: - Public Properties
    var answersChosen: [Answer]!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // почему-то Xcode повелел удалить проверку as? Animal (it does nothing). Тут не очень понятен момент (
        showResult()
        
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - IB Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func findResultingAnimal() -> Animal? {
        var animalsChosen: [Animal] = []
        
        for answer in answersChosen {
            animalsChosen.append(answer.animal)
        }
        
        var animalsNumber: [Animal: Int] = [:]
        
        for animal in animalsChosen {
            animalsNumber[animal] = (animalsNumber[animal] ?? 0) + 1
        }
        
        let animalsSorted = animalsNumber.sorted { $0.1 > $1.1 }
        
        let resultingAnimal = animalsSorted.first?.key
        
        return resultingAnimal
    }
    
    private func showResult() {
        guard let animal = findResultingAnimal() else { return }
        
        resultTitleLabel.text = "Вы - \(animal.rawValue)"
        resultDefinitionLabel.text = animal.definition
    }
}
