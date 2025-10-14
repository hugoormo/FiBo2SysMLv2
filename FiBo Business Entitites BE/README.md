# Business Entities (FIBO_BE)
## Overview

The FIBO_BE (Business Entities) package family defines the organizational, legal, functional, and governmental structures that underpin all other FIBO domains.
These packages are modeled in SysML v2, closely following the EDM Council FIBO ontology hierarchy, and serve as the structural foundation for later packages such as FIBO_SEC (Securities).

## Package Structure
FIBO_BE  
│  
├── FIBO_BE_Corporations  
│ ├─ Organization / Corporation hierarchy  
│ ├─ StockCorporation, PubliclyHeldCompany, PrivateLimitedCompany, etc.  
│ └─ ShareClass, BoardAgreement, RegistrationIdentifier  
│  
├── FIBO_BE_FunctionalEntities  
│ ├─ FunctionalEntity, Business, NonProfit  
│ ├─ Publisher, MarketDataProvider, Regulator  
│ └─ Publication and publishing relationships  
│  
├── FIBO_BE_GovernmentEntities  
│ ├─ Polity, Government, Branches, SovereignState  
│ ├─ Jurisdiction and Sovereignty relations  
│ └─ Agencies, Departments, Officials, Ministers  
│  
├── FIBO_BE_LegalEntities  
│ ├─ LegalPerson, NaturalPerson, LegalEntity  
│ ├─ CorporateBody, Partnership, Foundation, Association  
│ ├─ LEIRecord, LEIScheme, LegalEntitiesOntologyMetadata  
│ └─ Jurisdiction, Identifier, and Parent/Child connections  
│  
├── FIBO_BE_Metadata  
│ ├─ OntologyMetadata (BE-level)  
│ └─ ModuleReference and Contributor/Publisher relations  
│  
└── FIBO_BE_All  
└─ Aggregator package importing all BE sub-ontologies  


## Imports and Dependencies

Each package imports its predecessors:

```sysml
private import ScalarValues::*; 
private import FIBO_FND_Constraints::*; 
private import FIBO_BE_Corporations::*;
```


This ensures a single consistent namespace without self-contained redeclarations.
FIBO_FND_Constraints provides common numeric and logical constraints (e.g., NonNegativeInteger, PercentBetween0And100).

## Modeling Notes

* Structural entities → part def
* Value/flow elements → item def
* Relationships → connection def with explicit cross multiplicities
* Constraints → defined once in FIBO_FND_Constraints, referenced via qualified names
* Metadata → uniform across all BE and SEC modules for provenance tracking

## Purpose

The BE packages establish the legal and organizational backbone for all subsequent domains.
They support reuse in FIBO_SEC, FIBO_IND, and future financial modeling contexts.