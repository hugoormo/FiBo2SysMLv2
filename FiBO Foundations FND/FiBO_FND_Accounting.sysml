// ==========================================
// FIBO_FND_Accounting.sysml
// Configuration Item (CI) Aggregator
// ==========================================
package FIBO_FND_Accounting {

  // Re-export subpackages so downstream imports of this CI can see them
  public import CurrencyAmount::*;
  public import CashFlows::*;
  public import AccountingEquity::*;
}

// ======================
// CurrencyAmount.sysml
// (feature-based from CurrencyAmount.rdf)
// ======================
package CurrencyAmount {

  // ---- Imports (private) ----
  private import ScalarValues::*;                    // String, Integer, Real, Boolean
  private import Time::*;                            // safe even if no dates here
  private import Locations::*;

  // ---- Minimal stubs for external refs (swap to real FND/Common packages later) ----
  item def ScalarQuantityValue { }                   // cmns-qtu:ScalarQuantityValue
  item def MeasurementUnit { }                       // cmns-qtu:MeasurementUnit
  item def Percentage { }                            // cmns-qtu:Percentage
  item def Ratio { }                                 // cmns-qtu:Ratio
  item def Expression { }                            // cmns-qtu:Expression
  item def StructuredCollection { }                  // cmns-col:StructuredCollection
  item def Identifier { }                            // cmns-id:Identifier
  item def CodeElement { }                           // cmns-cds:CodeElement
  item def Thing { }                                 // owl:Thing

  // ===== Classes =====

  item def Currency specializes MeasurementUnit {
    // Data properties in RDF
    attribute minorUnit: String[0..1];
    attribute numericCode: String[0..*];
    attribute textualName: String[0..*];
    // Object properties in RDF
    attribute usedBy: GeopoliticalEntity[0..*];     // isUsedBy
  }

  item def CurrencyBasket specializes StructuredCollection {
    attribute member: Currency[1..*];               // hasMember
  }

  item def UnitOfAccount specializes Currency { }
  item def Funds specializes Currency {
    attribute currency: Currency[1..1];             // underlying currency basis
  }
  item def PreciousMetal specializes Currency { }

  // Money & prices

  item def AmountOfMoney specializes ScalarQuantityValue {
    attribute currency: Currency[1..1];             // hasCurrency
  }

  item def MonetaryAmount specializes ScalarQuantityValue {
    attribute amount: Real;                          // hasAmount
    attribute currency: Currency[1..1];             // hasCurrency
  }

  item def Price specializes ScalarQuantityValue { }

  item def MonetaryPrice specializes MonetaryAmount, Price {
    attribute priceFor: Thing[0..*];                // isPriceFor
  }

  item def CalculatedPrice specializes MonetaryPrice {
    attribute expression: Expression[1..1];         // hasExpression
  }

  // Rates

  item def PercentageMonetaryAmount specializes Percentage {
    attribute currency: Currency[1..1];             // hasCurrency
  }

  item def InterestRate specializes PercentageMonetaryAmount {
    attribute rateValue: Real;                      // hasRateValue
  }

  item def ExchangeRate specializes Ratio {
    attribute rateValue: Real;                      // hasRateValue
    attribute baseCurrency: Currency[1..1];         // hasBaseCurrency
    attribute dealtCurrency: Currency[1..1];        // hasDealtCurrency
  }

  // Identifiers

  item def CurrencyIdentifier specializes CodeElement, Identifier {
    attribute tag: String;                          // hasTag
    attribute identifies: Currency[0..*];
  }

  item def FundsIdentifier specializes CodeElement, Identifier {
    attribute tag: String;
    attribute fundsType: String[0..1];
    attribute identifies: Funds[0..*];
  }

  item def PreciousMetalIdentifier specializes CodeElement, Identifier {
    attribute tag: String;
    attribute identifies: PreciousMetal[0..*];
  }

  item def UnitOfAccountIdentifier specializes CodeElement, Identifier {
    attribute tag: String;
    attribute identifies: UnitOfAccount[0..*];
  }
}

// =====================
// CashFlows.sysml
// (feature-based from CashFlows.rdf)
// =====================
package CashFlows {

  // ---- Imports (private) ----
    private import ScalarValues::*;                     // String, Integer, Real, Boolean
    private import Time::*;                             // Date
    private import CurrencyAmount::*;                   // MonetaryAmount
    private import FinancialDates::*;     // Schedule, RegularSchedule, CalculatedDate...
    private import Occurrences::*;        // Occurrence

  // ---- Local placeholders for referenced FND types (swap later) ----
  item def DatedCollectionConstituent { }             // fibo-fnd-dt-fd:DatedCollectionConstituent

  // Neutral placeholders (range open in RDF)
  item def SourceOfFunds { }
  item def TargetOfFunds { }

  // ===== Classes =====

  item def CashFlow specializes DatedCollectionConstituent {
    doc/* movement of money from some source to some sink */
    attribute source: SourceOfFunds[1..1];           // hasSourceOfMoney
    attribute target: TargetOfFunds[1..1];           // hasTargetOfMoney
    attribute amount: MonetaryAmount[1..1];          // hasMonetaryAmount
  }

  item def CashFlowStructure specializes FinancialDates::RegularSchedule {
    attribute member: CashFlow[1..*];                // hasMember
    attribute schedule: Schedule[0..1];              // hasSchedule (max 1)
    attribute triggeringEvent: TriggeringEvent[0..*];// specifies
  }

  item def TriggeringEvent specializes Occurrence { }
}

// ==========================
// AccountingEquity.sysml
// (feature-based from AccountingEquity.rdf)
// ==========================
package AccountingEquity {

  // ---- Imports (private) ----
  private import ScalarValues::*;                     // String, Integer, Real, Boolean
  private import Time::*;                             // safe
  // External FND packages referenced by RDF (keep as imports later if available)
  // private import FIBO_FND_Organizations::*;        // FormalOrganization
  // private import FIBO_FND_OwnershipAndControl::*;  // TangibleAsset
  // For now, minimal stubs so this compiles standalone:
  item def FormalOrganization { }
  item def TangibleAsset { }

  // ===== Classes =====

  item def OwnersEquity {
    attribute appliesTo: FormalOrganization[1..*];   // appliesTo
    attribute paidInCapital: PaidInCapital[1..*];    // hasArgument
    attribute retainedEarnings: RetainedEarnings[1..*]; // hasArgument
  }

  item def ShareholdersEquity specializes OwnersEquity { }

  item def PaidInCapital specializes OwnersEquity { }

  item def CapitalSurplus specializes PaidInCapital { }

  item def RetainedEarnings specializes OwnersEquity { }

  item def Income { }

  item def EarningsBeforeInterestTaxesDepreciationAmortization {
    attribute abbreviation: String[0..1];            // e.g., "EBITDA"
  }

  item def FinancialAsset specializes TangibleAsset { }

  item def PhysicalAsset specializes TangibleAsset {
    // NOTE: Disjoint with FinancialAsset in RDF; add a constraint later if desired.
  }
}
