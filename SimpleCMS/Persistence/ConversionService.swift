//
//  ConversionService.swift
//  SimpleCMS
//
//  Created by Nastasia Vanderperren on 16/08/18.
//  Copyright © 2018 Nastasia Vanderperren. All rights reserved.
//

import Foundation
import RealmSwift

class ConversionService {
    private init() {}
    static let service = ConversionService()
    let database = DatabaseService.service
    
    func getAllHeritageViewModels() -> [HeritageViewModel] {
        var viewModels = [HeritageViewModel]()
        let artefacts = convertToArtefactViewModel(with: database.getAllArtefacts())
        for monument in Array(database.getAllMonuments()) {
            viewModels.append(MonumentViewModel(id: monument.monumentId, name: monument.name, monumentType: monument.monumentType, pictureURL: monument.photo, protection: monument.isProtected, municipality: monument.location ?? "", street: nil, houseNumber: nil, postalCode: nil, license: monument.rightsStatus, creditLine: monument.creditLine, creator: monument.creator, period: monument.period, style: monument.style))
        }
        for publication in Array(database.getAllPublications()) {
            let pages: String?
            if let numberOfPages = publication.numberOfPages.value{
                pages = String(numberOfPages)
            } else {
                pages = nil
            }
            let edition: String?
            if let publicationEdition = publication.edition.value {
                edition = String(publicationEdition)
            }
            else {
                edition = nil
            }
            viewModels.append(PublicationViewModel(id: publication.publicationId, author: publication.author, title: publication.author, pictureURL: publication.photo, acquisitionMethod: publication.method, acquisitionSource: publication.source, acquisitionDate: publication.date, rightsLicense: publication.rightsStatus, creditLine: publication.creditLine, publisher: publication.publisher, publicationDate: publication.yearOfPublication, publicationPlace: publication.placeOfPublication, numberOfPages: pages, edition: edition))
        }
        for find in Array(database.getAllFinds()) {
            viewModels.append(FindViewModel(id: find.findId, name: find.name, objectType: find.objectType, pictureURL: find.photo, findDate: find.findDate, findPlaceType: find.findPlaceType, findPlace: find.location, inscription: find.inscription))
        }
        
        return viewModels
    }
    
    func convertToArtefactViewModel(with artefacts: Results<Artefact>) -> [ArtefactViewModel] {
        var viewModels = [ArtefactViewModel]()
        for artefact in artefacts {
            viewModels.append(ArtefactViewModel(id: artefact.objectId, name: artefact.name, artefactType: artefact.objectType, pictureURL: artefact.photo, acquisitionSource: artefact.source, acquisitionMethod: artefact.method, acquisitionDate: artefact.date, rightsLicense: artefact.rightsStatus, creditLine: artefact.creditLine, creator: artefact.creator, creationPlace: artefact.placeOfCreation, creationDate: artefact.dateOfCreation, creationPeriod: artefact.period, size: nil))
        }
        return viewModels
    }
    
   
}
