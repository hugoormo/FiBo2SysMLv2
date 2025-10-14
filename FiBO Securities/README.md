# Securities (FIBO_SEC)
## Overview
The FIBO_SEC (Securities) package family models securities instruments and market structures.
Within this hierarchy, FIBO_SEC_Debt defines the full range of debt instruments—from bonds and loans to structured and synthetic products—faithfully mapped from the EDM Council FIBO SEC ontologies.

## Package Structure
FIBO_SEC  
│  
├── FIBO_SEC_All  
│   └─ Aggregator importing all SEC modules  
│  
└── FIBO_SEC_Debt  
    ├─ AssetBackedSecurities  
    ├─ Bonds  
    ├─ CollateralizedDebtObligations  
    ├─ DebtInstruments  
    ├─ DistributedLoans  
    ├─ ExerciseConventions  
    ├─ MortgageBackedSecurities  
    ├─ PoolBackedSecurities  
    ├─ SyntheticCDOs  
    ├─ TradedShortTermDebt  
    └─ MetadataSECDebt  

## Imports and Dependencies
Each subpackage inherits the shared core of DebtSecurity and the common numeric constraints:
```sysml
private import ScalarValues::*;
private import FIBO_FND_Constraints::*;
private import FIBO_BE_Corporations::*;
private import FIBO_BE_FunctionalEntities::*;
private import FIBO_BE_LegalEntities::*;
private import FIBO_BE_Metadata::*;
```
## Highlights by Subpackage
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

## Modeling Notes
* DebtSecurity is the shared superclass across all subpackages.
* Cross-package references use qualified names (e.g., AssetBackedSecurities::Tranche).
* Common constraints reference FIBO_FND_Constraints (e.g., PercentBetween0And100).
* Connections define cross multiplicities, ordering, and directionality explicitly.
* Each subpackage is self-contained but interoperable via imports.

## Purpose
FIBO_SEC_Debt captures the entire structured debt landscape within SysML v2, mirroring the semantics of the EDM Council FIBO SEC ontologies while maintaining SysML-compliant structure and reusable patterns.