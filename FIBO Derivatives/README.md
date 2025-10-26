# Derivatives (FIBO_DER)

## Overview
The **FIBO_DER (Derivatives)** domain models derivative contracts and instruments — financial arrangements whose value depends on the performance of one or more underlying assets, rates, indices, or credit events.  
It captures **contractual structures**, **economic terms**, and **market conventions** across all major derivative classes including **rate, credit, currency, commodity, and security-based derivatives**.

This repository provides the **SysML v2 implementation** of the FIBO Derivatives domain as a set of configuration-controlled **Configuration Items (CIs)**.  
Each CI is feature-based, formally typed, and uses the same *processor vs. processed* distinction established in FIBO Foundations:
- **Parts** represent processors or actors (e.g., counterparties, clearinghouses).  
- **Items** represent contracts, instruments, transactions, and records that are exchanged, settled, or valued.

---

## Scope & Objectives
* Provide a **formal data architecture** for all derivative contracts consistent with FIBO semantics.  
* Model **economic terms**, **payoffs**, and **market conventions** across derivative asset classes.  
* Support analysis of **exposure, valuation, and risk** for both bilateral OTC and standardized exchange-traded instruments.  
* Enable **traceability to underlying assets, agreements, and credit events** modeled in FIBO Foundations.  
* Maintain modularity and extensibility for additional derivative types and hybrids.

---

## Package Structure
FIBO_DER  
│  
├─ FIBO_DER_DerivativesContracts # core derivative contracts and families  
│ ├─ DerivativesBasics # shared definitions, payoff, and terms  
│ ├─ DerivativesMasterAgreements # ISDA and credit support annex structures  
│ ├─ FuturesAndForwards # OTC forwards and exchange-traded futures  
│ ├─ Options # vanilla options, calls, puts  
│ ├─ ExoticOptions # barrier, digital, Asian, lookback, chooser  
│ ├─ RightsAndWarrants # equity warrants, subscription rights  
│ ├─ Swaps # interest rate, cross-currency, equity, commodity, TRS  
│ ├─ SwapsIndividuals # canonical swap archetypes (e.g., IRS, OIS)  
│ ├─ CommoditiesContracts # commodity forwards and delivery notices  
│ ├─ CurrencyContracts # FX spot, forwards, swaps, NDFs  
│ └─ StructuredInstruments # structured notes and hybrid instruments  
│  
├─ FIBO_DER_CreditDerivatives # credit default swaps and protection structures  
│ └─ CreditDefaultSwaps # single-name, index, tranche, basket CDS  
│  
├─ FIBO_DER_RateDerivatives # rate-based derivatives (interest rate)  
│ ├─ RateDerivatives # FRAs, caps/floors, collars, swaptions, rate futures  
│ ├─ IRSwaps # IRS and OIS contracts, conventions  
│ └─ IRSwapExampleIndividuals # canonical IRS examples (5Y, OIS, ZC OIS)  
│  
└─ FIBO_DER_SecurityBasedDerivatives # equity and bond-linked derivatives  
├─ SecurityBasedDerivatives # general model for equity-linked derivatives  
└─ EquitySwaps # TRS, index/basket swaps, variance/volatility swaps  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_Accounting`, `FIBO_FND_Contracts`, `FIBO_FND_Parties`
- `FIBO_FND_Organizations`, `FIBO_FND_Law`, `FIBO_FND_OwnershipAndControl`
- `FIBO_FND_DatesAndTimes`, `FIBO_FND_ProductsAndServices`, `FIBO_FND_Places`
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `DerivativesContracts` ↔ `CreditDerivatives` (credit protection swaps)
- `RateDerivatives` ↔ `DerivativesContracts.Swaps` (IRS/OIS conventions)
- `SecurityBasedDerivatives` ↔ `DerivativesContracts.StructuredInstruments`
- Shared dependency on **Contracts**, **Agreements**, **CurrencyAmount**, and **FinancialDates**

**Downstream (consumers):**
- `FIBO_SEC_*`, `FIBO_FBC_*`, and analytical models for pricing and valuation

---

## Design Principles
* **Feature-based modeling:** all economic relationships are captured as features; associations are avoided unless semantically required.  
* **Processor vs. processed:**  
  - *Parts* represent agents and infrastructures that perform actions (e.g., clearinghouses, counterparties).  
  - *Items* represent derivative contracts, obligations, or market records acted upon.  
* **Market-aligned terminology:** terms and definitions correspond to ISDA, ICMA, and market convention language.  
* **Extensibility:** each derivative family (rate, credit, equity, FX, commodity) can be extended independently.  
* **Traceability:** every instrument can reference underlying assets, laws, and agreements defined in FIBO Foundations.  

---

## Coding Conventions
* **Packages:** `FIBO_DER_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — active participants (e.g., counterparties, agents)  
  - `item def` — contracts, terms, or records (processed entities)  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** use `doc/* … */` for ontological definitions  
* **Imports:** every reference explicitly declared as `private` or `public`  

---

## Versioning & Configuration Policy
* Each derivative family is an independent **Configuration Item (CI)** with its own baseline.  
* CI versions evolve independently with semantic traceability to the FIBO Derivatives ontology.  
* All downstream packages should import from these CIs — not redefine derivative constructs.

---

## Purpose
The **FIBO Derivatives CI family** implements the full FIBO Derivatives domain in SysML v2 syntax.  
It provides a coherent framework for modeling the structure, terms, and interdependencies of derivative instruments, enabling:
- consistent analysis across asset classes,  
- interoperability with FIBO Foundations models, and  
- model-based generation of derivative contract templates, analytics, and risk management structures.

---

### References
* [EDMC FIBO Derivatives Specification](https://spec.edmcouncil.org/fibo/)  
* [ISDA Common Domain Model (CDM)](https://www.isda.org/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
