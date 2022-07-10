//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 07.07.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resultTitleLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    
    var answersChosen: [Answer]!
    

    // 4. Избавиться от кнопки возврата назад на экране результатов
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // почему-то Xcode повелел удалить проверку as? Animal (it does nothing). Тут не очень понятен момент (
        guard let animal = findResultingAnimal() else { return }
        resultTitleLabel.text = "Вы - \(animal.rawValue)"
        resultDefinitionLabel.text = animal.definition
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    deinit {
        print("ResultViewController has been deallocated")
    }
    
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
        
        guard let resultingAnimal = animalsSorted.first?.key as? Animal else { return nil }
        
        return resultingAnimal
        
    }
}
