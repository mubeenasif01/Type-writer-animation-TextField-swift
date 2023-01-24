//
//  ViewController.swift
//  Type Writer Animation
//
//  Created by Mubeen on 23/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var placeHolderText = ["Medicines",
                           "Doctor",
                           "Specialities",
                           "Hospitals"]
    
    var initialText = "Search For "
    
    var myText : [[String.Element]]? = [[String.Element]]()
    var placeHolderIndex = 0
    var myCounter = 0
    var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        addPlaceholder(placeholder: initialText)
        for obj in placeHolderText{
            myText?.append(Array(obj))
        }
        fireTimer()
    }
    
    func fireTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: true)
    }
    
    @objc func typeLetter(){
        if let element = myText{
            if myCounter < element[placeHolderIndex].count {
                
                self.addPlaceholder(placeholder: (textField.placeholder ?? "") + String(element[placeHolderIndex][myCounter]))
                timer?.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(typeLetter), userInfo: nil, repeats: false)
            } else {
                if placeHolderIndex == ((myText?.count ?? 0) - 1){
                    placeHolderIndex = 0
                }else{
                    placeHolderIndex += 1
                }
                timer?.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reset), userInfo: nil, repeats: true)
                return
            }
            myCounter += 1
        }
    }
    
    @objc func reset(){
        timer?.invalidate()
        self.myCounter = 0
        self.fireTimer()
        self.textField.placeholder = initialText
    }
    
    func addPlaceholder(placeholder: String){
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        timer?.invalidate()
        if textField.text == ""{
            addPlaceholder(placeholder: "")
            placeHolderIndex = 0
        }
        else{
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            myCounter = 0
            placeHolderIndex = 0
            addPlaceholder(placeholder: initialText)
            fireTimer()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
