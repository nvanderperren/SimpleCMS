//
//  Seeder.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 3/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import UIKit

struct Seeder {
    
    private init(){}
    static let service = Seeder()
    
    func getHeritageObjects() -> [HeritageViewModel] {
        let item1 = HeritageViewModel(id: "TILE1", name: "armband", category: HeritageObjectCategory.metalDetectingFind.rawValue)
        let item2 = HeritageViewModel(id: "TILE2", name: "munitie", category: HeritageObjectCategory.metalDetectingFind.rawValue)
        let item3 = HeritageViewModel(id: "TILE3", name: "een oud boek", category: HeritageObjectCategory.publication.rawValue)
        let item4 = HeritageViewModel(id: "TILE4", name: "een schilderij", category: HeritageObjectCategory.artefact.rawValue)
        let item5 = HeritageViewModel(id: "TILE5", name: "een muziekinstrument", category: HeritageObjectCategory.artefact.rawValue)
        item1.picture = UIImage(named:"armband")
        item2.picture = UIImage(named:"munitie")
        item3.picture = UIImage(named:"boek")
        item4.picture = UIImage(named: "schilderij")
        item5.picture = UIImage(named: "kalimba")
        return [item1, item2, item3, item4, item5] + ConversionService.service.getAllHeritageViewModels()
        
    }
    
    func getHeritagePlaceTypes() -> [String] {
        return [
            "Kies type",
            "Akker",
            "Gestorte grond",
            "Strand",
            "Tuin of erf",
            "Weide",
            "Andere"
        ]
    }
    
    func getFindObjectTyptes() -> [String] {
        return [
            "Armband",
            "Baar",
            "Balansonderdeel",
            "Bijl",
            "Bit",
            "Boekbeslag",
            "Decoratief onderdeel van paardentuig",
            "Gesp(onderdeel)",
            "Geweerkogel",
            "Gewicht",
            "Halsring of -ketting",
            "Hanger",
            "Harnasonderdeel",
            "Helm",
            "Hengsel/handvat",
            "Hoefijzer",
            "Insigne",
            "Kandelaar (of onderdeel)",
            "Kledinghaak",
            "Knoop",
            "Lakenloodje",
            "Lepel",
            "Mantelspeld",
            "Mes",
            "Meubelbeslag",
            "Munitie",
            "Munt",
            "Muntgewicht",
            "Musketkogel",
            "Muziekinstrument",
            "Onbekend",
            "Overig gereedschap",
            "Pelgrimsampul",
            "Pijlpunt",
            "Pincet",
            "Rekenpenning",
            "Riem- en leerbeslag",
            "Riemtong",
            "Schedebeslag",
            "Schildknop",
            "Sleutel",
            "Slot (of onderdeel)",
            "Speelgoed",
            "Speelstuk",
            "Speerpunt",
            "Speld/naald",
            "Spoor",
            "Stijgbeugel",
            "Stylus",
            "Vaatwerk",
            "Vingerhoed",
            "Vingerring",
            "Vuurwapenonderdeel of -accessoire",
            "Zegelstempel",
            "Zwaard(onderdeel)",
            "Andere"
        ]
        
    }
    
    func getPeriods() -> [String] {
        return [
            "Kies periode",
            "Bronstijd",
            "Ijzertijd",
            "Romeins",
            "Vroege middeleeuwen (500-1000)",
            "Middeleeuwen (1000-1500)",
            "Renaissance (1500-1600)",
            "Vroegmoderne tijd (1600-1800)",
            "Industrialisatie (1800-1914)",
            "Wereldoorlog I",
            "Interbellum",
            "WereldOorlog II",
            "1945-1999",
            "Hedendaagse tijd",
            "Onbekend"
        ]
    }
    
    func getAcquisitionMethods() -> [String] {
        return [
            "Kies methode",
            "Aankoop",
            "Bewaargeving",
            "Bruikleen",
            "Overdracht",
            "Schenking"
        ]
    }
    
    func getObjectTypes() -> [String:[String]] {
        return [
            "Drukwerk": [
                "Affiche",
                "Kaart",
                "Prent",
                "Boek",
                "Strip",
                "Plan",
                "Bidprent"
            ],
            "Kunstwerk": [
                "Beeldhouwwerk",
                "Schilderij",
                "Tekening",
                "Foto",
                "Glasnegatief",
                "Dia"
            ],
            "Keramiek": [
                "Pot",
                "Bord",
                "Vaas",
                "Vloertegel",
                "Geveltegel",
                "Tegeltableau"
            ],
            "Smeedwerk": [
                "Sierraad",
                "Troffee",
                "Munt",
                "Medaille",
                "Zegel"
            ],
            "Textiel": [
                "Kledingstuk",
                "Kostuum",
                "Vaandel"
            ],
            "Gereedschap": [
                "Scheepsuitrusting",
                "Meubilair",
                "Speelgoed",
                "Wapen",
                "Muziekinstrument",
                "Huisraad"
            ]
            
        ]
    }
    
    func getMaterial() -> [String] {
        return [
            "Papier",
            "Perkament",
            "Glas",
            "Porselein",
            "Textiel",
            "Koper",
            "Ijzer",
            "Lood",
            "Tin of loodtin",
            "Goud",
            "Zilver",
            "Gips",
            "Brons",
            "Metaal",
            "Natuursteen",
            "Keramiek",
            "Hout",
            "Inkt",
            "Verf",
            "Potlood",
            "Steengoed",
            "Beton",
            "Cement",
            "Kunststof",
            "Aluminium",
            "Staal",
            "Pleister",
            "Schelp",
            "Bont",
            "Gewei",
            "Hoorn",
            "Leer",
            "Houtskool"     
        ]
    }
    
    
}
