//
//  ViewController.swift
//  AnthonyChen-Lab1
//
//  Created by Anthony C on 9/4/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {
    
    // declare default value view
    var originalValue = 0.0;
    var discount = 0.0;
    var salesTax = 0.0;
    var finalvalue = 0.0;
    
    // currency
    let currency = ["USD", "EUR", "CHY", "JPY", "AUD", "GBP"]
    var activeCurrency = "USD"
    
    // UITextField binding
    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discountRate: UITextField!
    @IBOutlet weak var taxRate: UITextField!
    
    // UILabel Output Binding
    @IBOutlet weak var finalPrice: UILabel!
    
    // UIslider Binding
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
    }
    
    
    /* --------------  EventListener --------------*/
    @IBAction func originalPriceChanged(_ sender: UITextField) {
        if(!stringContainsDigitOnly(sender.text!)){
            printInvalidOutput(value: "Invalid Price");
        }
        else{
            let price = Double(sender.text!) ?? 0.0
            originalValue = price
            // call update price
            // display
            finalvalue = getFinalPrice(originalPrice: originalValue, discountRate: discount, taxRate: salesTax)
            printFinalPrice(value: finalvalue)
        }
    }
    
    @IBAction func discountChanged(_ sender: UITextField) {
        if(!stringContainsDigitOnly(sender.text!)){
            printInvalidOutput(value: "Invalid discount");
        }
        else{
            // store the discount into global var
            let dis = Double(sender.text!) ?? 0.0
            discount = dis
            // call update price
            // display
            finalvalue = getFinalPrice(originalPrice: originalValue, discountRate: discount, taxRate: salesTax)
            printFinalPrice(value: finalvalue)
        }
    }
    
    @IBAction func taxChanged(_ sender: UITextField){
        if(!stringContainsDigitOnly(sender.text!)){
            printInvalidOutput(value: "Invalid Tax");
        }
        else{
            // store the tax into global var
            let tax = Double(sender.text!) ?? 0.0
            salesTax = tax
            // call update price
            // display
            finalvalue = getFinalPrice(originalPrice: originalValue, discountRate: discount, taxRate: salesTax)
            printFinalPrice(value: finalvalue)
        }
    }
    
    // button pressed
    
    @IBAction func buttonPressed(_ sender: Any) {
        originalPrice.resignFirstResponder()
        discountRate.resignFirstResponder()
        taxRate.resignFirstResponder()
        //        let temp = getFinalPrice(originalPrice: originalValue, discountRate: discount, taxRate: salesTax)
        //        printFinalPrice(value: temp)
        //        print("pressed")
    }
    
    
    
    /* ------------    Helper   ----------------*/
    func stringContainsDigitOnly(_ value: String) -> Bool{
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            return false
        }
        return true
    }
    func textFieldReturnKey(textField: UITextField) -> Bool{
        return true;
    }
    func getFinalPrice(originalPrice: Double, discountRate: Double, taxRate: Double) -> Double {
        return originalPrice * (100-discountRate) * (100+taxRate) / 10000;
    }
    
    // display update function
    func printFinalPrice(value: Double){
        finalPrice.text = "$\(String(format: "%.2f", value))"
    }
    func printInvalidOutput(value: String){
        finalPrice.text = "\(value)"
    }
    
    // currency selector
    func calculateWithCurrency(value: Double, cur: String){
        if(cur == "JPY"){
            finalPrice.text = "¥\(String(format: "%.0f", value*143.805))"
        }
        else if(cur == "CHY"){
            finalPrice.text = "¥\(String(format: "%.2f", value*6.9657))"
        }
        else if(cur == "EUR"){
            finalPrice.text = "€\(String(format: "%.2f", value*0.9994))"
        }
        else if(cur == "AUD"){
            finalPrice.text = "$\(String(format: "%.2f", value*1.4779))"
        }
        else if(cur == "GBP"){
            finalPrice.text = "£\(String(format: "%.2f", value*0.86))"
        }
        else if(cur == "USD"){
            finalPrice.text = "$\(String(format: "%.2f", value))"
        }
    }
    
    
}

// close keyboard func
extension ViewController: UITextViewDelegate{
    func textFieldReturn(_textField: UITextField) -> Bool{
        return true;
    }
}

// how to make picker tutorial from https://www.youtube.com/watch?v=EsheQe6U_WE
extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = currency[row]
        calculateWithCurrency(value: finalvalue, cur: activeCurrency)
    }
}







