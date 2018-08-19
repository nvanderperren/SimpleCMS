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
        let images = [UIImage(named:"armband"), UIImage(named:"munitie"), UIImage(named:"boek"), UIImage(named: "schilderij"), UIImage(named: "kalimba")]
        var paths = [String]()
        
        for image in images {
            if let image = image {
                let path = saveImage(image)
                paths.append(path)
            }
            
        }
        
        let item1 = ArtefactViewModel(id: "TILE1", name: "armband", artefactType: "Sierraad", pictureURL: paths[0], acquisitionSource: "Ikzelf", acquisitionMethod: "Aankoop", acquisitionDate: "24 januari 2016", rightsLicense: "Verweesd werk", creditLine: "een verweesd werk", creator: "Linda Vandervorst", creationPlace: "Melsbroek", creationDate: nil, creationPeriod: nil, material: nil, description: "een armband", length: nil, lengthUnit: nil, width: nil, widthUnit: nil, depth: nil, depthUnit: nil)
        let item2 = FindViewModel(id: "TILE2", name: "munitie", objectType: "Bijl", pictureURL: paths[1], findPlaceType: nil, findPlace: nil, inscription: nil, description: nil, period: nil, technique: nil, length: nil, lengthUnit: nil, width: nil, widthUnit: nil, depth: nil, depthUnit: nil, acquisitionSource: nil, acquisitionMethod: nil, acquisitionDate: nil)
        let item3 = PublicationViewModel(id: "TILE3", author: "Nastasia Vanderperren", title: "een mooi booek", pictureURL: paths[2], acquisitionMethod: "Schenking", acquisitionSource: "Mijn mama", acquisitionDate: "25 februari 2001", rightsLicense: "Copyright niet geëvalueerd", creditLine: "geen idee", publisher: nil, publicationDate: nil, publicationPlace: nil, numberOfPages: nil, edition: nil, genre: nil)
        let item4 = ArtefactViewModel(id: "TILE4", name: "een schilderij", artefactType: "Schilderij", pictureURL: paths[3], acquisitionSource: "museum", acquisitionMethod: "Schenking", acquisitionDate: "22 augustus 1987", rightsLicense: "Geen copyright (CC0)", creditLine: "gebruik het maar!", creator: nil, creationPlace: nil, creationDate: nil, creationPeriod: nil, material: nil, description: nil)
        let item5 = ArtefactViewModel(id: "TILE5", name: "Trompet", artefactType: "Muziekinstrument", pictureURL: paths[4], acquisitionSource: "de fanfare", acquisitionMethod: "Aankoop", acquisitionDate: "23 juli 1996", rightsLicense: "In copyright", creditLine: "hier staat iets", creator: nil, creationPlace: nil, creationDate: nil, creationPeriod: nil, material: nil, description: nil)
        item1.primaryKey = UUID().uuidString
        item2.primaryKey = UUID().uuidString
        item3.primaryKey = UUID().uuidString
        item4.primaryKey = UUID().uuidString
        item5.primaryKey = UUID().uuidString
        DatabaseService.service.create(item1)
        DatabaseService.service.create(item2)
        DatabaseService.service.create(item3)
        DatabaseService.service.create(item4)
        DatabaseService.service.create(item5)
        
        return [item1, item2, item3, item4, item5]
        
    }
    
    private func saveImage(_ image:UIImage) -> String {
        let fileManager = FileManager.default
        let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let imagePath = documentsPath?.appendingPathComponent("\(UUID().uuidString).jpg")
        do {
            try UIImageJPEGRepresentation(image, 1.0)?.write(to: imagePath!)
            let path = imagePath!.absoluteString
            return path
        } catch {
            print(error)
        }
        return ""
        
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
    
    func getObjectTypes() -> [String] {
        return [
            "Affiche",
            "Kaart",
            "Prent",
            "Boek",
            "Strip",
            "Plan",
            "Bidprent",
            "Scheepsuitrusting",
            "Meubilair",
            "Speelgoed",
            "Wapen",
            "Muziekinstrument",
            "Huisraad",
            "Pot",
            "Bord",
            "Vaas",
            "Vloertegel",
            "Geveltegel",
            "Tegeltableau",
            "Beeldhouwwerk",
            "Schilderij",
            "Tekening",
            "Foto",
            "Glasnegatief",
            "Dia",
            "Sierraad",
            "Troffee",
            "Munt",
            "Medaille",
            "Zegel",
            "Kledingstuk",
            "Kostuum",
            "Vaandel"
        ]
    }
    
    func getMaterials() -> [String] {
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
    
    func getRightsLicenses() -> [String] {
        return [
            "Kies status",
            "Copyright niet geëvalueerd",
            "Copyright onbekend",
            "Geen copyright vastgesteld",
            "Rechthebbende onbekend",
            "Verweesd werk",
            "In copyright",
            "Geen copyright (CC0)",
            "Publiek domein"
        ]
        
    }
    
    func getTechniques() -> [String] {
        return [
            "Kies techniek",
            "Gesmeed",
            "gegoten",
            "gehamerd",
            "geslagen"
        ]
    }
    
    func getGenres() -> [String] {
        return [
            "Abele spelen",
            "Allegorieën",
            "Alternatieve geschiedenis",
            "Balladen",
            "Bloemlezingen",
            "Briefromans",
            "Brieven",
            "Cartoons",
            "Chicklit",
            "Columns",
            "Comics",
            "Commedia dell'arte",
            "Cursiefjes",
            "Dagboeken",
            "Detectives",
            "Dialogen",
            "Dierenverhalen",
            "Doktersromans",
            "Eenakters",
            "Epigrammen",
            "Erotische literatuur",
            "Essays",
            "Experimenteel theater",
            "Fabels",
            "Familiekronieken",
            "Fantasy",
            "Filmscenario’s",
            "Gelegenheidspoëzie",
            "Graphic novels",
            "Graphic poetry",
            "Griezelliteratuur",
            "Groteletterboeken",
            "Haiku's",
            "Historische detectives",
            "Historische fantasy",
            "Historische literatuur",
            "Historische thrillers",
            "Holebiliteratuur",
            "Hoorspelen",
            "Humoristische literatuur",
            "Ideeënliteratuur",
            "Juridische thrillers",
            "Kluchten",
            "Komedies",
            "Kwatrijnen",
            "Limericks",
            "Literaire stripverhalen",
            "Luisterboeken",
            "Makkelijk lezen",
            "Manga’s",
            "Medische thrillers",
            "Monologen",
            "Musicals",
            "Nonsenspoëzie",
            "Novellen",
            "Ontwikkelingsromans",
            "Oorlogspoëzie",
            "Oorlogsromans",
            "Parabels",
            "Parodieën",
            "Poëziebundels",
            "Polemieken",
            "Politieke literatuur",
            "Prehistorische fantasy",
            "Prozagedichten",
            "Psychologische detectives",
            "Psychologische literatuur",
            "Psychologische thrillers",
            "Rappoëzie",
            "Reisverhalen",
            "Ridderromans",
            "Road novels",
            "Robinsonades",
            "Romans",
            "Romantische literatuur",
            "Rondelen",
            "Satiren",
            "Schelmenromans",
            "Sciencefiction",
            "Slam poetry",
            "Sociale literatuur",
            "Sonnetten",
            "Spionageromans",
            "Sportliteratuur",
            "Sprookjes",
            "Stadslegenden",
            "Stadsromans",
            "Steampunk",
            "Streek- en familieromans",
            "Stripverhalen",
            "Tanka's",
            "Theaterteksten",
            "Thrillers",
            "Toekomstromans",
            "Tragedies",
            "Tragikomedies",
            "Utopische/dystopische literatuur",
            "Verfilmde boeken",
            "Verhalen",
            "Visuele poëzie",
            "Volkstheater",
            "Volksverhalen",
            "Vrouwenliteratuur",
            "Waargebeurd",
            "Westerns",
            "Zedenschetsen"
        ]
    
    }
    
    func getMonumentStyles() -> [String] {
        return [
            "Art deco",
            "Art nouveau",
            "Barok",
            "Brutalisme",
            "Classicerend barok",
            "Classicisme",
            "Cottagestijl",
            "Empire",
            "High tech",
            "Integratiearchitectuur",
            "Modernisme",
            "Beaux-artsstijl",
            "Eclecticisme",
            "Neo-Egyptisch",
            "Neo-empire",
            "Neo-Vlaamserenaissance-stijl",
            "Neobarok",
            "Neobyzantijns",
            "Neoclassicisme",
            "Neogotiek",
            "Neomoors",
            "Neorenaissance",
            "Neorococo",
            "Neoromaans",
            "Neotraditioneel",
            "Organische architectuur",
            "Postmodernisme",
            "Regionalisme",
            "Renaissance",
            "Rococo",
            "Romaans",
            "Traditioneel"
        ]
    }
    
    func getMonumentTypes() -> [String] {
        return [
            "Appartement",
            "Boerderij",
            "Hotel",
            "Woonhuis",
            "Woonboot",
            "Bungalow",
            "Hut",
            "Mijningang",
            "Baken",
            "Golfbreker",
            "Brug",
            "Schoorsteen",
            "Kraan",
            "Dijk",
            "Vlaggenmast",
            "Dam",
            "Vuurtoren",
            "Mijnschacht",
            "Obelisk",
            "Steiger",
            "Silo",
            "Toren",
            "Watermolen",
            "Watertoren",
            "Waterput",
            "Windmolen",
            "Fabriek",
            "Kantoorgebouw",
            "Industriegebouw",
            "Winkel",
            "Warenhuis",
            "Kiosk",
            "Bakkerij",
            "School",
            "Ziekenhuis",
            "Stadion",
            "Treinstation",
            "Universiteit",
            "Zwembad",
            "Bibliotheek",
            "Gemeentehuis",
            "Kathedraal",
            "Kapel",
            "Kerk",
            "Moskee",
            "Tempel",
            "Synagoge",
            "Altaar",
            "Bunker",
            "Garage",
            "Serre",
            "Hangar",
            "Parking",
            "Pavilioen",
            "Stal",
            "Ruïne"
        ]
    }
    
    
    
}
