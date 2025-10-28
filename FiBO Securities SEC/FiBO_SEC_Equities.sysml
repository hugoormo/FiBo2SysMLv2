// =========================================================
// Configuration Item: FIBO_SEC_Equities
// SysML v2 model mapping of FIBO SEC/Equities RDF group
// Baseline imports follow project conventions
// =========================================================
package FIBO_SEC_Equities {

    // -----------------------------------------------------
    // Imports (private by default)
    // -----------------------------------------------------
    private import FIBO_BE_Corporations::*;   // baseline approved CI
    private import FIBO_FND_Constraints::*;   // NonNegativeInteger, Between0And1, NonNegativeReal, etc.
    private import ScalarValues::*;           // String, Boolean, Integer, Real
    private import Time::*;                   // Date
    private import MarketsAndListings::*;     // if present in your repo
    private import FIBO_FND_Organizations::*;

    // =====================================================
    // Submodule 1/5 — DepositaryReceipts
    // =====================================================
    package DepositaryReceipts {

        // Import sibling package for EquitySecurity definition
        private import EquityInstruments::*;

        part def DepositaryReceipt {
            attribute id : String;
            attribute form : SecurityForm[0..1];
            ref issuer : DepositaryBank;
            ref underlyingSecurity : EquitySecurity;
            attribute programName : String[0..1];
        }

        part def DepositaryBank {
            attribute legalName : String;
        }

        part def AmericanDepositaryReceipt specializes DepositaryReceipt {
            attribute level : ADRLevel[0..1];
            attribute usMarketAccess : Boolean[0..1];
        }

        part def EuropeanDepositaryReceipt specializes DepositaryReceipt {}
        part def GlobalDepositaryReceipt   specializes DepositaryReceipt {}

        enum def ADRLevel {
            enum LevelI;
            enum LevelII;
            enum LevelIII;
            enum Rule144A;
        }

        enum def SecurityForm {
            enum Bearer;
            enum Registered;
        }
    }

    // =====================================================
    // Submodule 2/5 — EquitiesExampleIndividuals
    // =====================================================
    package EquitiesExampleIndividuals {

        private import EquityInstruments::*;
        private import MarketsAndListings::*;

        part def CommonShareExample {
            attribute fisn : String[0..1];
            attribute figi : String[0..1];
            attribute shareClassCode : String[0..1];
            attribute firstTradeDate : Date[0..1];
            ref issuer : ShareIssuer;
            ref primaryListing : ExchangeListing;
        }

        part def AppleCommonShareExample   specializes CommonShareExample {}
        part def AlphabetClassAExample     specializes CommonShareExample {}
        part def AlphabetClassCExample     specializes CommonShareExample {}
    }

    // =====================================================
    // Submodule 3/5 — EquityCFIClassificationIndividuals
    // =====================================================
    package EquityCFIClassificationIndividuals {

        enum def VotingRights {
            enum OneShareOneVote;
            enum Enhanced;
            enum Restricted;
            enum None;
        }

        enum def PaymentForm {
            enum Cash;
            enum Reinvestment;
            enum Scrip;
            enum InKind;
        }

        enum def Convertibility {
            enum NonConvertible;
            enum Convertible;
            enum Exchangeable;
        }

        enum def DividendRateType {
            enum Fixed;
            enum Adjustable;
            enum AuctionRate;
            enum None;
        }

        enum def Preference {
            enum Common;
            enum Preferred;
        }

        part def EquityCFIFeatureProfile {
            attribute cfiCode : String;
            attribute preference : Preference;
            attribute votingRights : VotingRights;
            attribute convertibility : Convertibility;
            attribute dividendRateType : DividendRateType;
            attribute paymentForm : PaymentForm[0..1];
        }

        part def CommonNonConvertible_OneVote_FixedCash specializes EquityCFIFeatureProfile {}
        part def PreferredConvertible_EnhancedVote_Adjustable specializes EquityCFIFeatureProfile {}
    }

    // =====================================================
    // Submodule 4/5 — EquityInstruments (core)
    // =====================================================
    package EquityInstruments {

        part def ShareIssuer {
            attribute legalName : String;
            attribute lei : String[0..1];
        }

        abstract part def EquitySecurity {
            attribute securityId : String[0..1];
        }

        part def Share specializes EquitySecurity {
            attribute shareClass : String[0..1];
            attribute pricePerShare : Real[0..1];
            attribute sharesOutstanding : NonNegativeInteger[0..1];
            ref issuer : ShareIssuer;
            ref rights : VotingRightsSpec[0..1];
            ref dividendPolicy : DividendSpec[0..1];
            ref redemption : EquityRedemptionProvision[0..1];
        }

        part def CommonShare    specializes Share {}
        part def PreferredShare specializes Share {}

        part def VotingRightsSpec {
            attribute votesPerShare : NonNegativeReal;
            attribute notes : String[0..1];
        }

        abstract part def DividendSpec {
            attribute declarationDate : Date[0..1];
            ref distributionMethod : DividendDistributionMethod[0..1];
            ref schedule : DividendSchedule[0..1];
        }

        part def FixedRateDividend specializes DividendSpec {
            attribute annualRate : Between0And1;
        }

        part def AdjustableRateDividend specializes DividendSpec {
            attribute benchmark : String;
            attribute formula : String[0..1];
        }

        part def AuctionRateDividend specializes DividendSpec {
            attribute resetFrequencyDays : NonNegativeInteger;
        }

        enum def DividendDistributionMethod {
            enum Payment;
            enum Reinvestment;
        }

        part def DividendSchedule {
            attribute paymentDates : Date[*];
        }

        part def EquityPosition {
            ref instrument : Share;
            attribute quantity : NonNegativeInteger;
            attribute asOf : Date;
        }

        part def EquityRedemptionProvision {
            attribute isExtendable : Boolean[0..1];
            attribute terms : String[0..1];
        }
    }
}
