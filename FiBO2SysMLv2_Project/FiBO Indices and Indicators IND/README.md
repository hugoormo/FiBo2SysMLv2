# Indices and Indicators (FIBO_IND)

## Overview
The **FIBO_IND (Indices & Indicators)** domain models quantitative measures and benchmarks used in financial and economic analysis.  
It defines the structure, calculation, publication, and classification of **economic indicators**, **market indexes**, **interest rate benchmarks**, and **foreign exchange reference rates**.  
These concepts form the analytical backbone for pricing, performance evaluation, monetary policy, and macroeconomic reporting.

This repository provides the **SysML v2 implementation** of the FIBO Indices and Indicators domain as a collection of **Configuration Items (CIs)**.  
Each CI focuses on a specific type of indicator or index, built upon FIBO’s foundational elements (FND) and the Financial Business and Commerce (FBC) entities.

---

## Scope & Objectives
* Define reusable models for **economic indicators**, **financial indexes**, and **reference rates**.  
* Capture **methodologies, publishers, and conventions** governing each indicator or benchmark.  
* Model **localized and international** economic data across regions and organizations.  
* Enable consistent linkage between indicators, instruments, currencies, and organizations.  
* Support analytical and time-series alignment with the **Utilities::Analytics** packages.

---

## Package Structure
FIBO_IND  
│  
├─ FIBO_IND_EconomicIndicators # generic economic indicators, frequencies, releases, vintages  
│ └─ EconomicIndicators # GDP, CPI, unemployment, retail sales, confidence, etc.  
│  
├─ FIBO_IND_NorthAmericaEconomicIndicators # localized indicators for U.S. and Canada  
│ ├─ USEconomicIndicators # CPI, GDP, PCE, ISM PMI, etc. (U.S.)  
│ └─ CAEconomicIndicators # CPI, GDP, Ivey PMI, etc. (Canada)  
│  
├─ FIBO_IND_ForeignExchange # FX pairs, quotes, fixings, and calendars  
│ └─ ForeignExchange # FX rates, forwards, swaps, and reference sources  
│  
├─ FIBO_IND_Indicators # financial and market indexes (benchmarks, baskets, performance)  
│ └─ Indicators # index methodologies, governance, series, and performance metrics  
│  
├─ FIBO_IND_InterestRates # interest rate benchmarks and curves  
│ ├─ CommonInterestRates # conventions, calendars, compounding, and day count rules  
│ └─ InterestRates # IBORs, RFRs, term rates, fixings, and yield curves  
│  
└─ FIBO_IND_MarketIndices # basket and equity market indices  
├─ BasketIndices # basket index families and methodologies  
└─ EquityIndexExampleIndividuals # canonical examples (S&P 500, MSCI, FTSE, Nikkei, etc.)  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_*` — foundational concepts for Parties, Organizations, Dates, and CurrencyAmount  
- `FIBO_FBC_*` — Financial Business and Commerce (Markets, BusinessCenters, Registries)  
- `FIBO_FND_Utilities` — Analytics and AnnotationVocabulary packages  
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `EconomicIndicators` ↔ `NorthAmericaEconomicIndicators` (regional specializations)  
- `ForeignExchange` ↔ `InterestRates` (FX and rate benchmark conventions)  
- `Indicators` ↔ `MarketIndices` (shared index and basket model)  
- `Indicators` ↔ `EconomicIndicators` (shared Indicator and Frequency definitions)

**Downstream (consumers):**
- `FIBO_SEC_*` (Securities domain – benchmarks and reference rates)  
- `FIBO_FBC_*` (Financial Institutions and Markets)  
- `FIBO_BP_*` (Business Processes for reporting and analytics)

---

## Design Principles
* **Feature-based modeling:** relationships between indicators, series, and observations are expressed through features rather than associations.  
* **Processor vs. processed:**  
  - *Parts* represent publishers, administrators, and organizations (actors).  
  - *Items* represent indexes, indicators, time series, and observations (data).  
* **Inheritance without duplication:** attributes already defined in superclasses are not redeclared in specializations.  
* **Standard alignment:** models align with ISO, IMF SDDS, BIS, and IOSCO principles for benchmarks and indicators.  
* **Temporal traceability:** all indicators and indices include release, revision, and observation timing to support vintage analysis.

---

## Coding Conventions
* **Packages:** `FIBO_IND_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — processors, publishers, or administrators  
  - `item def` — indicators, indexes, observations, and series  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** all elements include `doc/* … */` aligned with FIBO and statistical metadata standards  
* **Imports:** every dependency is explicitly declared (`private import` or `public import`)

---

## Versioning & Configuration Policy
* Each subpackage is an independent **Configuration Item (CI)** with its own baseline.  
* Updates follow the standard **FIBO SysMLv2 configuration management plan**, maintaining traceability across releases.  
* Localized indicators (e.g., North America) and generic indicator frameworks can evolve separately while remaining interoperable.

---

## Purpose
The **FIBO Indices and Indicators (IND)** CI family provides the reference framework for all quantitative and benchmark measures within the FIBO ontology.  
It bridges **macroeconomic**, **financial market**, and **benchmark rate** data to support analytics, risk management, and policy modeling.

Through SysML v2, the IND domain ensures:
- Consistent representation of benchmark and indicator metadata,  
- Integration of economic, financial, and rate series, and  
- Structural traceability across data providers, jurisdictions, and time periods.

---

### References
* [EDMC FIBO Indices and Indicators Specification](https://spec.edmcouncil.org/fibo/)  
* [IMF SDDS / DQAF Statistical Standards](https://dsbb.imf.org/)  
* [IOSCO Principles for Financial Benchmarks](https://www.iosco.org/)  
* [BIS Reference Rate Definitions](https://www.bis.org/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
