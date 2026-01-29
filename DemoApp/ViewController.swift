//
//  ViewController.swift


import UIKit

import SwiftyMenu
import SnapKit
import PassKit
import iOSDropDown
import direct_ios_plugin


class ViewController: UIViewController , UIScrollViewDelegate
{

    //@IBOutlet var transId: UITextField!
    
    @IBOutlet var amountField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var zipField: UITextField!
    @IBOutlet var currencyField: UITextField!
    @IBOutlet var countryField: UITextField!
    //@IBOutlet var actionField: UITextField!
   
    @IBOutlet weak var transid: UITextField!
    @IBOutlet weak var actionDropDown: DropDown!
    
    @IBOutlet var trackIDField: UITextField!
    
   
    
    @IBOutlet weak var cardOperdropDwn: DropDown!
//    @IBOutlet var merchantField: UITextField!
    @IBOutlet var tockenField: UITextField!
//  @IBOutlet var picker: UIPickerView!
    
   
    @IBOutlet var stateField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var addressField: UITextField!
  

    @IBOutlet var scrollview: UIScrollView!
    @IBOutlet var holderStakView: UIStackView!
    
  //  @IBOutlet var segmentController: UISegmentedControl!
    @IBOutlet var topsegmentController: UISegmentedControl!
    
    @IBOutlet var metaData: UITextField!
    @IBOutlet var merchantIdentifier: UITextField!
//  @IBOutlet var topHolderStack: UIStackView!
    @IBOutlet weak var cardholdernameField: UITextField!
    @IBOutlet var cardnumber: UITextField!
    @IBOutlet var expmonth: UITextField!
    @IBOutlet var cvv: UITextField!
    @IBOutlet var expyear: UITextField!
    
    var addressHeightAnchor: NSLayoutConstraint? = nil
    var stateHeightAnchor: NSLayoutConstraint? = nil
    var cityHeightAnchor: NSLayoutConstraint? = nil
    var countryHeightAnchor: NSLayoutConstraint? = nil
    var cardTokenHeightAnchor:NSLayoutConstraint? = nil
    var merchantIdentifierHeightAnchor:NSLayoutConstraint? = nil
    
    let pickerData = ["Select Card Operation","Add" , "Update" , "Delete"]
    var selectedText = "Add"
    var isTokenEnabled: Bool = true
    var paymentController: UIViewController? = nil
    
    var paymentString: [String: Any]?
    var actionCodeId = " "
    var cardOperation = " "
    var isApplePayPaymentTrxn:Bool = false;
    

    
    var isSucessStatus: Bool = false
    
    
    var originalSize: CGFloat = 0
    var isApplePay : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "DEMO"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.view.backgroundColor = .white
        self.scrollview.showsVerticalScrollIndicator = false
        self.scrollview.delegate = self
        
        self.originalSize = self.tockenField.frame.height
        self.merchantIdentifier.isHidden=true
        actionDropDown.optionArray=["Select Action","Purchase"," Pre Auth ","Refund ","Void Refund","Tokenization","Void Purchase","Void Pre-Authorisation","Transaction Enquiry"]
       actionDropDown.optionIds = [0,1,4,2,6,12,3,9,10]
        print("Metadata enable", self.metaData.text)
        print("Transaction ID", self.transid.text)
        actionDropDown.didSelect{(selectedText , index ,id) in
            self.actionCodeId=String(id)
            if self.actionCodeId == "12"
            {
//              self.isTokenEnabled=true
                self.enableTokenFields()
               // print("Tokenization enable")
            }
            else
            {

            }
        //self.actionField.text = "Selected String: \(selectedText) \n index: \(id)"
        }
        
        
        cardOperdropDwn.optionArray=pickerData
        cardOperdropDwn.didSelect{(selectedText , index ,id) in
//            if self.isTokenEnabled
//            {
//                print("Tokeization enable1")
//                self.enableTokenFieldsAction()
//            }
//            else
//            {
//                print("Tokeization disable2")
//                self.disableTockenFields()
//            }
            
            switch index{
            case 0:
                self.cardOperation = "0"
            case 1:
                self.cardOperation = "A"
            case 2:
                self.cardOperation = "U"
            case 3:
                self.cardOperation = "D"
            default:
                break
            }
            
            print(self.cardOperation)
        }
        
       

        
        prepareConstraints()
        enableTokenFields()
        
