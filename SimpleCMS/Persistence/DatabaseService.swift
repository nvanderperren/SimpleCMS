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
    
    // MARK: - Create
    
    func create(_ model: HeritageViewModel){
        switch(model) {
        case let model as ArtefactViewModel:
            createArtefact(model)
        case let model as PublicationViewModel:
            createPublication(model)
        case let model as FindViewModel:
            createFind(model)
        case let model as MonumentViewModel:
            createMonument(model)
        default:
            print("error, this viewmodel doesn't exist")
        }
        
    }
    
    // MARK: - Update & Delete
    
    func update(_ model: HeritageViewModel, with method: updateMethod) {
        switch(model){
        case let model as ArtefactViewModel:
            let artefact = getAllArtefacts().filter{$0.primaryKey == model.primaryKey}.first
            if let artefact = artefact {
                switch (method){
                case .update:
                    updateObject(artefact, with: model)
                case .delete:
                    deleteObject(artefact)
                }
                
            }
        case let model as MonumentViewModel:
            let monument = getAllMonuments().filter{$0.primaryKey == model.primaryKey}.first
            if let monument = monument {
                switch (method){
                case .update:
                    updateObject(monument, with: model)
                case .delete:
                    deleteObject(monument)
                }
            }
        case let model as FindViewModel:
            let find = getAllFinds().filter{$0.primaryKey == model.primaryKey}.first
            if let find = find {
                switch (method){
                case .update:
                    updateObject(find, with: model)
                case .delete:
                    deleteObject(find)
                }
            }
        case let model as PublicationViewModel:
            let publication = getAllPublications().filter{$0.primaryKey == model.primaryKey}.first
            if let publication = publication {
                switch (method){
                case .update:
                    updateObject(publication, with: model)
                case .delete:
                    deleteObject(publication)
                }
            }
        default:
            print("Error: this viewmodel does not exist")
        }
    }
    
    // MARK: - Get methods
    
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
    
    // MARK: - Private methdos
    
    // MARK: Private create methods
    private func createArtefact(_ model: ArtefactViewModel){
        
        var objectDimensions = [ObjectDimension]()
        
        if let sizeLength = model.sizeLength {
            let value = Double(sizeLength)
            if let value = value {
                objectDimensions.append(ObjectDimension(dimensionType: ObjectDimensionType.length.rawValue, value: value, unit: model.sizeLengthUnit!))

            }
        }
        
        if let sizeWidth = model.sizeWidth {
            let value = Double(sizeWidth)
            if let value = value {
                objectDimensions.append(ObjectDimension(dimensionType: ObjectDimensionType.width.rawValue, value: value, unit: model.sizeWidthUnit!))
            }
            
        }
        
        if let sizeDepth = model.sizeDepth {
            let value = Double(sizeDepth)
            if let value = value {
                objectDimensions.append(ObjectDimension(dimensionType: ObjectDimensionType.depth.rawValue, value: value, unit: model.sizeDepthUnit!))

            }
        }
        
        let artefact = Artefact(objectId: model.id, objectType: model.artefactType, name: model.name, photo: model.pictureURL, acquisitionMethod: model.acquisitionMethod!, acquisitionDate: model.acquisitionDate!, acquisitionSource: model.acquisitionSource!, depositPlace: nil, rightsStatus: model.rightsLicense, creditLine: model.creditLine, creator: model.creator, placeOfCreation: model.creationPlace, dateOfCreation: model.creationDate, period: model.creationPeriod, description: model.description, material: model.material, dimensions: objectDimensions)
        artefact.primaryKey = model.primaryKey
        print(artefact.primaryKey)
        saveObject(artefact)
    }
    
    private func createMonument(_ model: MonumentViewModel){
        let monument = Monument(monumentId: model.id, name: model.name, type: model.monumentType, isProtected: model.isProtected, photo: model.pictureURL, location: model.monumentLocationMunicipality, rightsStatus: model.rightsLicense, creditLine: model.creditLine, creator: model.creator, period: model.period, description: model.description, style: model.style, material: model.material)
        monument.primaryKey = model.primaryKey
        print(monument.primaryKey)
        saveObject(monument)
        
    }
    
    private func createFind(_ model: FindViewModel){
        
        var objectDimensions = [ObjectDimension]()
        
        if let sizeLength = model.sizeLength {
            let value = Double(sizeLength)
            if let value = value {
                objectDimensions.append(ObjectDimension(dimensionType: ObjectDimensionType.length.rawValue, value: value, unit: model.sizeLengthUnit!))
                
            }
        }
        
        if let sizeWidth = model.sizeWidth {
            let value = Double(sizeWidth)
            if let value = value {
                objectDimensions.append(ObjectDimension(dimensionType: ObjectDimensionType.width.rawValue, value: value, unit: model.sizeWidthUnit!))
            }
            
        }
        
        if let sizeDepth = model.sizeDepth {
            let value = Double(sizeDepth)
            if let value = value {
                objectDimensions.append(ObjectDimension(dimensionType: ObjectDimensionType.depth.rawValue, value: value, unit: model.sizeDepthUnit!))
                
            }
        }
        
        let find = MetalDetectingFind(findId: model.id, name: model.name, objectType: model.objectType, photo: model.pictureURL, findPlaceType: model.findPlaceType, location: model.findPlace, material: model.material, technique: model.technique, inscription: model.inscription, description: model.description, period: model.period, objectDimensions: objectDimensions, acquisitionMethod: model.acquisitionMethod, acquisitionDate: model.acquisitionDate, acquisitionSource: model.acquisitionSource)
        find.primaryKey = model.primaryKey
        print(find.primaryKey)
        saveObject(find)
    }
    
    private func createPublication(_ model: PublicationViewModel) {
        let publication = Publication(publicationId: model.id, title: model.name, author: model.author, photo: model.pictureURL, acquisitionMethod: model.acquisitionMethod!, acquisitionDate: model.acquisitionDate!, acquisitionSource: model.acquisitionSource!, depositPlace: nil, rightsLicense: model.rightsLicense, creditLine: model.creditLine, publisher: model.publisher, placeOfPublication: model.publicationPlace, yearOfPublication: model.publicationDate, genre: nil, shortDescription: model.description, numberOfPages: model.numberOfPages, edition: model.edition)
        publication.primaryKey = model.primaryKey
        print(publication.primaryKey)
        saveObject(publication)
    }
    
    // MARK: Private save and update methods
    
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
    
    private func updateObject<T: Object>(_ object: T, with model: HeritageViewModel){
        do {
            try realm.write {
                ConversionService.service.convertToObject(object, with: model)
                print(model.id)
                print("object updated")
            }
        } catch {
            print("error")
        }
    }
    
    private func deleteObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
                print("object removed")
            }
        } catch {
            print(error)
        }
    }
    
}

enum updateMethod {
    case delete
    case update
}

