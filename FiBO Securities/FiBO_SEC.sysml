package FIBO_SEC_All {

    doc/*
        * This directory contains ontologies belonging to the FIBO Securities (SEC) domain. 
        * This domain provides a model of concepts that are common to financial instruments that are also securities, 
        * including but not limited to exchange-traded securities. High-level concepts relevant to securities classification, 
        * identification, issuance, and registration of securities generally are covered, as well as additional detail for 
        * equities and debt instruments. More details defining derivatives, in particular, are covered in a separate 
        * derivatives domain area.
        */

    // Aggregator for Securities (SEC) — intentionally no new parts/items/connections.
    // As we approve SEC configuration items, add them as private imports below.

    private import ScalarValues::*;
    private import FIBO_SEC_Securities::*;
    private import FIBO_SEC_Funds::*;
    private import FIBO_SEC_Equities::*;
    private import FIBO_SEC_Debt::*;
    // private import FIBO_SEC_Identifiers::*;
    // private import FIBO_SEC_Metadata::*;
    
}