        //segmentController.setTitle("Present", forSegmentAt: 0)
        //segmentController.setTitle("Not Present", forSegmentAt: 1)
        
        
        topsegmentController.setTitle("Normal Transaction", forSegmentAt: 0)
       topsegmentController.setTitle("Apple Pay Transaction", forSegmentAt: 1)
        
        

        
        if  UIScreen.main.traitCollection.userInterfaceStyle == .light
        {
            self.view.backgroundColor = .white
        }
        else
        {
            self.view.backgroundColor = .black
        }
       
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          
              // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    
    @IBAction func indexChanged(_ sender: Any) {
       let index =  topsegmentController.selectedSegmentIndex
        UIView.animate(withDuration: 0.3) {
//            self.topHolderStack.alpha = (index == 1) ? 0 : 1
//            self.topHolderStack.isHidden = index == 1
            
            if index == 0
            {
                print(index)
                self.merchantIdentifier.isHidden=true
            }
            else
            {
                self.merchantIdentifier.isHidden=false
              //  self.disableTokenFieldsAction()
            }
            
            self.view.layoutIfNeeded()
            
        }

        self.isTokenEnabled = index == 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    

    override func viewWillAppear(_ animated: Bool) {
//        [amountField , emailField , zipField , currencyField , countryField ,tockenField , utf1 , utf2 , utf3 , utf4 , utf5 , stateField , cityField, addressField].forEach({$0?.text = ""})
        
        if  UIScreen.main.traitCollection.userInterfaceStyle == .light {
            self.view.backgroundColor = .white
        } else {
            self.view.backgroundColor = .black
        }
    }
    
    @IBAction func buttonTapped() {
       let isApplePayPayment = topsegmentController.selectedSegmentIndex == 1
        
        print("In Payment Button ")
        if isApplePayPayment {
            print("In Payment Button1 ")
            self.isApplePay = "1"
            self.isApplePayPaymentTrxn=true;
            self.applePaymentconfigureSDK()
            self.applePayButtonAction()
            
        } else
        {
            self.merchantIdentifierHeightAnchor?.constant = 0
            self.isApplePay = "0"
            self.isApplePayPaymentTrxn=false;
            self.normalPaymentconfigureSDK()
            self.initializeSDK()
       }
        
    }
    
    
    fileprivate func initializeSDK() {
        UWInitialization(self) { (controller , result) in
            self.paymentController = controller
            guard let nonNilController = self.paymentController else {
                self.presentAlert(resut: result)
                return
            }
            print("initialSDK")
            self.navigationController?.pushViewController(nonNilController, animated: true)
        }

    }
    
    func applePaymentconfigureSDK() {
        let url = "https://pg.alinmapay.com.sa/Transactions/v2/payments/pay-request"
        let terminalId = "TER5392572"
        let password = "TER25123653637313042804"
        let merchantKey = "f1aa70c3de58cbd8b132b50799f4ea7b120168a43b6c20ab99298064a7df77e1"
   
        UWConfiguration(password: password, merchantKey: merchantKey, terminalID: terminalId , url: url )
    }


    func normalPaymentconfigureSDK() {

        
        let url = "https://pg.alinmapay.com.sa/Transactions/v2/payments/pay-request"
        let terminalId = "TER5392572"
        let password = "TER25123653637313042804"
        let merchantKey = "f1aa70c3de58cbd8b132b50799f4ea7b120168a43b6c20ab99298064a7df77e1"
   
        
                                            

       
        UWConfiguration(password: password , merchantKey: merchantKey , terminalID: terminalId , url: url )
    }
    
    fileprivate func applePayButtonAction()
    {
    
        UWInitialization(self)
        {
            (controller , result) in
            self.paymentController = controller
            guard let _ = self.paymentController
            else {
                self.presentAlert(resut: result)
                return
            }
        }
        
        isSucessStatus = false
        let floatAmount = Double(amountField.text ?? "0") ?? .zero

            let request = PKPaymentRequest()
            request.merchantIdentifier = merchantIdentifier.text ?? ""
            request.supportedNetworks = [.quicPay, .masterCard, .visa , .amex , .discover , .mada ]
            request.merchantCapabilities = .capability3DS

            request.countryCode = countryField.text ?? ""
            request.currencyCode = currencyField.text ?? ""

            request.paymentSummaryItems = [PKPaymentSummaryItem(label: " Test ",amount: NSDecimalNumber(floatLiteral: floatAmount) )]
        let controller = PKPaymentAuthorizationViewController(paymentRequest: request)
        if controller != nil
        {
            controller!.delegate = self
            present(controller!, animated: true, completion: nil)
        }
    }
}


//MARK: - APPLE PAYMENT CODE
extension ViewController : PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        isSucessStatus ? self.initializeSDK() : nil
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        self.paymentString  = UWInitializer.generatePaymentKey(payment: payment)
        isSucessStatus = true
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}


extension ViewController {
    
    fileprivate func prepareConstraints() {
        scrollview.contentSize = CGSize(width: self.view.frame.width, height: (self.holderStakView.frame.height  + 100))
//      self.picker.translatesAutoresizingMaskIntoConstraints = false
//      self.picker.dataSource = self
//      self.picker.delegate = self
//      self.pickerHeightAnchor = picker.heightAnchor.constraint(equalToConstant: 0)
        self.cardTokenHeightAnchor = tockenField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.stateHeightAnchor = stateField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.cityHeightAnchor = cityField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.countryHeightAnchor = countryField.heightAnchor.constraint(equalToConstant: self.originalSize)
        self.addressHeightAnchor = addressField.heightAnchor.constraint(equalToConstant: self.originalSize)

//        self.pickerHeightAnchor?.isActive = true
        self.cardTokenHeightAnchor?.isActive = true
        self.stateHeightAnchor?.isActive = true
        self.cityHeightAnchor?.isActive = true
        self.countryHeightAnchor?.isActive = true
        self.addressHeightAnchor?.isActive = true
        self.view.layoutIfNeeded()
    }
    
