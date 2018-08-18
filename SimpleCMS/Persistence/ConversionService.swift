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
    
    // MARK: - Initializers and variables
    private init() {}
    static let service = ConversionService()
    let database = DatabaseService.service
    
    // MARK: - Public methods
    func getAllHeritageViewModels() -> [HeritageViewModel] {
        let artefacts = convertToArtefactViewModel(with: database.getAllArtefacts())
        let monuments = convertToMonumentViewModel(with: database.getAllMonuments())
        let publications = convertToPublicationViewModel(with: database.getAllPublications())
        let finds = convertToFindViewModel(with: database.getAllFinds())
        var viewModels = [HeritageViewModel]()
        viewModels.append(contentsOf: artefacts)
        viewModels.append(contentsOf: monuments)
        viewModels.append(contentsOf: publications)
        viewModels.append(contentsOf: finds)
        return viewModels
    }
    
    func convertToObject<T: Object>(_ object: T, with viewModel: HeritageViewModel){
        switch (viewModel) {
        case let viewModel as ArtefactViewModel:
            convertFromArtefactViewModel(to: object as! Artefact, with: viewModel)
        case let viewModel as MonumentViewModel:
            convertFromMonumentViewModel(to: object as! Monument, with: viewModel)
        case let viewModel as FindViewModel:
            convertFromFindViewModel(to: object as! MetalDetectingFind, with: viewModel)
        case let viewModel as PublicationViewModel:
            convertFromPublicationViewModel(to: object as! Publication, with: viewModel)
        default:
            print("Error: this viewmodel doesn't exist!")
        }
        
    }
    
    // MARK: - Private converter methods
    
    private func convertToArtefactViewModel(with artefacts: Results<Artefact>) -> [ArtefactViewModel] {
        var artefactViewModels = [ArtefactViewModel]()
        for artefact in artefacts {
            let artefactModel = ArtefactViewModel(id: artefact.objectId, name: artefact.name, artefactType: artefact.objectType, pictureURL: artefact.photo, acquisitionSource: artefact.acquistionSource, acquisitionMethod: artefact.acquisitionMethod, acquisitionDate: artefact.acquistionDate, rightsLicense: artefact.rightsStatus, creditLine: artefact.creditLine, creator: artefact.creator, creationPlace: artefact.placeOfCreation, creationDate: artefact.dateOfCreation, creationPeriod: artefact.period, material: artefact.usedMaterial, description: artefact.description, size: nil)
            artefactModel.primaryKey = artefact.primaryKey
            artefactViewModels.append(artefactModel)
            
        }
        return artefactViewModels
    }
    
    private func convertToMonumentViewModel(with monuments: Results<Monument>) -> [MonumentViewModel] {
        var monumentViewModels = [MonumentViewModel]()
        for monument in monuments {
            let monumentModel = MonumentViewModel(id: monument.monumentId, name: monument.name, monumentType: monument.monumentType, pictureURL: monument.photo, protection: monument.isProtected, municipality: monument.location ?? "", street: nil, houseNumber: nil, postalCode: nil, license: monument.rightsStatus, creditLine: monument.creditLine, creator: monument.creator, period: monument.period, style: monument.style)
            monumentModel.primaryKey = monument.primaryKey
            monumentViewModels.append(monumentModel)
        }
        return monumentViewModels
    }
    
    private func convertToPublicationViewModel(with publications: Results<Publication>) -> [PublicationViewModel] {
        var publicationViewModels = [PublicationViewModel]()
        for publication in publications {
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
            let publicationModel = PublicationViewModel(id: publication.publicationId, author: publication.author, title: publication.author, pictureURL: publication.photo, acquisitionMethod: publication.method, acquisitionSource: publication.source, acquisitionDate: publication.date, rightsLicense: publication.rightsStatus, creditLine: publication.creditLine, publisher: publication.publisher, publicationDate: publication.yearOfPublication, publicationPlace: publication.placeOfPublication, numberOfPages: pages, edition: edition)
            publicationModel.primaryKey = publication.primaryKey
            publicationViewModels.append(publicationModel)
        }
        return publicationViewModels
    }
    
    private func convertToFindViewModel(with finds: Results<MetalDetectingFind>) -> [FindViewModel] {
        var findViewModels = [FindViewModel]()
        for find in finds {
            let findModel = FindViewModel(id: find.findId, name: find.name, objectType: find.objectType, pictureURL: find.photo, findPlaceType: find.findPlaceType, findPlace: find.location, inscription: find.inscription)
            findModel.primaryKey = find.primaryKey
            findViewModels.append(findModel)
        }
        return findViewModels
    }
    
    private func convertFromArtefactViewModel(to object: Artefact, with viewModel: ArtefactViewModel) {
        object.objectId = viewModel.id
        object.objectType = viewModel.artefactType
        object.name = viewModel.name
        object.photo = viewModel.pictureURL
        object.acquisitionMethod = viewModel.acquisitionMethod!
        object.acquistionDate = viewModel.acquisitionDate!
        object.acquistionSource = viewModel.acquisitionSource!
        object.rightsStatus = viewModel.rightsLicense
        object.creditLine = viewModel.creditLine
        object.creator = viewModel.creator
        object.dateOfCreation = viewModel.creationDate
        object.placeOfCreation = viewModel.creationPlace
        object.period = viewModel.creationPeriod
        object.objectDescription = viewModel.description
        object.usedMaterial = viewModel.material
        print(object.creator!)
        print(viewModel.creator!)
    }
    
    private func convertFromMonumentViewModel(to object: Monument, with viewModel: MonumentViewModel) {
        object.monumentId = viewModel.id
        object.name = viewModel.name
        object.monumentType = viewModel.monumentType
        object.isProtected = viewModel.isProtected
        object.photo = viewModel.pictureURL
        object.location = viewModel.monumentLocationMunicipality
        object.rightsStatus = viewModel.rightsLicense
        object.creditLine = viewModel.creditLine
        object.creator = viewModel.creator
        object.period = viewModel.period
        object.objectDescription = viewModel.description
        object.style = viewModel.style
        object.material = viewModel.material
    }
    
    private func convertFromFindViewModel(to object: MetalDetectingFind, with viewModel: FindViewModel) {
        object.findId = viewModel.id
        object.name = viewModel.name
        object.objectType = viewModel.objectType
        object.photo = viewModel.pictureURL
        object.findPlaceType = viewModel.findPlaceType
        object.location = viewModel.findPlace
        object.material = viewModel.material
        object.technique = viewModel.technique
        object.inscription = viewModel.inscription
        object.objectDescription = viewModel.description
    }
    
    private func convertFromPublicationViewModel(to object: Publication, with viewModel: PublicationViewModel) {
        object.publicationId = viewModel.id
        object.title = viewModel.name
        object.author = viewModel.author
        object.photo = viewModel.pictureURL
        object.method = viewModel.acquisitionMethod!
        object.date = viewModel.acquisitionDate!
        object.source = viewModel.acquisitionSource!
        object.rightsStatus = viewModel.rightsLicense
        object.creditLine = viewModel.creditLine
        object.publisher = viewModel.publisher
        object.placeOfPublication = viewModel.publicationPlace
        object.yearOfPublication = viewModel.publicationDate
        object.shortDescription = viewModel.description
        object.numberOfPages.value = viewModel.numberOfPages
        object.edition.value = viewModel.edition
    }
   
}
