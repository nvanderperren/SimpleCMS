#  SimpleCMS

## Doel
* collectiemanager kan volgende items registreren
    - erfgoedobjecten
    - publicaties
    - monumenten
* op basis van een vereenvoudigd model van de datamodellen die gecreëerd werden door PACKED vzw
* collectiemanager kan in een lijst zijn erfgoed bekijken
* enkel basisregistratie
* geen cloud: in depots e.d. is er geen wifi + slecht bereik
* exporteren in csv mogelijk maken -> zo importeren in de eigen (toekomstige) databank

## Wat hiervoor nodig?
* UITableView dynamic voor het overzicht van de items
* UITableView fixed voor het invoermodel
* hoe navigatie?

## Interface

### landing page
* dynamische table view met overzicht.
* navigatiebar: + om items toe te voegen, searchbar om items te zoeken en een knop om een selectie te maken
* in ipad een navigationController met aan de ene kant de lijst en aan de andere kant het zicht?

### detail view
* save knop --> kan alleen opslaan als verplichte velden ingevuld zijn
* werken met viewmodels?

## Rechten
* gebruik de licenties van [Rightsstatements.org](http://rightsstatements.org/en/documentation/assets.html)
* maak een table als popover met reusable cel met afkorting van de rightsstatement en uitleg ervan
* *maak deze table mss herbruikbaar zodat die ook voor andere doeleinden gebruikt kan worden, bv. lijsten van materiaal ofzo*

## Datamodel

### erfgoedobjecten
* objectnummer
* objectnaam
* titel
* instellingsnaam
* standplaats?
* korte beschrijving
* materiaal: []
* afmetingen?:
    * eenheid
    * afmeting
    * waarde
* vervaardiger: []
* rechtenstatus
* foto []?