    @IBAction func switchOnePressed(_ sender: UISwitch) {
        if sender.isOn
        {
            isTokenEnabled = true
            enableTokenFields()
        }
        else
        {
            isTokenEnabled = false
          //  disableTokenFieldsAction()
        }
    }

    
    func disableTokenFieldsAction() {
        


        self.cityHeightAnchor?.constant = 0
        self.addressHeightAnchor?.constant = 0
        self.stateHeightAnchor?.constant = 0
    
        self.cityField.text = ""
        self.countryField.text = ""
        self.addressField.text = ""
        self.stateField.text = ""
        self.tockenField.text = ""
        
      //  self.cardTokenHeightAnchor?.constant = 0
        
        UIView.animate(withDuration: 0.5)
        {
            self.view.layoutIfNeeded()
        }
   }
    
    func enableTokenFields()
    {
        self.cityHeightAnchor?.constant = self.originalSize
        self.countryHeightAnchor?.constant = self.originalSize
        self.addressHeightAnchor?.constant = self.originalSize
        self.stateHeightAnchor?.constant = self.originalSize
        self.cardTokenHeightAnchor?.constant = self.originalSize

         UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}


extension ViewController: Initializer {

  func prepareModel() -> UWInitializer {
   print("CARD TOKEN \(tockenField.text)")
        let model = UWInitializer.init(amount: amountField.text ?? "",
                                       email: emailField.text ?? "",
                                       zipCode: zipField.text ?? "",
                                       currency: currencyField.text ?? "",
                                       country: countryField.text ?? "" ,
                                       actionCode: actionCodeId,
                                       trackIdCode: trackIDField.text ?? "",
                                       city: cityField.text ?? "",
                                       address: addressField.text ,
                                       state: stateField.text,
                                       transid: transid.text ?? "" ,
                                       merchantIdentifier: merchantIdentifier.text ?? "",
                                       isApplePay: self.isApplePay,
                                       cardToken: tockenField.text ?? "",
                                       cardOper: self.cardOperation ,
                                      
                                       cardNumber: cardnumber.text ?? "",
                                       cvv: cvv.text ?? "",
                                       expMonth: expmonth.text ?? "",
                                       expYear: expyear.text ?? "",
                                       holderName: self.cardholdernameField.text ?? "",
                                       paymentTokenString : toJSONString(self.paymentString) ,
                                  
                                       metaData: metaData.text ?? ""
                                      
                                       
                      
                                          
                                                   
                                         
                                      
                                       
        )
//                                     
      
      
//                                       holderName: holderField.text)
        return model
    }

    func didPaymentResult(result: paymentResult, error: Error?, model: PaymentResultData?) {
        switch result {
        case .sucess:
            print("PAYMENT SUCESS1 \(model?.apiresponsedata)")
            DispatchQueue.main.async {
                self.navigateTOReceptPage(model: model)
            }
            
        case.failure:
            print("PAYMENT SUCESS2 \(String(describing: model?.apiresponsedata))")
            print("PAYMENT FAILURE \(model?.apiresponsedata)")
            DispatchQueue.main.async {
                self.navigateTOReceptPage(model: model)
            }
            
          
        case .mandatory(let fieldName):
            print("PAYMENT SUCESS3 \(model?.apiresponsedata)")
            print(fieldName)
            break
        }
    }
    
    func navigateTOReceptPage(model: PaymentResultData?) {
        self.paymentController?.navigationController?.popViewController(animated: true)
        
        print("Navigate to receipt \(model?.apiresponsedata)")
        let controller = ReceptConfiguration.setup()
        controller.model = model
        controller.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: true, completion: nil)
        
       
     
       
    }
    
}

extension ViewController {
    func presentAlert(resut: paymentResult) {
          var displayTitle: String = ""
          var key: mandatoryEnum = .amount

          switch resut {
          case .mandatory(let fields):
              key = fields
          default:
              break
          }
          
          switch  key {
          case .amount:
              displayTitle = "Amount"
          case.country:
              displayTitle = "Country"
              
          case.action_code:
              displayTitle = "Action Code"
              
          case.currency:
              displayTitle = "Currency"
              
          case.email:
              displayTitle = "Email"
              
          case.trackId:
              displayTitle = "TrackID"
              
          case .tokenID:
            displayTitle = "TokenID"
              
          case .cardOperation:
            displayTitle = "Token Operation"
              
          case .transid:
             displayTitle = "Transaction ID"
          }
          
          let alert = UIAlertController(title: "Alert", message: "Check \(displayTitle) Field", preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
      }
    func toJSONString(_ dict: [String: Any]?) -> String? {
        guard let dict = dict,
              let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
     
}

