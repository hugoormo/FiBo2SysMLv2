package FIBO_BE_LegalEntities {

    private import ScalarValues::*;
    private import FIBO_BE_Corporations::*;
    private import FIBO_BE_FunctionalEntities::*;
    private import FIBO_BE_GovernmentEntities::*;
    private import FIBO_BE_Metadata::*;

    // =========================
    // Legal Persons (from LegalPersons.rdf)
    // =========================
    // LegalPerson abstracts persons recognized by law (includes natural persons and legal entities)
    part def LegalPerson specializes Organization {
        attribute dateRecognized : ExplicitDate[0..1];
        attribute domicile : Jurisdiction[0..*];
    }

    // Natural person as a kind of legal person
    part def NaturalPerson specializes LegalPerson;

    // =========================
    // Corporate Bodies & Formal Business Organizations
    // (adjusted so LegalEntity specializes LegalPerson)
    // =========================
    part def LegalEntity specializes LegalPerson {
        attribute legalForm : String[0..1];
        attribute dateOfEstablishment : ExplicitDate[0..1];
        attribute principalPlaceOfBusiness : Jurisdiction[0..*];
    }

    part def CorporateBody specializes LegalEntity;

    part def Company specializes CorporateBody;
    part def IncorporatedCompany specializes Company;
    part def LimitedLiabilityCompany specializes Company;
    part def PublicLimitedCompany specializes Company;
    part def PrivateLimitedCompany specializes Company;

    part def Partnership specializes CorporateBody;
    part def GeneralPartnership specializes Partnership;
    part def LimitedPartnership specializes Partnership;

    part def Foundation specializes CorporateBody;
    part def Association specializes CorporateBody;

    // =========================
    // LEI Entities (from LEIEntities.rdf)
    // =========================
    item def LEIRecord {
        attribute leiCode : String[1];
        attribute registrationStatus : String[0..1];
        attribute lastUpdate : ExplicitDate[0..1];
        attribute initialRegistrationDate : ExplicitDate[0..1];
    }

    item def LEIScheme {
        attribute schemeName : String[1];
        attribute schemeVersion : String[0..1];
    }

    // =========================
    // Package Metadata (from MetadataBELegalEntities.rdf)
    // =========================
    // Specialize OntologyMetadata to tag metadata specific to this CI/module
    item def LegalEntitiesOntologyMetadata specializes OntologyMetadata;

    // =========================
    // Connections (cross features)
    // =========================
    // Identification for legal persons (e.g., registration identifiers)
    connection def legalPersonHasIdentifier {
        end [1..*] part person : LegalPerson;
        end [0..*] item identifier : RegistrationIdentifier;
    }

    // Domicile / jurisdictional ties for legal persons
    connection def legalPersonHasDomicile {
        end [1..*] part person : LegalPerson;
        end [0..*] item jurisdiction : Jurisdiction;
    }

    // LegalEntity ↔ Jurisdiction (registration / principal place)
    connection def legalEntityHasJurisdiction {
        end [1..*] part entity : LegalEntity;
        end [0..*] item jurisdiction : Jurisdiction;
    }

    // Corporate hierarchy: subsidiary → parent
    connection def isSubsidiaryOf {
        end [0..*] part subsidiary : LegalEntity;
        end [0..1] part parent : LegalEntity;
    }

    // LEI assignment (applicable to LegalEntity, not NaturalPerson)
    connection def hasLEI {
        end [1] part entity : LegalEntity;
        end [0..1] item lei : LEIRecord;
    }

    // LEI administration and scheme provenance
    connection def leiAdministeredBy {
        end [1] item lei : LEIRecord;
        end [0..1] part administrator : Organization;
    }

    connection def leiUnderScheme {
        end [1] item lei : LEIRecord;
        end [0..1] item scheme : LEIScheme;
    }

    // Company ↔ ShareClass (reuse from Corporations CI)
    connection def companyHasShareClass {
        end [0..*] part company : Company;
        end [0..1] item shareClass : ShareClass;
    }

    // Metadata for this module (optional linkage to the BE metadata CI)
    connection def hasModuleMetadata {
        end [1] item moduleMetadata : LegalEntitiesOntologyMetadata;
        end [0..*] part subjectEntity : LegalEntity;
    }

    // =========================
    // Constraints (defs) — lightweight examples
    // =========================
    constraint def IncorporatedMustHaveEstablishmentDate {
        in hasDate : Boolean;
        hasDate
    }

    part def IncorporatedCompanyPolicy specializes IncorporatedCompany {
        attribute hasDate : Boolean[1];

        constraint incorporation_date_required : IncorporatedMustHaveEstablishmentDate {
            in hasDate = hasDate;
        }
    }
}