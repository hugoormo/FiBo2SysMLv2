# Securities (FIBO_SEC)
## Overview
The FIBO_SEC (Securities) package family models securities instruments and market structures. It integrates multiple subdomains of the EDM Council FIBO Securities ontologies, including Debt, Equities, Funds, and the newly added FIBO_SEC_Securities group — which defines the general framework for securities identification, classification, issuance, listings, and restrictions.

Within this hierarchy:
* FIBO_SEC_Debt defines the full range of debt instruments — from bonds and loans to structured and synthetic products.
* FIBO_SEC_Equities defines ownership instruments (common and preferred shares) and equity-specific rights, listings, and dividend features.
* FIBO_SEC_Funds defines investment fund structures, share classes, NAV valuation mechanisms, and fund hierarchies.
* FIBO_SEC_Securities establishes the foundational abstraction of a Security and its associated features (identification, restriction, classification, etc.), reused by all other SEC packages.

## Package Structure
FIBO_SEC  
│  
├── FIBO_SEC_All  
│   └─ Aggregator importing all SEC modules  
│  
├── FIBO_SEC_Debt  
│ ├─ AssetBackedSecurities  
│ ├─ Bonds  
│ ├─ CollateralizedDebtObligations  
│ ├─ DebtInstruments  
│ ├─ DistributedLoans  
│ ├─ ExerciseConventions  
│ ├─ MortgageBackedSecurities  
│ ├─ PoolBackedSecurities  
│ ├─ SyntheticCDOs  
│ ├─ TradedShortTermDebt  
│ └─ MetadataSECDebt  
│  
├── FIBO_SEC_Equities  
│ ├─ CommonEquities  
│ ├─ PreferredEquities  
│ ├─ EquityInstruments  
│ ├─ ShareIssuance  
│ ├─ EquityListings  
│ ├─ VotingRights  
│ └─ MetadataSECEquities  
│  
├── FIBO_SEC_Funds  
│ ├─ CollectiveInvestmentVehicles  
│ ├─ FundUnits  
│ ├─ NAVCalculation  
│ ├─ FundHoldings  
│ ├─ FundIssuance  
│ ├─ FundListings  
│ └─ MetadataSECFunds  
│  
└── FIBO_SEC_Securities  
├─ Baskets  
├─ MetadataSECSecurities  
├─ ParametricSchedules  
├─ Pools  
├─ SecuritiesClassification  
├─ SecuritiesIdentification  
├─ SecuritiesIdentificationIndividuals  
├─ SecuritiesIssuance  
├─ SecuritiesListings  
├─ SecuritiesRestrictions  
└─ SecurityAssets  

## Imports and Dependencies
Each subpackage inherits the shared core of DebtSecurity and the common numeric constraints:
```sysml
private import ScalarValues::*;
private import Time::*;
private import FIBO_FND_Constraints;
private import FIBO_BE;
private import FIBO_BE_LegalEntities;
private import FIBO_SEC;
private import FIBO_SEC_Debt;
private import FIBO_SEC_Equities;
private import FIBO_SEC_Funds;
```
## Highlights by Subpackage
### FIBO_SEC_Debt
* AssetBackedSecurities — Tranches, SPVs, AssetPools, WaterfallRules.
* Bonds — Government, Corporate, Callable, Convertible, Secured/Unsecured forms.
* CollateralizedDebtObligations — CDO/CLO/CBO, managers, tests, and buckets.
* DebtInstruments — Loans, Notes, floating/fixed rate instruments, payment schedules.
* DistributedLoans — Syndicated loans, facilities, lenders, commitments, allocations.
* ExerciseConventions — Option exercise styles, windows, notice periods.
* MortgageBackedSecurities — MBS pool analytics, factors, prepayment assumptions.
* PoolBackedSecurities — Generic pool-backed deals, certificates, tranches.
* SyntheticCDOs — CDS-based CDOs, reference portfolios, tranche terms.
* TradedShortTermDebt — Commercial Paper, Bankers’ Acceptances, T-Bills, CP programs.
* MetadataSECDebt — Module metadata for the Debt domain (extends OntologyMetadata).
### FIBO_SEC_Equities
* CommonEquities — Definitions for common stock, ownership rights, and dividends.
* PreferredEquities — Preferred share classes, dividends, and liquidation preferences.
* EquityInstruments — Core abstractions and relationships for shares and equity securities.
* ShareIssuance — Equity issuance events, rights offerings, and capital increases.
* EquityListings — Exchange listings, ticker identifiers, and trading venues.
* VotingRights — Governance structures and voting mechanisms.
* MetadataSECEquities — Metadata for the Equities domain.

### FIBO_SEC_Funds
* CollectiveInvestmentVehicles — Fund structures (mutual funds, ETFs, SICAVs, etc.).
* FundUnits — Fund share classes, units, and holder rights.
* NAVCalculation — Net Asset Value determination and valuation frequency.
* FundHoldings — Underlying assets and composition disclosure.
* FundIssuance — Primary issuance and redemption processes.
* FundListings — Exchange-traded fund listings and market structures.
* MetadataSECFunds — Metadata for the Funds domain.

### FIBO_SEC_Securities
* Core — foundational abstractions: Security, Issuer, SecurityIdentification, SecurityClassification, SecurityRestriction, SecurityAsset, etc.
* Baskets — definitions of basket securities and constituent weighting.
* ParametricSchedules — reusable timing conventions (payment, observation, reset schedules).
* Pools — pooled assets and structured interests.
* SecuritiesClassification — high-level classification and ISO 10962 (CFI) mapping.
* SecuritiesIdentification — ISIN, CUSIP, FIGI, Ticker identifiers and their connections.
* SecuritiesIssuance — issuance process, offering types, and offering documentation.
* SecuritiesListings — listing venues (exchanges, MTFs/OTFs) and listing connections.
* SecuritiesRestrictions — holding and transfer constraints.
* SecurityAssets — asset structures backing securities (indexes, baskets, and pools).
* MetadataSECSecurities — metadata module for the Securities domain.

## Modeling Notes
* DebtSecurity is the shared superclass across all subpackages.
* Cross-package references use qualified names (e.g., AssetBackedSecurities::Tranche).
* Common constraints reference FIBO_FND_Constraints (e.g., PercentBetween0And100).
* Connections define cross multiplicities, ordering, and directionality explicitly.
* Each subpackage is self-contained but interoperable via imports.

## Purpose
The FIBO_SEC family provides a comprehensive SysML v2 representation of financial securities, consistent with the EDM Council FIBO SEC ontologies. The new FIBO_SEC_Securities CI defines the canonical, reusable core for securities across all instrument classes — enabling traceable, model-based integration between Debt, Equities, Funds, and future extensions.