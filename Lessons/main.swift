import Foundation


enum bodyType: String{
    case truk = "грузовой автомобиль"
    case pickup = "пикап"
    case coupe = "купе"
    case cabriolet = "кабриолет"
    case sedan = "седан"
    case hatchback = "хетчбек"
}

struct Car {
    
    let model: String
    let bodyType: bodyType
    let capacityTotal: Int
    var cargoVolume: Int {
        willSet {
            if(newValue > self.capacityTotal){
                self.cargoVolume = 0
            }
        }
    }
    var capacityFree: Int {
        get {
            return self.capacityTotal - self.cargoVolume
        }
        set {
            if(newValue == 0){
                self.cargoVolume = 0
            }
        }
    }
    
    let yearManufacture: Int
    var engineStatus: Bool // двигатель включен/выключен
    var engineStatusInfo: String {
        return (self.engineStatus) ? "Двигатель включен" : "Двигатель выключен"
    }
    var windowStatus: Bool // окна открыты/закрыты
    var windowStatusInfo: String {
        return (self.windowStatus) ? "Окна открыты" : "Окна закрыты"
    }
    init(model: String, bodyType: bodyType, capacityTotal: Int, yearManufacture: Int) {
        self.model = model
        self.bodyType = bodyType
        self.capacityTotal = capacityTotal
        self.yearManufacture = yearManufacture
        engineStatus = false
        windowStatus = false
        self.cargoVolume = 0;
    }
    
    mutating func startEngine(){
        if !self.engineStatus {
            self.engineStatus = true
        }
    }
    
    mutating func stoptEngine(){
        if self.engineStatus {
            self.engineStatus = false
        }
    }
    
    mutating func toggleWindows(){
        self.windowStatus = !self.windowStatus
    }
    
    mutating func loadCargo(cargoVolume: Int){
        if cargoVolume <= self.capacityFree {
            self.cargoVolume = cargoVolume
            print("Груз загружен")
        } else {
            print("Не возможно загрузить груз")
        }
    }
    
    mutating func unload(){
        if self.cargoVolume > 0 {
            self.cargoVolume = 0
        }
        print("Груз разгружен")
    }
    
    func info(){
        print("Модель автомобиля: \(self.model)")
        print("Год выпуска: \(self.yearManufacture)")
        print("Тип: \(self.bodyType.rawValue)")
        print("Объем багажника/кузоап: \(self.capacityTotal)")
        print("Свободный объем багажника/кузоап: \(self.capacityFree)")
        print(self.engineStatusInfo)
        print(self.windowStatusInfo)
        print("----------------------------")
    }
}

var car1 = Car(model: "Honda", bodyType: bodyType.pickup, capacityTotal: 100, yearManufacture: 2014)
car1.loadCargo(cargoVolume: 50)
car1.startEngine()
car1.info()

var car2 = Car(model: "Ford", bodyType: bodyType.truk, capacityTotal: 200, yearManufacture: 2000)
car2.loadCargo(cargoVolume: 50)
car2.startEngine()
car2.toggleWindows();
car2.info()

var car3 = Car(model: "BMW", bodyType: bodyType.cabriolet, capacityTotal: 0, yearManufacture: 2018)
car3.loadCargo(cargoVolume: 50)
car3.startEngine()
car3.toggleWindows();
car3.info()
