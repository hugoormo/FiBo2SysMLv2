// =========================================================
// Configuration Item: FIBO_SEC_Debt
// SysML v2 model mapping of FIBO SEC/Debt RDF group
// Baseline imports follow project conventions
// =========================================================

package FIBO_SEC_Debt {

    private import ScalarValues::*;
    private import FIBO_SEC_All::*;
    private import FIBO_BE_Corporations::*;
    private import FIBO_BE_FunctionalEntities::*;
    private import FIBO_BE_LegalEntities::*;
    private import FIBO_BE_Metadata::*;
    private import FIBO_FND_Constraints::*;

    // =========================
    // Shared core for SEC/Debt
    // =========================
    part def DebtSecurity specializes Organization {
        attribute title : String[0..1];
        attribute issueDate : ExplicitDate[0..1];
        attribute maturityDate : ExplicitDate[0..1];
        attribute couponRatePct : Real[0..1];
        attribute couponType : String[0..1];
        attribute paymentFrequency : String[0..1];
        attribute dayCountConvention : String[0..1];

        constraint coupon_rate_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
            in x = couponRatePct;
        }
    }

    // =========================================================
    // Subpackage 1/11 — AssetBackedSecurities.rdf
    // =========================================================
    package AssetBackedSecurities {

        part def AssetBackedSecurity specializes DebtSecurity;
        part def MortgageBackedSecurity specializes AssetBackedSecurity;
        part def ResidentialMortgageBackedSecurity specializes MortgageBackedSecurity;
        part def CommercialMortgageBackedSecurity specializes MortgageBackedSecurity;

        part def CollateralizedMortgageObligation specializes MortgageBackedSecurity;
        part def CollateralizedDebtObligation specializes AssetBackedSecurity;

        part def Tranche specializes Organization {
            attribute name : String[0..1];
            attribute priorityRank : Integer[0..1];
            attribute couponRatePct : Real[0..1];

            constraint tranche_coupon_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = couponRatePct;
            }
        }

        part def SpecialPurposeVehicle specializes Organization;
        part def Servicer specializes Organization;
        part def Trustee specializes Organization;
        part def Underwriter specializes Organization;
        part def Arranger specializes Organization;

        item def AssetPool {
            attribute poolType : String[0..1];
            attribute cutOffDate : ExplicitDate[0..1];
        }

        item def UnderlyingAsset {
            attribute assetType : String[0..1];
            attribute principalAmount : Real[0..1];
            attribute interestRatePct : Real[0..1];

            constraint asset_rate_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = interestRatePct;
            }
        }

        item def CreditEnhancement {
            attribute method : String[0..1];
            attribute amountPct : Real[0..1];

            constraint ce_pct_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = amountPct;
            }
        }

        item def WaterfallRule {
            attribute description : String[0..1];
            attribute sequenceNumber : Integer[0..1];
        }

        connection def absIssuedBy {
            end [0..*] part abs : AssetBackedSecurity;
            end [1] part spv : SpecialPurposeVehicle;
        }

        connection def backedByPool {
            end [1] part abs : AssetBackedSecurity;
            end [0..1] item pool : AssetPool;
        }

        connection def poolHasAsset {
            end [1] item pool : AssetPool;
            end [0..*] ordered item asset : UnderlyingAsset;
        }

        connection def hasTranche {
            end [0..*] ordered part abs : AssetBackedSecurity;
            end [0..1] part tranche : Tranche;
        }

        connection def trancheHasCreditEnhancement {
            end [1] part tranche : Tranche;
            end [0..*] item enhancement : CreditEnhancement;
        }

        connection def trancheHasWaterfallRule {
            end [1] part tranche : Tranche;
            end [0..*] ordered item rule : WaterfallRule;
        }

        connection def servicedBy {
            end [0..*] part deal : AssetBackedSecurity;
            end [0..1] part servicer : Servicer;
        }

        connection def hasTrustee {
            end [0..*] part deal : AssetBackedSecurity;
            end [0..1] part trustee : Trustee;
        }

        connection def underwrittenBy {
            end [0..*] part deal : AssetBackedSecurity;
            end [0..*] part underwriter : Underwriter;
        }

        connection def arrangedBy {
            end [0..*] part deal : AssetBackedSecurity;
            end [0..1] part arranger : Arranger;
        }
    }

    // =========================================================
    // Subpackage 2/11 — Bonds.rdf
    // =========================================================
    package Bonds {

        part def Bond specializes DebtSecurity;
        part def GovernmentBond specializes Bond;
        part def CorporateBond specializes Bond;
        part def MunicipalBond specializes Bond;
        part def SovereignBond specializes GovernmentBond;

        part def CouponBearingBond specializes Bond;
        part def ZeroCouponBond specializes Bond;
        part def PerpetualBond specializes Bond;

        part def CallableBond specializes CouponBearingBond;
        part def PuttableBond specializes CouponBearingBond;
        part def ConvertibleBond specializes CouponBearingBond;

        part def SecuredBond specializes Bond;
        part def CoveredBond specializes SecuredBond;
        part def Debenture specializes Bond;

        item def CouponScheduleEntry {
            attribute paymentDate : ExplicitDate[0..1];
            attribute ratePct : Real[0..1];

            constraint coupon_entry_rate_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = ratePct;
            }
        }

        item def CreditRating {
            attribute agency : String[0..1];
            attribute ratingCode : String[0..1];
            attribute asOfDate : ExplicitDate[0..1];
        }

        item def Collateral {
            attribute description : String[0..1];
            attribute collateralType : String[0..1];
            attribute valueAmount : Real[0..1];
        }

        item def Covenant {
            attribute covenantType : String[0..1];
            attribute description : String[0..1];
        }

        item def CallProvision {
            attribute callDate : ExplicitDate[0..1];
            attribute callPrice : Real[0..1];
        }

        item def PutProvision {
            attribute putDate : ExplicitDate[0..1];
            attribute putPrice : Real[0..1];
        }

        item def ConversionTerm {
            attribute conversionRatio : Real[0..1];       // shares per bond
            attribute underlyingSecurity : String[0..1];  // placeholder until SEC/Equities CI exists
            attribute conversionStart : ExplicitDate[0..1];
            attribute conversionEnd : ExplicitDate[0..1];
        }

        connection def bondHasCouponSchedule {
            end [1] part bond : Bond;
            end [0..*] ordered item bondEntry : CouponScheduleEntry;
        }

        connection def bondIssuedBy {
            end [0..*] part bond : Bond;
            end [1] part issuer : LegalEntity;
        }

        connection def bondHasRating {
            end [1] part bond : Bond;
            end [0..*] item rating : CreditRating;
        }

        connection def bondSecuredBy {
            end [1] part bond : SecuredBond;
            end [0..*] item collateral : Collateral;
        }

        connection def bondHasCovenant {
            end [1] part bond : Bond;
            end [0..*] item covenant : Covenant;
        }

        connection def bondHasCallProvision {
            end [1] part bond : CallableBond;
            end [0..*] ordered item provision : CallProvision;
        }

        connection def bondHasPutProvision {
            end [1] part bond : PuttableBond;
            end [0..*] ordered item provision : PutProvision;
        }

        connection def convertibleHasConversionTerm {
            end [1] part bond : ConvertibleBond;
            end [0..*] item conversion : ConversionTerm;
        }
    }

    // =========================================================
    // Subpackage 3/11 — CollateralizedDebtObligations.rdf
    // =========================================================
    package CollateralizedDebtObligations {

        part def CollateralizedDebtObligation specializes AssetBackedSecurities::CollateralizedDebtObligation;
        part def CollateralizedLoanObligation specializes CollateralizedDebtObligation;
        part def CollateralizedBondObligation specializes CollateralizedDebtObligation;

        part def CollateralManager specializes Organization;
        part def PayingAgent specializes Organization;

        item def CollateralBucket {
            attribute bucketName : String[0..1];           // e.g., SeniorSecuredLoans, MezzLoans, HYBonds
            attribute maxConcentrationPct : Real[0..1];

            constraint bucket_limit_pct_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = maxConcentrationPct;
            }
        }

        item def CoverageTest {
            attribute testType : String[0..1];            // e.g., OC, IC
            attribute thresholdPct : Real[0..1];

            constraint threshold_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = thresholdPct;
            }
        }

        connection def cdoBackedByPool {
            end [1] part cdo : CollateralizedDebtObligation;
            end [0..1] item pool : AssetBackedSecurities::AssetPool;
        }

        connection def cdoManagedBy {
            end [0..*] part cdo : CollateralizedDebtObligation;
            end [1] part manager : CollateralManager;
        }

        connection def cdoHasPayingAgent {
            end [0..*] part cdo : CollateralizedDebtObligation;
            end [0..1] part agent : PayingAgent;
        }

        connection def cdoHasTranche {
            end [0..*] ordered part cdo : CollateralizedDebtObligation;
            end [0..1] part tranche : AssetBackedSecurities::Tranche;
        }

        connection def cdoHasWaterfallRule {
            end [1] part cdo : CollateralizedDebtObligation;
            end [0..*] ordered item rule : AssetBackedSecurities::WaterfallRule;
        }

        connection def poolHasCollateralBucket {
            end [1] item pool : AssetBackedSecurities::AssetPool;
            end [0..*] item bucket : CollateralBucket;
        }

        connection def cdoHasCoverageTest {
            end [1] part cdo : CollateralizedDebtObligation;
            end [0..*] item test : CoverageTest;
        }

        connection def managerCoordinatesWithServicer {
            end [0..*] part manager : CollateralManager;
            end [0..*] part servicer : AssetBackedSecurities::Servicer;
        }
    }

    // =========================================================
    // Subpackage 4/11 — DebtInstruments.rdf
    // =========================================================
    package DebtInstruments {

        part def DebtInstrument specializes DebtSecurity;

        part def LoanInstrument specializes DebtInstrument;
        part def TermLoan specializes LoanInstrument;
        part def RevolvingLoan specializes LoanInstrument;
        part def PromissoryNote specializes DebtInstrument;
        part def Note specializes DebtInstrument;

        part def FixedRateInstrument specializes DebtInstrument;
        part def FloatingRateInstrument specializes DebtInstrument;

        part def AmortizingInstrument specializes DebtInstrument;
        part def BulletInstrument specializes DebtInstrument;

        item def RateIndex {
            attribute indexName : String[1];            // e.g., SOFR, EURIBOR
            attribute publicationSource : String[0..1];
        }

        item def RateSpread {
            attribute spreadBp : Real[0..1];            // basis points over index
        }

        item def PaymentScheduleLine {
            attribute dueDate : ExplicitDate[0..1];
            attribute amount : Real[0..1];
            attribute componentType : String[0..1];     // e.g., Principal, Interest, Fee
        }

        item def AccrualConvention {
            attribute dayCountConvention : String[0..1];  // e.g., ACT/360
            attribute businessDayRule : String[0..1];      // e.g., Following, ModifiedFollowing
        }

        item def PrepaymentOption {
            attribute permitted : Boolean[1];
            attribute penaltyPct : Real[0..1];

            constraint prepay_penalty_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = penaltyPct;
            }
        }

        connection def instrumentHasPaymentSchedule {
            end [1] part instrument : DebtInstrument;
            end [0..*] ordered item line : PaymentScheduleLine;
        }

        connection def instrumentHasAccrualConvention {
            end [1] part instrument : DebtInstrument;
            end [0..1] item convention : AccrualConvention;
        }

        connection def floatingInstrumentUsesIndex {
            end [1] part instrument : FloatingRateInstrument;
            end [0..1] item index : RateIndex;
        }

        connection def floatingInstrumentHasSpread {
            end [1] part instrument : FloatingRateInstrument;
            end [0..1] item spread : RateSpread;
        }

        connection def instrumentHasPrepaymentOption {
            end [1] part instrument : LoanInstrument;
            end [0..*] item option : PrepaymentOption;
        }

        connection def instrumentIssuedBy {
            end [0..*] part instrument : DebtInstrument;
            end [1] part issuer : LegalEntity;
        }

        connection def loanBorrowedBy {
            end [0..*] part loan : LoanInstrument;
            end [1] part borrower : LegalEntity;
        }

        connection def instrumentHasCovenant {
            end [1] part instrument : DebtInstrument;
            end [0..*] item covenant : Bonds::Covenant;
        }
    }
    // =========================================================
    // Subpackage 5/11 — DistributedLoans.rdf
    // =========================================================
    package DistributedLoans {

        // Syndicated / distributed loans build on loan instruments
        part def SyndicatedLoan specializes DebtInstruments::LoanInstrument;

        // Facilities under a syndicated loan (e.g., Term A, Term B, Revolver)
        part def LoanFacility specializes Organization {
            attribute facilityType : String[0..1];        // e.g., TermA, TermB, Revolver
            attribute committedAmount : Real[0..1];
        }

        // Parties in the lending group
        part def Lender specializes Organization;
        part def AgentBank specializes Lender;
        part def LeadArranger specializes Lender;
        part def ParticipantLender specializes Lender;     // avoids name collision with library

        // Borrower (reuse LegalEntity from BE_LegalEntities)
        // — no new def required; referenced in connections below

        // Stored / flow artifacts
        item def Commitment {
            attribute amount : Real[0..1];
            attribute currency : String[0..1];
        }

        item def Allocation {
            attribute amount : Real[0..1];
            attribute percentage : Real[0..1];

            constraint alloc_pct_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = percentage;
            }
        }

        item def Drawdown {
            attribute drawDate : ExplicitDate[0..1];
            attribute amount : Real[0..1];
            attribute purpose : String[0..1];             // e.g., Acquisition, Refinancing
        }

        item def InterestPeriod {
            attribute startDate : ExplicitDate[0..1];
            attribute endDate : ExplicitDate[0..1];
            attribute rateFixingDate : ExplicitDate[0..1];
        }

        item def Fee {
            attribute feeType : String[0..1];             // e.g., Upfront, Commitment, Agency
            attribute amount : Real[0..1];
            attribute ratePct : Real[0..1];

            constraint fee_pct_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = ratePct;
            }
        }

        // Rate linkage (reuse DebtInstruments::RateIndex / RateSpread)
        connection def facilityUsesRateIndex {
            end [1] part facility : LoanFacility;
            end [0..1] item index : DebtInstruments::RateIndex;
        }

        connection def facilityHasRateSpread {
            end [1] part facility : LoanFacility;
            end [0..1] item spread : DebtInstruments::RateSpread;
        }

        // Loan composition: a SyndicatedLoan has one or more facilities (ordered for presentation)
        connection def loanHasFacility {
            end [1] part loan : SyndicatedLoan;
            end [1..*] ordered part facility : LoanFacility;
        }

        // Borrower relationship
        connection def loanBorrowedBy {
            end [0..*] part loan : SyndicatedLoan;
            end [1] part borrower : LegalEntity;
        }

        // Agent bank and lead arranger relationships (exactly one agent; optional lead arranger)
        connection def loanAgentedBy {
            end [0..*] part loan : SyndicatedLoan;
            end [1] part agent : AgentBank;
        }

        connection def loanArrangedBy {
            end [0..*] part loan : SyndicatedLoan;
            end [0..1] part arranger : LeadArranger;
        }

        // The lending group (syndicate): many participant lenders may join a facility
        connection def facilityHasParticipantLender {
            end [1] part facility : LoanFacility;
            end [0..*] part lenderParticipant : ParticipantLender;
        }

        // Commitments and allocations
        connection def facilityHasCommitment {
            end [1] part facility : LoanFacility;
            end [0..*] item commitment : Commitment;
        }

        connection def lenderHasAllocation {
            end [1] part lender : ParticipantLender;
            end [0..*] item lenderAllocation : Allocation;
        }

        // Drawdowns against facilities (ordered chronologically)
        connection def facilityHasDrawdown {
            end [1] part facility : LoanFacility;
            end [0..*] ordered item drawdown : Drawdown;
        }

        // Interest periods at the facility level (ordered)
        connection def facilityHasInterestPeriod {
            end [1] part facility : LoanFacility;
            end [0..*] ordered item period : InterestPeriod;
        }

        // Fees at loan or facility level
        connection def loanHasFee {
            end [1] part loan : SyndicatedLoan;
            end [0..*] item fee : Fee;
        }

        connection def facilityHasFee {
            end [1] part facility : LoanFacility;
            end [0..*] item fee : Fee;
        }
    }
    // =========================================================
    // Subpackage 6/11 — ExerciseConventions.rdf
    // =========================================================
    package ExerciseConventions {

        // Conventions governing when and how an embedded option may be exercised
        item def ExerciseConvention {
            attribute style : String[0..1];               // e.g., American, European, Bermudan
            attribute noticePeriodDays : Integer[0..1];   // advance notice required
            attribute settlementDays : Integer[0..1];     // days to settlement post-exercise
            attribute businessDayRule : String[0..1];     // e.g., Following, ModifiedFollowing
            attribute cutOffTime : String[0..1];          // local time, e.g., "16:00"
        }

        item exerciseConvention : ExerciseConvention;

        // Optional explicit windows for exercise eligibility
        item def ExerciseWindow {
            attribute windowStart : ExplicitDate[0..1];
            attribute windowEnd : ExplicitDate[0..1];
            attribute frequency : String[0..1];           // e.g., Daily, Monthly, Quarterly
        }

        // Basic non-negative guard for day counts
        constraint def NonNegativeIntegerDays {
            in n : Integer;
            n >= 0
        }

        // Bind guards to convention attributes
        constraint notice_days_non_negative : NonNegativeIntegerDays {
            in n = exerciseConvention.noticePeriodDays;
        }

        constraint settlement_days_non_negative : NonNegativeIntegerDays {
            in n = exerciseConvention.settlementDays;
        }

        // ----- Connections to option-bearing debt instruments -----

        // Callable bonds can reference one or more exercise conventions (ordered for precedence)
        connection def callableBondUsesExerciseConvention {
            end [1] part bond : Bonds::CallableBond;
            end [0..*] ordered item convention : ExerciseConvention;
        }

        // Puttable bonds can reference exercise conventions
        connection def puttableBondUsesExerciseConvention {
            end [1] part bond : Bonds::PuttableBond;
            end [0..*] ordered item convention : ExerciseConvention;
        }

        // Prepayment options on loans may also reference exercise conventions
        connection def prepaymentOptionUsesExerciseConvention {
            end [1] item prepayOption : DebtInstruments::PrepaymentOption;
            end [0..1] item convention : ExerciseConvention;
        }

        // Conventions may declare one or more explicit exercise windows
        connection def exerciseConventionHasWindow {
            end [1] item convention : ExerciseConvention;
            end [0..*] ordered item exerciseWindow : ExerciseWindow;
        }
    }
    // =========================================================
    // Subpackage 7/11 — MortgageBackedSecurities.rdf
    // =========================================================
    package MortgageBackedSecurities {

        // Specializations within the MBS family
        part def PassThroughMBS specializes AssetBackedSecurities::MortgageBackedSecurity;
        part def AgencyMBS specializes AssetBackedSecurities::MortgageBackedSecurity;
        part def NonAgencyMBS specializes AssetBackedSecurities::MortgageBackedSecurity;

        // Common agency guarantors (modeled as organizations for now)
        part def GinnieMae specializes Organization;
        part def FannieMae specializes Organization;
        part def FreddieMac specializes Organization;

        // ----- Mortgage loans and pool-level analytics -----

        // Mortgage loan as a specialization of the generic ABS UnderlyingAsset
        item def MortgageLoan specializes AssetBackedSecurities::UnderlyingAsset {
            attribute originalBalance : Real[0..1];
            attribute currentBalance : Real[0..1];
            attribute noteRatePct : Real[0..1];
            attribute loanPurpose : String[0..1];      // e.g., Purchase, Refi, CashOut
            attribute occupancyType : String[0..1];    // e.g., Owner, Second, Investor
            attribute lienPosition : String[0..1];     // e.g., First, Second
            attribute originationDate : ExplicitDate[0..1];
            attribute maturityDate : ExplicitDate[0..1];
            attribute amortizationType : String[0..1]; // e.g., Fixed, ARM, IO
            attribute loanToValuePct : Real[0..1];

            constraint note_rate_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = noteRatePct;
            }
            constraint ltv_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = loanToValuePct;
            }
        }

        // Pool factor history (factor ∈ [0,1])
        item def PoolFactorRecord {
            attribute asOfDate : ExplicitDate[0..1];
            attribute factor : Real[0..1];
        }

        // Weighted averages commonly reported for pools
        item def WeightedAverages {
            attribute wamMonths : Integer[0..1];       // weighted average maturity (months)
            attribute walaMonths : Integer[0..1];      // weighted average loan age (months)
            attribute wacPct : Real[0..1];             // weighted average coupon (%)

            constraint wac_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = wacPct;
            }
            constraint wam_non_negative : NonNegativeInteger {
                in n = wamMonths;
            }
            constraint wala_non_negative : NonNegativeInteger {
                in n = walaMonths;
            }
        }

        // Prepayment assumptions (CPR/SMM or PSA multiplier)
        item def PrepaymentAssumption {
            attribute cprPct : Real[0..1];
            attribute smmPct : Real[0..1];
            attribute psaMultiplier : Real[0..1];      // 100 = PSA standard

            constraint cpr_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = cprPct;
            }
            constraint smm_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = smmPct;
            }
            constraint psa_non_negative : NonNegativeReal {
                in x = psaMultiplier;
            }
        }

        // ----- Connections -----

        // MBS ⇄ Pool (specific alias; complements ABS::backedByPool)
        connection def mbsBackedByPool {
            end [1] part mbs : AssetBackedSecurities::MortgageBackedSecurity;
            end [0..1] item pool : AssetBackedSecurities::AssetPool;
        }

        // Pools contain mortgage loans (ordered for reproducible listings)
        connection def poolHasMortgageLoan {
            end [1] item pool : AssetBackedSecurities::AssetPool;
            end [0..*] ordered item mortgageLoan : MortgageLoan;
        }

        // Factor history for an MBS (ordered by as-of date)
        connection def mbsHasFactorHistory {
            end [1] part mbs : AssetBackedSecurities::MortgageBackedSecurity;
            end [0..*] ordered item factorRecord : PoolFactorRecord;
        }

        // Weighted averages snapshot (optional)
        connection def mbsHasWeightedAverages {
            end [1] part mbs : AssetBackedSecurities::MortgageBackedSecurity;
            end [0..1] item weightedAverages : WeightedAverages;
        }

        // Prepayment assumption (optional)
        connection def mbsHasPrepaymentAssumption {
            end [1] part mbs : AssetBackedSecurities::MortgageBackedSecurity;
            end [0..1] item assumption : PrepaymentAssumption;
        }

        // Agency guarantee for agency MBS (exactly one agency guarantor)
        connection def agencyMbsGuaranteedBy {
            end [0..*] part mbs : AgencyMBS;
            end [1] part guarantor : Organization;   // typically GinnieMae, FannieMae, or FreddieMac
        }
    }
    // =========================================================
    // Subpackage 8/11 — PoolBackedSecurities.rdf
    // =========================================================
    package PoolBackedSecurities {

        // Generic pool-backed security (kept under the ABS umbrella for reuse)
        part def PoolBackedSecurity specializes AssetBackedSecurities::AssetBackedSecurity;

        // High-level structures often seen with pool-backed deals
        part def PassThroughSecurity specializes PoolBackedSecurity;
        part def PayThroughSecurity specializes PoolBackedSecurity;

        // Certificates representing investor interests in the pool-backed deal
        item def PoolCertificate {
            attribute certificateId : String[0..1];
            attribute faceAmount : Real[0..1];
            attribute currentFactor : Real[0..1];

            // factor ∈ [0,1]
            constraint factor_between_0_and_1 : FIBO_FND_Constraints::Between0And1 {
                in x = currentFactor;
            }
        }

        // Optional grouping of certificates by class (if not using Tranche as the class)
        item def CertificateClass {
            attribute className : String[0..1];               // e.g., Class A, IO, PO
            attribute originalFaceAmount : Real[0..1];
        }

        // -------------------------
        // Connections (cross features)
        // -------------------------

        // Pool-backed security is supported by an asset pool
        connection def pbsBackedByPool {
            end [1] part pbs : PoolBackedSecurity;
            end [0..1] item pool : AssetBackedSecurities::AssetPool;
        }

        // Certificates associated to a given pool-backed security (ordered for reporting)
        connection def pbsHasCertificate {
            end [1] part pbs : PoolBackedSecurity;
            end [0..*] ordered item certificate : PoolCertificate;
        }

        // Optional classification of certificates
        connection def certificateBelongsToClass {
            end [0..*] item certificate : PoolCertificate;
            end [0..1] item class : CertificateClass;
        }

        // If classes act like tranches, relate the PBS to ABS Tranche as well
        connection def pbsHasTranche {
            end [0..*] ordered part pbs : PoolBackedSecurity;
            end [0..*] part tranche : AssetBackedSecurities::Tranche;
        }

        // Certificate factor history using the MBS pool factor record
        connection def certificateHasFactorHistory {
            end [1] item certificate : PoolCertificate;
            end [0..*] ordered item factorRecord : MortgageBackedSecurities::PoolFactorRecord;
        }

        // Optional deal parties reused from ABS (servicer, trustee)
        connection def pbsServicedBy {
            end [0..*] part pbs : PoolBackedSecurity;
            end [0..1] part servicer : AssetBackedSecurities::Servicer;
        }

        connection def pbsHasTrustee {
            end [0..*] part pbs : PoolBackedSecurity;
            end [0..1] part trustee : AssetBackedSecurities::Trustee;
        }
    }
    // =========================================================
    // Subpackage 9/11 — SyntheticCDOs.rdf
    // =========================================================
    package SyntheticCDOs {

        // Synthetic CDO (references credit risk via CDS rather than holding cash assets)
        part def SyntheticCDO specializes CollateralizedDebtObligations::CollateralizedDebtObligation;

        // -------------------------
        // Stored / flow artifacts
        // -------------------------

        // Reference portfolio and entries (entities/obligations + weights)
        item def ReferencePortfolio;

        item def ReferencePortfolioEntry {
            attribute referenceObligation : String[0..1];    // e.g., senior unsecured bond id
            attribute notionalAmount : Real[0..1];
            attribute weightPct : Real[0..1];

            // Bind to a legal entity from BE_LegalEntities
            attribute referenceEntity : LegalEntity[0..1];

            constraint weight_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = weightPct;
            }
        }

        // CDS contract parameters used within the synthetic structure
        item def CreditDefaultSwap {
            attribute fixedRatePct : Real[0..1];             // coupon on CDS
            attribute maturityDate : ExplicitDate[0..1];
            attribute paymentFrequency : String[0..1];       // e.g., Quarterly

            constraint fixed_rate_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = fixedRatePct;
            }
        }

        // Tranche attachment / detachment terms for loss allocation
        item def TrancheTerm {
            attribute attachmentPct : Real[0..1];
            attribute detachmentPct : Real[0..1];
            attribute trancheNotional : Real[0..1];

            constraint attachment_detachment_valid : AttachmentDetachmentValid {
                in attachPct = attachmentPct;
                in detachPct = detachmentPct;
            }
        }

        // -------------------------
        // Constraints (defs)
        // -------------------------
        constraint def AttachmentDetachmentValid {
            in attachPct : Real;
            in detachPct : Real;
            attachPct >= 0.0 and attachPct < detachPct and detachPct <= 100.0
        }

        // -------------------------
        // Connections
        // -------------------------

        // Portfolio binding
        connection def cdoReferencesPortfolio {
            end [1] part cdo : SyntheticCDO;
            end [0..1] item portfolio : ReferencePortfolio;
        }

        connection def portfolioHasEntry {
            end [1] item portfolio : ReferencePortfolio;
            end [0..*] item referencePortfolioEntry : ReferencePortfolioEntry;
        }

        // CDS usage within the structure (protection bought/sold at deal level)
        connection def cdoUsesCds {
            end [1] part cdo : SyntheticCDO;
            end [0..*] item cds : CreditDefaultSwap;
        }

        // Link ABS tranches to tranche terms (attachment/detachment)
        connection def trancheHasTrancheTerm {
            end [1] part tranche : AssetBackedSecurities::Tranche;
            end [0..1] item term : TrancheTerm;
        }

        // Optional: relate individual reference portfolio entries to CDS (when bespoke)
        connection def cdsCoversReferenceEntry {
            end [1] item cds : CreditDefaultSwap;
            end [0..*] item referencePortfolioEntry : ReferencePortfolioEntry;
        }
    }
    // =========================================================
    // Subpackage 10/11 — TradedShortTermDebt.rdf
    // =========================================================
    package TradedShortTermDebt {

        // Core abstraction for money-market style traded short-term debt (≤ 1 year)
        part def TradedShortTermDebtInstrument specializes DebtSecurity {
            attribute dayToMaturity : Integer[0..1];         // days until maturity (≤ 366 typical)
            attribute issuanceDiscountRatePct : Real[0..1];  // discount-rate quotation
            attribute faceAmount : Real[0..1];               // redemption amount

            constraint discount_rate_in_range : FIBO_FND_Constraints::PercentBetween0And100 {
                in x = issuanceDiscountRatePct;
            }
            constraint days_non_negative : FIBO_FND_Constraints::NonNegativeInteger {
                in n = dayToMaturity;
            }
        }

        // Common instrument types
        part def CommercialPaper specializes TradedShortTermDebtInstrument;         // unsecured issuer promissory note
        part def BankersAcceptance specializes TradedShortTermDebtInstrument;       // draft accepted by a bank
        part def NegotiableCertificateOfDeposit specializes TradedShortTermDebtInstrument; // transferable time deposit
        part def TreasuryBill specializes TradedShortTermDebtInstrument;            // short-term sovereign bill

        // Optional program wrapper for CP issuance
        item def CommercialPaperProgram {
            attribute programName : String[0..1];
            attribute maxProgramSize : Real[0..1];
            attribute programCurrency : String[0..1];
        }

        // Ratings and dealers commonly associated with TSTD issuance
        part def MoneyMarketDealer specializes Organization;

        item def ShortTermCreditRating {
            attribute agency : String[0..1];                 // e.g., S&P, Moody's, Fitch
            attribute ratingCode : String[0..1];             // e.g., A-1, P-1, F1
            attribute asOfDate : ExplicitDate[0..1];
        }

        // -------------------------
        // Connections (cross features)
        // -------------------------

        // Issuer relationship (issuer is a LegalEntity)
        connection def tstdIssuedBy {
            end [0..*] part instrument : TradedShortTermDebtInstrument;
            end [1] part issuer : LegalEntity;
        }

        // Dealer(s) for the issuance and distribution
        connection def tstdDistributedBy {
            end [0..*] part instrument : TradedShortTermDebtInstrument;
            end [0..*] part dealer : MoneyMarketDealer;
        }

        // Short-term ratings (separate from long-term ratings used on bonds)
        connection def tstdHasShortTermRating {
            end [1] part instrument : TradedShortTermDebtInstrument;
            end [0..*] item rating : ShortTermCreditRating;
        }

        // Commercial paper optionally tied to a CP program
        connection def cpUnderProgram {
            end [0..*] part cp : CommercialPaper;
            end [0..1] item program : CommercialPaperProgram;
        }

        // Negotiable CDs typically issued by a depository institution (issuer captured above);
        // Bankers’ acceptances reference an accepting bank as issuer via the same tstdIssuedBy connection.
        // Treasury bills may also be linked to Sovereign issuers via issuer specialization already modeled in BE.
    }
    // =========================================================
    // Subpackage 11/11 — MetadataSECDebt.rdf
    // =========================================================
    package MetadataSECDebt {

        // Specialization of the generic BE ontology metadata for the SEC/Debt domain
        item def SECDebtOntologyMetadata specializes OntologyMetadata;

        // Optional module reference alias (can point at any SEC/Debt subpackage)
        item def SECDebtModuleReference specializes ModuleReference;

        // -------------------------
        // Connections (cross features)
        // -------------------------

        // Attach SEC/Debt-specific metadata to any debt security definition
        connection def secDebtHasModuleMetadata {
            end [1] item moduleMetadata : SECDebtOntologyMetadata;
            end [0..*] part debtSecuritySubject : DebtSecurity;
        }

        // Declare which subpackages/modules this metadata entry covers
        connection def secDebtMetadataDescribesModule {
            end [1] item moduleMetadata : SECDebtOntologyMetadata;
            end [0..*] item module : SECDebtModuleReference;
        }

        // Publisher / maintainer / contributor links (reuse Organization from BE)
        connection def secDebtMetadataPublishedBy {
            end [1] item moduleMetadata : SECDebtOntologyMetadata;
            end [0..1] part publisher : Organization;
        }

        connection def secDebtMetadataMaintainedBy {
            end [1] item moduleMetadata : SECDebtOntologyMetadata;
            end [0..*] part maintainer : Organization;
        }

        connection def secDebtMetadataContributedBy {
            end [1] item moduleMetadata : SECDebtOntologyMetadata;
            end [0..*] ordered part contributor : Organization;
        }
    }

}


