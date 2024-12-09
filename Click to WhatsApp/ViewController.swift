import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneTextField: UITextField!
    var formattedNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.delegate = self
    }

    @IBAction func messageButtonPressed(_ sender: UIButton) {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter a phone number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        formattedNumber = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let whatsappURL = URL(string: "https://wa.me/\(formattedNumber)")!
        
        if UIApplication.shared.canOpenURL(whatsappURL) {
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "WhatsApp is not installed on your device.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneTextField.endEditing(true)
    }
}
