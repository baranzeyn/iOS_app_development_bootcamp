import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var zeroPctButton: UIButton!
    
    var tip: Double? // Percent as Double
    var bill: Float? // Total amount
    var count: Int? // Person count
    var eachPerson:Float?
    var tipDecimal:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.maximumValue = 12
        count = Int(stepper.value) // Başlangıç değeri olarak stepper'ın değerini kullan
        splitNumberLabel.text = "\(count ?? 1)"
        billTextField.delegate = self // billTextField delegesi olarak kendimizi atıyoruz
    }
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        if let title = sender.currentTitle?.replacingOccurrences(of: "%", with: "") {
            tip = Double(title)
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        count = Int(sender.value)
        splitNumberLabel.text = "\(count ?? 1)"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let tipValue = tip else {
            print("Tip value is nil")
            return
        }
        guard let totalBillString = billTextField.text, !totalBillString.isEmpty else {
            print("Total bill is empty")
            return
        }
        
        // Virgülü noktaya çevir
        let formattedBillString = totalBillString.replacingOccurrences(of: ",", with: ".")
        
        guard let totalBill = Float(formattedBillString) else {
            print("Total bill is not a valid number")
            return
        }
        guard let personCount = count else {
            print("Person count is nil")
            return
        }
        
        tipDecimal = tipValue / 100
        eachPerson = calculateTip(bill: totalBill, percent: Float(tipDecimal ?? 0.0), count: personCount)
        print("Each person should pay: \(eachPerson!)")
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func calculateTip(bill: Float, percent: Float, count: Int) -> Float {
        return (bill + (bill * percent)) / Float(count)
    }
    
    // UITextFieldDelegate metodunu ekleyelim dönüşümlerde problem olmaması için eklendi
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: ","))
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = String(format: "%.2f", eachPerson ?? 0.0)
            destinationVC.personCount=String(count ?? 1)
            destinationVC.tipPercent=String(format: "%.2f", tipDecimal ?? 0.0)
        }
    }
    func resetCalculator() {
            print("Resetting calculator") // Debugging için eklendi
            billTextField.text = ""
            splitNumberLabel.text = "1"
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            stepper.value = 1
            tip = nil
            bill = nil
            count = 1
            eachPerson = nil
            tipDecimal = nil
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("viewWillAppear called") // Debugging için eklendi
            resetCalculator()
        }
}
