//
//  DatabaseService.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 16/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseService {
    
    private init() {}
    static let service = DatabaseService()
    
    var realm = try! Realm()
    
    // MARK: CreateOperations
    
    func createArtefact(_ model: ArtefactViewModel){
        let artefact = Artefact(objectId: model.id, objectType: model.artefactType, name: model.name, photo: model.pictureURL, acquisitionMethod: model.acquisitionMethod!, acquisitionDate: model.acquisitionDate!, acquisitionSource: model.acquisitionSource!, depositPlace: nil, rightsStatus: model.rightsLicense!, creditLine: model.creditLine!, creator: model.creator, placeOfCreation: model.creationPlace, dateOfCreation: model.creationDate, period: model.creationPeriod, description: model.description, material: model.material, technique: model.technique, dimensions: nil)
        saveObject(artefact)
        
    }
    
    func createMonument(_ model: MonumentViewModel){
        let monument = Monument(monumentId: model.id, name: model.name, type: model.monumentType, isProtected: model.isProtected, photo: model.pictureURL, location: model.monumentLocationMunicipality, rightsStatus: model.rightsLicense!, creditLine: model.creditLine!, creator: model.creator, period: model.period, description: model.description, style: model.style, material: model.material)
        saveObject(monument)
        
    }
    
    func createFind(_ model: FindViewModel){
        let find = MetalDetectingFind(findId: model.id, name: model.name, objectType: model.objectType, photo: model.pictureURL, findDate: model.findDate, findPlaceType: model.findPlaceType, location: model.findPlace, material: model.material, technique: model.technique, inscription: model.inscription, description: model.description, objectDimensions: nil)
        saveObject(find)
    }
    
    func createPublication(_ model: PublicationViewModel) {
        let publication = Publication(publicationId: model.id, title: model.name, author: model.author, photo: model.pictureURL, acquisitionMethod: model.acquisitionMethod!, acquisitionDate: model.acquisitionDate!, acquisitionSource: model.acquisitionSource!, depositPlace: nil, rightsLicense: model.rightsLicense!, creditLine: model.creditLine!, publisher: model.publisher, placeOfPublication: model.publicationPlace, yearOfPublication: model.publicationDate, genre: nil, shortDescription: model.description, numberOfPages: model.numberOfPages, edition: model.edition)
        saveObject(publication)
    }
    
//    func updateArtefact(model: ArtefactViewModel) {
//        var artefact = getAllArtefacts().filter{$0.identification!.id == model.id}.first
//        do {
//            try realm.write {
//                artefact?.identification?.id = model.id
//                artefact?.identification?.name = model.name
//
//            }
//        }
//        catch {
//            print(error)
//        }
//        
//
//    }
    
    
    func delete<T: Object>(object: T) {}
    
    
    
    
    
    
    func getAllArtefacts() -> Results<Artefact> {
        return realm.objects(Artefact.self)
    }
    
    func getAllMonuments() -> Results<Monument> {
        return realm.objects(Monument.self)
    }
    
    func getAllPublications() -> Results<Publication> {
        return realm.objects(Publication.self)
    }
    
    func getAllFinds() -> Results<MetalDetectingFind> {
        return realm.objects(MetalDetectingFind.self)
    }
    
    // MARK: Private methods
    
    private func saveObject<T: Object>(_ object: T){
        do {
            try realm.write {
                realm.add(object)
                print("model is saved")
            }
        } catch {
            print(error)
        }
    }
    
}
