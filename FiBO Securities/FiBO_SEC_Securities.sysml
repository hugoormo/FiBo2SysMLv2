// =========================================================
// Configuration Item: FIBO_SEC_Securities
// SysML v2 model mapping of FIBO SEC/Securities RDF group
// Conventions: item def (no 'class'), ref (not 'reference'), private import, enum def, ScalarValues, Time
// =========================================================

package FIBO_SEC_Securities {

    // -----------------------------------------------------
    // Canonical Imports (project baselines)
    // -----------------------------------------------------
    private import ScalarValues::*;          // String, Integer, Real, Date, etc.
    private import Time::*;                  // Time and date utilities
    private import FIBO_FND_Constraints;     // central constraints (NonNegativeInteger, Between0And1, etc.)
    private import FIBO_BE_All;                  // Business Entities root
    private import FIBO_BE_LegalEntities;    // Legal entities (issuers / registrants)
    private import FIBO_SEC_All;                 // Securities domain root
    private import FIBO_SEC_Debt;            // Debt (for cross-references)
    private import FIBO_SEC_Equities;        // Equities (for cross-references)
    private import FIBO_SEC_Funds;           // Funds (for cross-references)

    // -----------------------------------------------------
    // Shared Core for this CI
    // -----------------------------------------------------
    package Core {
        // Common abstractions reused by subpackages in this CI

        item def Security {
            attribute name: String;
            attribute description: String[0..1];
            attribute issueDate: Date[0..1];
            attribute terminationDate: Date[0..1];

            ref issuedBy: Issuer[0..1];
            ref identifies: SecurityIdentification[0..*];
            ref listedOn: SecurityListing[0..*];
            ref governedBy: SecurityRestriction[0..*];
            ref classifiedBy: SecurityClassification[0..*];
            ref backedBy: SecurityAsset[0..*];
        }

        item def Issuer specializes FIBO_BE_LegalEntities::LegalEntity {}

        item def SecurityIdentification {
            attribute assignedOn: Date[0..1];
            ref identifies: Security[1];
            ref hasIdentifier: SecurityIdentifier[1];
        }

        item def SecurityIdentifier {
            attribute value: String;
            attribute scheme: IdentifierScheme;
        }

        enum def IdentifierScheme {
            enum ISIN;
            enum CUSIP;
            enum SEDOL;
            enum FIGI;
            enum LEI;
            enum TICKER;
            enum OTHER;
        }

        item def SecurityClassification {
            ref classifiedSecurity: Security[1];
            ref class: SecurityClass[1];
        }

        enum def ClassificationScheme {
            enum FIBO;
            enum ISO10962_CFI;
            enum NAICS;
            enum GICS;
            enum CUSTOM;
        }

        item def SecurityClass {
            attribute name: String;
            attribute definition: String[0..1];
        }

        item def SecurityListing {
            attribute listingDate: Date[0..1];
            attribute delistingDate: Date[0..1];
            attribute listingVenueCode: String[0..1];
            ref security: Security[1];
            ref venue: ListingVenue[1];
            ref localIdentifier: SecurityIdentifier[0..1];
        }

        item def ListingVenue {
            attribute name: String;
            attribute mic: String[0..1];
            attribute country: String[0..1];
        }

        abstract item def SecurityRestriction {
            attribute effectiveDate: Date[0..1];
            attribute terminationDate: Date[0..1];
            attribute text: String[0..1];
            ref restrictedSecurity: Security[1];
        }

        item def TransferRestriction specializes SecurityRestriction {
            attribute restrictionType: TransferRestrictionType;
        }

        enum def TransferRestrictionType {
            enum LEGEND;
            enum LOCKUP;
            enum RULE144;
            enum AFFILIATE_LIMITS;
            enum OTHER;
        }

        abstract item def SecurityAsset {
            attribute description: String[0..1];
        }

        item def CashAsset specializes SecurityAsset {}
        item def CommodityAsset specializes SecurityAsset { attribute commodityCode: String[0..1]; }
        item def RealEstateAsset specializes SecurityAsset { attribute address: String[0..1]; }
        item def LoanAsset specializes SecurityAsset { attribute loanId: String[0..1]; }
        item def SecurityReferenceAsset specializes SecurityAsset { ref security: Security[1]; }

        item def ParametricSchedule {
            attribute startDate: Date;
            attribute endDate: Date[0..1];
            attribute frequency: Frequency;
            attribute businessDayConvention: BusinessDayConvention[0..1];
            attribute dayCount: DayCountConvention[0..1];
        }

        enum def Frequency { enum DAILY; enum WEEKLY; enum MONTHLY; enum QUARTERLY; enum SEMI_ANNUAL; enum ANNUAL; }
        enum def BusinessDayConvention { enum FOLLOWING; enum MOD_FOLLOWING; enum PRECEDING; enum MOD_PRECEDING; enum NONE; }
        enum def DayCountConvention { enum ACT_360; enum ACT_365F; enum ACT_ACT; enum THIRTY_360; enum OTHER; }

        item def WeightedConstituent {
            attribute weight: Real;
            ref member: WeightedConstituent[1];
            constraint def Between0And1Weight { 
                attribute weight : Real = weight;
                
                weight >= 0.0 and weight <= 1.0 
            }
        }

        item def WeightsSumToOne {
            attribute totalWeight: Real;
            constraint def SumToOne { 
                attribute totalWeight : Real = totalWeight;
                totalWeight == 1.0 }
        }
    }

    package Baskets {
        private import Core::*;

        item def SecurityBasket specializes Security {
            ref constituents: WeightedConstituent[1..*];
            ref weightPolicy: WeightingPolicy[0..1];
        }

        enum def WeightingPolicy { enum EQUAL; enum MARKET_CAP; enum PRICE; enum CUSTOM; }

        item def BasketWeights specializes WeightsSumToOne {
            ref basket: SecurityBasket[1];
            ref items: WeightedConstituent[1..*];
        }
    }

    package MetadataSECSecurities {
        private import Core::*;
        item def SECSecuritiesOntologyMetadata specializes OntologyMetadata;
        item def SECSecuritiesModuleRef;
    }

    package ParametricSchedules {
        private import Core::*;
        item def PaymentSchedule specializes ParametricSchedule {}
        item def ObservationSchedule specializes ParametricSchedule {}
        item def ResetSchedule specializes ParametricSchedule {}
        item def DateGrid {
            attribute anchorDate: Date;
            attribute tenor: String;
            attribute count: Integer;
        }
        enum def RollConvention { enum EOM; enum IMM; enum NONE; }
    }

    package Pools {
        private import Core::*;
        item def AssetPool {
            attribute poolId: String[0..1];
            ref assets: SecurityAsset[1..*];
        }
        item def SecurityPool specializes Security {
            ref pool: AssetPool[1];
            ref interests: PoolInterest[1..*];
        }
        item def PoolInterest specializes Security {
            attribute trancheLabel: String[0..1];
            attribute priority: Integer[0..1];
            ref backedByPool: AssetPool[1];
        }
    }

    package SecuritiesClassification {
        private import Core::*;
        item def EquityClass specializes SecurityClass {}
        item def DebtClass specializes SecurityClass {}
        item def FundClass specializes SecurityClass {}
        item def DerivativeClass specializes SecurityClass {}
        item def OtherSecurityClass specializes SecurityClass {}
        item def CFIClassification specializes SecurityClassification {
            attribute cfiCode: String;
            constraint def CfiCodeFormat { }
        }
    }

    package SecuritiesIdentification {
        private import Core::*;
        item def ISINIdentifier specializes SecurityIdentifier { attribute countryPrefix: String[0..1]; }
        item def CUSIPIdentifier specializes SecurityIdentifier {}
        item def SEDOLIdentifier specializes SecurityIdentifier {}
        item def FIGIIdentifier specializes SecurityIdentifier {}
        item def TickerIdentifier specializes SecurityIdentifier { attribute exchangeMic: String[0..1]; }
        connection def IdentifiesSecurity {
            end id: SecurityIdentifier[1];
            end target: Security[1];
        }
    }

    package SecuritiesIdentificationIndividuals {
        private import Core::*;
        private import SecuritiesIdentification::*;
        item def Example_ISIN_MSFT specializes ISINIdentifier { 
            :>> value := "US5949181045"; 
            :>> scheme := IdentifierScheme::ISIN; 
        }
        item def Example_Ticker_MSFT specializes TickerIdentifier { 
            :>> value := "MSFT"; 
            :>> scheme := IdentifierScheme::TICKER; 
        }
    }

    package SecuritiesIssuance {
        private import Core::*;
        item def Issuance {
            attribute announcementDate: Date[0..1];
            attribute pricingDate: Date[0..1];
            attribute settlementDate: Date[0..1];
            attribute offeringType: OfferingType[0..1];
            ref security: Security[1];
            ref issuer: Issuer[1];
            ref offeringDocument: OfferingDocument[0..1];
        }
        enum def OfferingType { enum IPO; enum SPO; enum PRIVATE_PLACEMENT; enum RIGHTS_OFFERING; enum OTHER; }
        item def OfferingDocument { attribute url: String[0..1]; attribute title: String[0..1]; }
    }

    package SecuritiesListings {
        private import Core::*;
        item def Exchange specializes ListingVenue {}
        item def MtfOtfVenue specializes ListingVenue {}
        connection def ListedOnVenue {
            end listing: SecurityListing[1];
            end venue: ListingVenue[1];
        }
    }

    package SecuritiesRestrictions {
        private import Core::*;
        item def HoldingRestriction specializes SecurityRestriction { 
            attribute maxPositionPercent: Real[0..1]; 
        }
        item def UseRestriction specializes SecurityRestriction {}
        constraint def MaxPositionBetween0And1 { 
            attribute maxPositionPercent : Real = maxPositionPercent;
            maxPositionPercent >= 0.0 and maxPositionPercent <= 1.0
        }
    }

    package SecurityAssets {
        private import Core::*;
        private import Baskets::*;
        private import Pools::*;
        item def IndexAsset specializes SecurityAsset { attribute indexCode: String[0..1]; }
        item def BasketAsset specializes SecurityAsset { ref basket: SecurityBasket[1]; }
        item def PoolAsset specializes SecurityAsset { ref pool: AssetPool[1]; }
    }
}
