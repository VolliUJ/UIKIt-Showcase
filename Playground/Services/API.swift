
import UIKit
import PromiseKit

protocol API {
    func fetchMarcinProfile() -> Promise<MarcinProfile>
    func fetchMotorbike(name: String) -> Promise<Motorbike?> 
}

struct APIDump : API {
    func fetchMarcinProfile() -> Promise<MarcinProfile> {
        return .value(profile)
    }
    
    func fetchMotorbike(name: String) -> Promise<Motorbike?> {
        let motorbike = motorbikes.first { $0.fullName == name }
        return .value(motorbike)
    }
    
    private var profile: MarcinProfile {
        let details: KeyValuePairs<String, String> = [
            "Favorite food": "Ramen 🍜",
            "Favorite drink": "Yerba Mate 🧉",
            "Favorite movie": "Fast and Furious: Tokyo Drift"
        ]
        
        
        
        return MarcinProfile(name: "Marcin Golli",
                             role: "Senior iOS Developer",
                             image: UIImage(named: "profile-image-marcin"),
                             details: details,
                             motorbikes: motorbikes)
    }
    
    private var motorbikes: [Motorbike] {
        return [Motorbike(brand: "Yamaha",
                          model: "WR",
                          engine: "125cc 4 stroke",
                          description: "The Yamaha WR is a high-performance motorcycle designed for off-road riding. It features a lightweight and durable frame, a powerful engine, and advanced suspension system that allows for smooth and precise handling on rough terrain. The bike is equipped with a fuel-injected 4-stroke engine that delivers strong and consistent power throughout the rev range, making it ideal for riders who demand performance and reliability. Additionally, the WR comes with a range of advanced features, such as adjustable front and rear suspension, a high-capacity air filter, and a high-output exhaust system, all of which contribute to its exceptional performance and durability. Whether you're an experienced rider looking for a competitive edge or a beginner looking to improve your skills, the Yamaha WR is a top-of-the-line motorcycle that delivers unparalleled performance and reliability in any off-road environment.",
                          image: UIImage(named: "yamaha-wr")),
                Motorbike(brand: "Honda",
                          model: "CRF",
                          engine: "300cc 4 stroke",
                          description: "The Honda CRF 300 is a high-performance dirt bike designed for off-road adventures. It features a lightweight chassis, powerful engine, and advanced suspension system that allows for smooth and precise handling on rough terrain. The bike is equipped with a fuel-injected 4-stroke engine that delivers strong and consistent power throughout the rev range, making it ideal for riders who demand both power and agility. Additionally, the CRF 300 comes with a range of advanced features, such as a slipper clutch, Showa suspension system, and a comfortable seat that allows for long rides without fatigue. With its superior handling, power, and comfort, the Honda CRF 300 is an excellent choice for anyone who wants to push their off-road riding to the next level.",
                          image: UIImage(named: "honda-crf")),
                Motorbike(brand: "Kawasaki",
                          model: "KLX",
                          engine: "250cc 4 stroke",
                          description: "The Kawasaki KLX 250 is a versatile and reliable motorcycle designed for both on-road and off-road adventures. It features a lightweight and agile chassis, powerful engine, and advanced suspension system that allows for smooth and precise handling on any terrain. The bike is equipped with a fuel-injected 4-stroke engine that delivers strong and consistent power throughout the rev range, making it ideal for riders who demand performance and reliability. Additionally, the KLX 250 comes with a range of advanced features, such as adjustable suspension, a digital instrument panel, and a comfortable seat that allows for long rides without fatigue. With its superior handling, power, and comfort, the Kawasaki KLX 250 is an excellent choice for anyone who wants to explore the outdoors or navigate the urban jungle with ease.",
                          image: UIImage(named: "kawasaki-klx")),
                Motorbike(brand: "Yamaha",
                          model: "MT-15",
                          engine: "150cc 4 stroke",
                          description: "The Yamaha MT-15 is a sleek and stylish street bike designed for riders who demand both performance and style. It features a lightweight and agile chassis, powerful engine, and advanced suspension system that allows for smooth and precise handling on any road. The bike is equipped with a fuel-injected 4-stroke engine that delivers strong and consistent power throughout the rev range, making it ideal for riders who enjoy pushing the limits. Additionally, the MT-15 comes with a range of advanced features, such as LED lighting, a digital instrument panel, and a sporty seating position that allows for maximum control and comfort. With its superior handling, power, and style, the Yamaha MT-15 is an excellent choice for anyone who wants to make a statement on the street.",
                          image: UIImage(named: "Yamaha-mt"))]
    }
}

