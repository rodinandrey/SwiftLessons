import Foundation

enum actions{
    case loadCargo(cargoVolume: Int)
    case unloadCargo
    case startEngine
    case stopEngine
    case toggleWindows
    case toggleRoof
    case info
}

class Car {
    
    let model: String
    let yearManufacture: Int
    var engineStatus: Bool // двигатель включен/выключен
    var engineStatusInfo: String {
        return (self.engineStatus) ? "Двигатель включен" : "Двигатель выключен"
    }
    var windowStatus: Bool // окна открыты/закрыты
    var windowStatusInfo: String {
        return (self.windowStatus) ? "Окна открыты" : "Окна закрыты"
    }
    init(model: String, yearManufacture: Int) {
        self.model = model
        self.yearManufacture = yearManufacture
        engineStatus = false
        windowStatus = false
    }
    
    func doAction(_ action: actions){
        switch action {
        case .startEngine:
            self.startEngine()
        case .stopEngine:
            self.stopEngine()
        case .toggleWindows:
            self.toggleWindows()
        case .info:
            self.info()
        default:
            print("Невозможно выполнить действие")
        }
    }
    
    
    func startEngine(){
        if !self.engineStatus {
            self.engineStatus = true
        }
    }
    
    func stopEngine(){
        if self.engineStatus {
            self.engineStatus = false
        }
    }
    
    func toggleWindows(){
        self.windowStatus = !self.windowStatus
    }
    
    func info(){
        print("Модель автомобиля: \(self.model)")
        print("Год выпуска: \(self.yearManufacture)")
        print(self.engineStatusInfo)
        print(self.windowStatusInfo)
    }
}


class  CabrioletCar: Car{
    var roofStatus: Bool = false;
    var roofStatusInfo: String {
        return (self.roofStatus) ? "Крыша открыта" : "Крыша закрыта"
    }
    init(model: String, yearManufacture: Int, roofStatus: Bool) {
        self.roofStatus = roofStatus
        super.init(model: model, yearManufacture: yearManufacture)
    }
    
    override func doAction(_ action: actions) {
        switch action {
        case .toggleRoof:
            self.toggleRoof()
        default:
            super.doAction(action)
        }
    }
    
    func toggleRoof(){
        self.roofStatus = !self.roofStatus
    }
    
    override func info(){
        super.info()
        print("Крыша: \(self.roofStatusInfo)")
    }
    
}

class TrunkCar: Car {
    let capacityTotal: Int
    var cargoVolume: Int {
        didSet {
            if(self.cargoVolume > self.capacityTotal){
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
    
    init(model: String, yearManufacture: Int, capacityTotal: Int) {
        self.capacityTotal = capacityTotal
        self.cargoVolume = 0;
        super.init(model: model, yearManufacture: yearManufacture)
    }
    
    func loadCargo(cargoVolume: Int){
        if cargoVolume <= self.capacityFree {
            self.cargoVolume = cargoVolume
            print("Груз загружен")
        } else {
            print("Не возможно загрузить груз")
        }
    }
    
    func unloadCargo(){
        if self.cargoVolume > 0 {
            self.cargoVolume = 0
        }
        print("Груз разгружен")
    }
    
    override func doAction(_ action: actions) {
        switch action {
        case let .loadCargo(cargoVolume):
            self.loadCargo(cargoVolume: cargoVolume)
        case .unloadCargo:
            self.unloadCargo()
        default:
            super.doAction(action)
        }
    }
    
    override func info(){
        super.info()
        print("Объем багажника: \(self.capacityTotal)")
        print("Свободный объем багажника: \(self.capacityFree)")
    }
}

var car1 = TrunkCar(model: "Honda", yearManufacture: 2014, capacityTotal: 100)
car1.doAction(.loadCargo(cargoVolume: 50))
car1.doAction(.startEngine)
car1.doAction(.info)


var car2 = CabrioletCar(model: "Honda", yearManufacture: 2014, roofStatus: true)
car2.doAction(.loadCargo(cargoVolume: 50))
car2.doAction(.toggleRoof)
car2.doAction(.info)

