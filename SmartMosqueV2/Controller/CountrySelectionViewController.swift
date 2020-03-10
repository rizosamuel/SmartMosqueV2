//
//  CountrySelectionViewController.swift
//  SmartMosqueV2
//
//  Created by Rizo iMac on 02/03/20.
//  Copyright © 2020 Rizo Corp. All rights reserved.
//

import UIKit

class CountrySelectionViewController: UIViewController {
    
    @IBOutlet weak var countryDropDownView: UIView!
    @IBOutlet weak var cityDropDownView: UIView!
    @IBOutlet weak var mosqueDropDownView: UIView!
    
    @IBOutlet weak var countryDropdownLabel: UILabel!
    @IBOutlet weak var cityDropdownLabel: UILabel!
    @IBOutlet weak var mosqueDropdownLabel: UILabel!
    
    @IBOutlet weak var goButton: UIButton!
    
    var getCountriesAPI = GetCountriesAPI()
    var getCitiesAPI = GetCitiesAPI()
    
    var picker: UIPickerView! = UIPickerView()
    var toolbar: UIToolbar! = UIToolbar()
    var pickerData: [String] = [String]()
    
    var selectedDropdown: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getCountriesAPI.delegate = self
        getCitiesAPI.delegate = self
        
        goButton.layer.cornerRadius = 10
        
        setDropDownView(countryDropDownView)
        setDropDownView(cityDropDownView)
        setDropDownView(mosqueDropDownView)
        
        setTapRecognizer(countryDropDownView)
        setTapRecognizer(cityDropDownView)
        setTapRecognizer(mosqueDropDownView)
        
        //        getCountriesAPI.fetchCountryList()
    }
    
    func setDropDownView(_ view: UIView) {
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.layer.borderWidth = 1
    }
    
    func setTapRecognizer(_ view: UIView) {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tap(_:))))
        view.isUserInteractionEnabled = true
        
    }
    
    // function which is triggered when handleTap is called
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        let tag = gestureRecognizer.view?.tag
        switch tag! {
        case 1 :
            selectedDropdown = 0
            getCountriesAPI.fetchCountryList()
        case 2 :
            selectedDropdown = 1
            getCitiesAPI.fetchCityList()
            initializePicker(cityDropDownView)
        case 3 :
            selectedDropdown = 2
            initializePicker(mosqueDropDownView)
        default:
            print("default")
        }
    }
    
    func initializePicker(_ view: UIView) {
        picker = UIPickerView.init()
        picker.alpha = 0
        picker.dataSource = self
        picker.delegate = self
        UIView.animate(withDuration: 0.3, animations: {
            self.picker.alpha = 1
        })
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolbar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolbar.isTranslucent = true
        toolbar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolbar)
    }
    
    @objc func onDoneButtonTapped() {
        toolbar.removeFromSuperview()
        picker.removeFromSuperview()
        
        switch selectedDropdown {
        case 0:
            countryDropdownLabel.text = pickerData[picker.selectedRow(inComponent: 0)]
        case 1:
            cityDropdownLabel.text = pickerData[picker.selectedRow(inComponent: 0)]
        case 2:
            mosqueDropdownLabel.text = pickerData[picker.selectedRow(inComponent: 0)]
        default:
            countryDropdownLabel.text = "Select Country"
            cityDropdownLabel.text = "Select City"
            mosqueDropdownLabel.text = "Select Mosque"
        }
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension CountrySelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch selectedDropdown {
        case 0:
            countryDropdownLabel.text = pickerData[row]
        case 1:
            cityDropdownLabel.text = pickerData[row]
        case 2:
            mosqueDropdownLabel.text = pickerData[row]
        default:
            countryDropdownLabel.text = "Select Country"
            cityDropdownLabel.text = "Select City"
            mosqueDropdownLabel.text = "Select Mosque"
        }
    }
}

//MARK: - GetCountriesAPIDelegate

extension CountrySelectionViewController: GetCountriesAPIDelegate {
    
    func didObtainCountries(countryResponse: CountryModel) {
        DispatchQueue.main.async {
            self.initializePicker(self.countryDropDownView)
            self.pickerData.removeAll()
            for country in countryResponse.ResultSet {
                self.pickerData.append(country.COUNTRY_NAME)
            }
            self.picker.reloadAllComponents()
        }
    }
    
    func didFailToObtainCountriesError(error: Error) {
        print(error)
    }
}

//MARK: - GetCitiesAPIDelegate

extension CountrySelectionViewController: GetCitiesAPIDelegate {
    
    func didObtainCities(cityResponse: CityModel) {
        DispatchQueue.main.async {
            self.pickerData.removeAll()
            for city in cityResponse.ResultSet {
                self.pickerData.append(city.CITY_NAME)
            }
            self.picker.reloadAllComponents()
        }
    }
    
    func didFailToObtainCitiesError(error: Error) {
        print(error)
    }
}
