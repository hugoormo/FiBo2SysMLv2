// =========================================================
// Configuration Item: FIBO_SEC_Funds
// SysML v2 model mapping of FIBO SEC/Funds RDF group
// Baseline imports follow project conventions
// =========================================================
package FIBO_SEC_Funds {

    // -----------------------------------------------------
    // Imports (private by default)
    // -----------------------------------------------------
    private import FIBO_BE_Corporations::*;   // issuer/org structures baseline
    private import FIBO_FND_Constraints::*;   // NonNegativeInteger, Between0And1, NonNegativeReal, etc.
    private import ScalarValues::*;           // String, Boolean, Integer, Real
    private import Time::*;                   // Date
    // (Optional) If you have markets/listings or securities commons, add them too:
    // private import MarketsAndListings::*;
    // private import SecuritiesCommons::*;

    // =====================================================
    // Submodule 1/3 — CollectiveInvestmentVehicles
    // (generic CIV concepts, roles, and base abstractions)
    // =====================================================
    package CollectiveInvestmentVehicles {

        // Common actors
        part def FundManager {
            attribute legalName : String;
            attribute lei : String[0..1];
        }

        part def FundAdministrator {
            attribute legalName : String;
            attribute lei : String[0..1];
        }

        part def Custodian {
            attribute legalName : String;
            attribute lei : String[0..1];
        }

        // Legal form / wrapper
        enum def CIVLegalForm {
            enum Company;        // investment company / SICAV
            enum Trust;          // unit trust
            enum Partnership;    // limited partnership, etc.
            enum Other;
        }

        // Base CIV
        abstract part def CollectiveInvestmentVehicle {
            attribute name : String;
            attribute legalForm : CIVLegalForm;
            attribute domicile : String[0..1];               // jurisdiction code / name
            attribute strategy : String[0..1];               // textual strategy / mandate
            attribute inceptionDate : Date[0..1];

            ref manager : FundManager[0..1];
            ref administrator : FundAdministrator[0..1];
            ref custodian : Custodian[0..1];
            ref portfolio : Portfolio[0..1];
        }

        // Portfolio (very lightweight placeholder)
        part def Portfolio {
            attribute asOf : Date[0..1];
            attribute description : String[0..1];
        }

        // Units / shares of a CIV
        part def FundUnit {
            attribute classCode : String[0..1];              // share/unit class
            attribute isin : String[0..1];
            attribute currency : String[0..1];               // e.g., ISO 4217 code
        }

        // NAV structures
        part def NetAssetValue {
            attribute navDate : Date;
            attribute totalNav : Real[0..1];
            attribute navPerUnit : Real[0..1];
            attribute currency : String[0..1];
        }
    }

    // =====================================================
    // Submodule 2/3 — Funds
    // (specializes CIV into specific fund categories and mechanics)
    // =====================================================
    package Funds {

        // Import base CIV concepts from sibling subpackage
        private import CollectiveInvestmentVehicles::*;
        private import FIBO_FND_Constraints::*;

        // Fund style and dealing
        enum def FundLiquidityProfile {
            enum OpenEnded;
            enum ClosedEnded;
            enum Interval;
        }

        enum def DealingFrequency {
            enum Daily;
            enum Weekly;
            enum Monthly;
            enum Quarterly;
            enum AdHoc;
        }

        // Core Fund concept
        part def InvestmentFund specializes CollectiveInvestmentVehicle {
            attribute liquidityProfile : FundLiquidityProfile;
            attribute isPubliclyOffered : Boolean[0..1];      // retail vs. professional
            attribute expenseRatio : Between0And1[0..1];      // TER / OCF as fraction
            attribute swingPricing : Boolean[0..1];

            ref primaryUnit : FundUnit[0..1];
            ref latestNav : NetAssetValue[0..1];
            ref dealingPolicy : DealingPolicy[0..1];
        }

        // Dealing policy (subscriptions / redemptions)
        part def DealingPolicy {
            attribute dealingFrequency : DealingFrequency[0..1];
            attribute cutOffTimeLocal : String[0..1];         // "HH:MM" local time (simplified)
            attribute settlementDays : NonNegativeInteger[0..1];
            attribute redemptionGatePercent : Between0And1[0..1];
        }

        // Common specializations (kept generic / optional)
        part def OpenEndedFund  specializes InvestmentFund {
            attribute allowsDailyDealing : Boolean[0..1];
        }
        part def ClosedEndedFund specializes InvestmentFund {}
        part def ExchangeTradedFund specializes InvestmentFund {
            attribute listed : Boolean[0..1];
            attribute primaryListingMic : String[0..1];
        }

        // Class-level parameters (for multiple unit/share classes)
        part def FundClassTerms {
            attribute classCode : String;
            attribute minInitialSubscription : Real[0..1];
            attribute managementFee : Between0And1[0..1];
            attribute performanceFee : Between0And1[0..1];
            attribute eligibleInvestorsNote : String[0..1];
        }
    }

    // =====================================================
    // Submodule 3/3 — MetadataSECFunds
    // (module metadata/provenance)
    // =====================================================
    package MetadataSECFunds {

        part def SECFundsModuleMetadata {
            attribute title : String = "FIBO SEC Funds Module";
            attribute description : String = "Collective investment vehicles, funds, units/classes, NAV, and key parties.";
            attribute license : String = "MIT";
            attribute lastUpdated : Date[0..1];
            attribute contributors : String[*];
        }
    }
}
