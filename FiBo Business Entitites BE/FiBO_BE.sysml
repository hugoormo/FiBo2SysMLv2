package FIBO_BE_All {
    doc/*
        * This directory contains ontologies belonging to the FIBO Business Entities (BE) Domain. 
        * This domain defines business concepts that are used for data governance, interoperability, 
        * and in regulatory reporting about business entities.
        */
    // Aggregator package for Business Entities (BE) — intentionally no new assertions.
    // Aligns with the AllBE ontology behavior (imports BE modules). 
    private import FIBO_BE_Corporations;
    private import FIBO_BE_FunctionalEntities;
    private import FIBO_BE_GovernmentEntities;
    private import FIBO_BE_LegalEntities;
    private import FIBO_BE_Metadata;
}