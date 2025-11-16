# Market Data (FIBO_MD)

## Overview
The **FIBO_MD (Market Data)** domain defines the structures, semantics, and temporal behaviors of market-observed and reported financial data.  
It models the **time-dependent aspects** of financial instruments — including **prices, rates, NAVs, credit and trading statuses, and derivative quotations** — across asset classes.  
This domain provides the temporal and analytical layer that integrates with **Financial Business and Commerce (FBC)** and **Derivatives (DER)** to support valuation, performance tracking, and regulatory analytics.

This repository provides the **SysML v2 implementation** of the FIBO Market Data domain as a set of **Configuration Items (CIs)**.  
Each CI focuses on a specific area of time-dependent data (e.g., funds, debt, derivatives, or security statuses) and follows consistent modeling conventions for interoperability with other FIBO domains.

---

## Scope & Objectives
* Define reusable temporal structures for **market data records**, **quotes**, **rates**, and **valuations**.  
* Capture **time series**, **lifecycle events**, and **historical datasets** for all major financial products.  
* Model **reference data relationships** between instruments, markets, and analytical measures.  
* Provide **integrated temporal frameworks** for fund performance, debt analytics, and derivative time series.  
* Represent **status tracking** for securities — including trading halts, credit events, and rating changes.  
* Ensure alignment with **ISO, IOSCO, and regulatory data standards** for market transparency and auditability.

---

## Package Structure
FIBO_MD  
│  
├─ FIBO_MD_CIVTemporal # collective investment vehicle (fund) temporal data  
│ └─ FundsTemporal # fund attributes, NAVs, dividends, events, and share classes  
│  
├─ FIBO_MD_DebtTemporal # time-dependent debt instrument analytics  
│ └─ DebtTemporal # coupons, pricing, yield curves, valuations, events, and ratings  
│  
├─ FIBO_MD_DerivativesTemporal # temporal data for derivatives and futures/options  
│ ├─ FuturesTemporal # futures quotes, events, positions, and valuation  
│ └─ ETOptionsTemporal # listed option series, quotes, implied vols, and lifecycle events  
│  
└─ FIBO_MD_TemporalCore # security trading and credit status tracking  
├─ SecurityTradingStatuses # listings, trading halts, and venue statuses  
└─ SecurityCreditStatuses # credit ratings, defaults, recoveries, and credit performance  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_*` — foundational definitions for DatesAndTimes, Contracts, Law, and CurrencyAmount  
- `FIBO_FBC_*` — Financial Business and Commerce (FinancialInstruments, Markets, BusinessCenters)  
- `FIBO_DER_*` — Derivatives domain for instrument linkages  
- `FIBO_IND_*` — Indices & Indicators (benchmark references, rates, and market indicators)  
- `FIBO_FND_Utilities` — Analytics and AnnotationVocabulary for datasets and metrics  
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `CIVTemporal` ↔ `DebtTemporal` ↔ `DerivativesTemporal` — shared temporal analytics and valuation patterns  
- `TemporalCore` ↔ `DebtTemporal` — credit and trading status data for fixed income and securitized assets  
- `Indicators` (IND) ↔ `DebtTemporal` — benchmark rate and spread references  
- `FinancialInstruments` (FBC) ↔ `All MD CIs` — primary instrument linkage

**Downstream (consumers):**
- `FIBO_BP_*` (Business Processes — reporting and analytics processes)  
- `FIBO_SEC_*` (Securities — market and instrument-level integrations)  
- `FIBO_FBC_*` (FunctionalEntities — markets, institutions, and registries)

---

## Design Principles
* **Feature-based modeling:**  
  Market data relationships are expressed as SysML features (attributes) instead of associations, emphasizing traceability and analytical reuse.  
* **Processor vs. processed:**  
  - *Parts* represent actors (fund managers, rating agencies, exchanges, clearinghouses).  
  - *Items* represent observed or derived data entities (quotes, NAVs, valuations, series).  
* **Temporal focus:**  
  Every entity includes explicit dates (`asOf`, `effectiveFrom`, `effectiveTo`) or periods to support historical tracking and analytics.  
* **Interoperability:**  
  Reuses `Analytics::Dataset`, `Indicators::Index`, and `FinancialInstruments::*` to ensure alignment across FIBO domains.  
* **Alignment with market standards:**  
  Conforms to ISO 10962 (CFI), ISO 10383 (MIC), IOSCO principles for market benchmarks, and IFRS 13 fair value guidance.  
* **Extensibility:**  
  Enables expansion for ESG, climate, and alternative data in future iterations.

---

## Coding Conventions
* **Packages:** `FIBO_MD_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — processors (publishers, exchanges, administrators)  
  - `item def` — processed market data entities (quotes, statuses, events, series)  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** `doc/* … */` included for all elements  
* **Imports:** explicit `private` or `public` statements — no implicit dependencies

---

## Versioning & Configuration Policy
* Each package is an independent **Configuration Item (CI)** under the FIBO_MD domain.  
* CIs follow the same **SysMLv2 configuration management plan** as other domains.  
* Updates maintain backward compatibility for analytics and temporal models.  
* Temporal CIs are designed for **continuous data ingestion and auditability**.

---

## Purpose
The **FIBO Market Data (MD)** domain serves as the dynamic layer of the FIBO architecture, representing how financial instruments behave and evolve over time.  
It provides the modeling framework for:
- time-dependent valuation, rates, and performance;  
- regulatory transparency (trading halts, ratings, defaults); and  
- analytical integration across funds, debt, and derivatives.

Through **SysML v2**, the FIBO_MD domain ensures that all market data — from NAVs to volatility surfaces — can be modeled, traced, and analyzed in a consistent, interoperable manner.

---

### References
* [EDMC FIBO Market Data Specification](https://spec.edmcouncil.org/fibo/)  
* [IOSCO Principles for Financial Benchmarks](https://www.iosco.org/)  
* [ISO 10962 (CFI) – Classification of Financial Instruments](https://www.iso.org/standard/74838.html)  
* [ISO 10383 (MIC) – Market Identifier Codes](https://www.iso.org/standard/51081.html)  
* [IFRS 13 – Fair Value Measurement](https://www.ifrs.org/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
