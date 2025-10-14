package FIBO_BE_Metadata {

    private import ScalarValues::*;
    private import FIBO_BE_Corporations::*;
    private import FIBO_BE_FunctionalEntities::*;
    private import FIBO_BE_All::*;

    // =========================
    // Stored / flow content (items)
    // =========================
    // Ontology-level metadata record
    item def OntologyMetadata {
        attribute ontologyIRI : String[1];
        attribute versionIRI : String[0..1];
        attribute releaseId : String[0..1];
        attribute publicationDate : ExplicitDate[0..1];
        attribute title : String[0..1];
        attribute description : String[0..1];
        attribute license : String[0..1];
        attribute maturityLevel : String[0..1];
        attribute normativeStatus : String[0..1];
        attribute seeAlso : String[0..*];
    }

    // Simple item to reference a BE module by name/IRI if needed
    item def ModuleReference {
        attribute name : String[1];
        attribute iri : String[0..1];
    }

    // =========================
    // Connections (cross features where helpful)
    // =========================
    // Publisher/maintainer relationships use Organization from Corporations CI.
    connection def publishedBy {
        end [1] item ontologyMetadata : OntologyMetadata;
        end [0..1] part publisher : Organization;
    }

    connection def maintainedBy {
        end [1] item ontologyMetadata : OntologyMetadata;
        end [0..*] part maintainer : Organization;
    }

    // Contributors are ordered (e.g., primary → secondary)
    connection def contributedBy {
        end [1] item ontologyMetadata : OntologyMetadata;
        end [0..*] ordered part contributor : Organization;
    }

    // Metadata may describe one or more BE modules (by name/IRI).
    connection def describesModule {
        end [1] item ontologyMetadata : OntologyMetadata;
        end [0..*] item module : ModuleReference;
    }
}
