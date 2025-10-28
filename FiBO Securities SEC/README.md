# Securities (FIBO_SEC)

## Overview
The **FIBO_SEC (Securities)** domain defines the structural, contractual, and classification aspects of financial securities — including **debt**, **equity**, **funds**, and **pooled instruments**.  
It serves as the central linkage between **Financial Instruments (FBC)** and **Market Data (MD)** domains, modeling how securities are **identified, issued, classified, listed, and restricted** across jurisdictions.

This repository provides the **SysML v2 implementation** of the FIBO Securities domain as a family of **Configuration Items (CIs)**.  
Each CI captures a specific aspect of securities modeling, applying consistent SysMLv2 feature-based principles and leveraging common FIBO foundational elements.

---

## Scope & Objectives
* Provide a unified **data architecture for all types of securities**, both exchange-traded and privately placed.  
* Define **identification, classification, issuance, and listing structures** applicable to all financial instruments.  
* Represent **jurisdictional restrictions** and **regulatory regimes** governing securities offers and transfers.  
* Integrate seamlessly with **FIBO_FBC (Financial Instruments, Debt & Equities)** and **FIBO_IND (Market Data, Benchmarks)**.  
* Support downstream modeling of **corporate actions**, **securitization**, **funds**, and **derivatives**.

---

## Package Structure
FIBO_SEC  
│  
├─ FIBO_SEC_Debt # fixed-income and structured debt instruments  
│ ├─ DebtInstruments # core debt security abstractions and option terms  
│ ├─ Bonds # sovereign, corporate, and subordinated bonds  
│ ├─ TradedShortTermDebt # commercial paper, CDs, and short-term notes  
│ ├─ AssetBackedSecurities # consumer and equipment-backed securities  
│ ├─ MortgageBackedSecurities # agency and private-label MBS structures  
│ ├─ PoolBackedSecurities # pools, tranches, waterfalls, and credit enhancement  
│ ├─ CollateralizedDebtObligations # CLOs, CBOs, and cash CDOs  
│ ├─ SyntheticCDOs # CDS-based synthetic structured products  
│ ├─ DistributedLoans # syndicated and participations  
│ └─ ExerciseConventions # day count, reset, and yield conventions  
│  
├─ FIBO_SEC_Equities # ownership-based instruments and depositary receipts  
│ ├─ EquityInstruments # common, preferred, warrants, and actions  
│ ├─ DepositaryReceipts # ADRs, GDRs, and sponsored/unsponsored programs  
│ ├─ EquityCFIClassificationIndividuals # ISO 10962 classification examples  
│ └─ EquitiesExampleIndividuals # illustrative instrument examples  
│  
├─ FIBO_SEC_Funds # collective investment vehicle securities  
│ ├─ CollectiveInvestmentVehicles # legal, operational, and governance structures  
│ └─ Funds # fund shares, units, dealing, and distributions  
│  
└─ FIBO_SEC_Securities # generic security abstractions and metadata  
├─ SecuritiesCore # base security definition and lifecycle status  
├─ SecuritiesIdentification # identifiers (ISIN, CUSIP, FIGI, ticker)  
├─ SecuritiesIdentificationIndividuals # example identification instances  
├─ SecuritiesClassification # asset classes, CFI codes, and exposures  
├─ SecuritiesIssuance # offerings, tranches, and documentation  
├─ SecuritiesListings # exchange listings and statuses  
├─ SecuritiesRestrictions # global restriction framework  
├─ SecurityAssets # underlying, collateral, and pool links  
├─ Pools # collateral and loan pools  
├─ Baskets # baskets and weighted compositions  
├─ ParametricSchedules # step-up, call, and parametric schedules  
├─ EUSecuritiesRestrictions # EU Prospectus, MiFID, SFDR-specific rules  
└─ USSecuritiesRestrictions # U.S. Reg D, Reg S, Rule 144, 144A, and others  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_*` — foundational ontologies for Law, Parties, Organizations, Dates, and CurrencyAmount  
- `FIBO_FBC_*` — Financial Business and Commerce (Debt, Equities, FinancialInstruments, Markets)  
- `FIBO_IND_*` — Indices & Indicators (benchmarks, rates, and indicators)  
- `FIBO_FND_Utilities` — Analytics and AnnotationVocabulary (for documentation and datasets)  
- `ScalarValues::*`, `Time::*` — SysML standard libraries

**Internal CI cross-links:**
- `SecuritiesCore` ↔ `Debt`, `Equities`, `Funds` (common abstraction)  
- `SecuritiesIdentification` ↔ `Classification` ↔ `Issuance` (instrument metadata flow)  
- `Listings` ↔ `Restrictions` (venue- and jurisdiction-specific distribution rules)  
- `EU/US Restrictions` ↔ `Restrictions` (regional extensions)  
- `SecurityAssets` ↔ `Pools` ↔ `Baskets` (structural and collateral linkage)

**Downstream (consumers):**
- `FIBO_CAE_*` (Corporate Actions and Events)  
- `FIBO_MD_*` (Market Data and temporal analytics)  
- `FIBO_BP_*` (Business Processes — issuance, reporting, and servicing)

---

## Design Principles
* **Feature-based modeling:** all relationships are expressed as SysML features (attributes) rather than associations.  
* **Processor vs. processed:**  
  - *Parts* represent active entities (issuers, agents, venues).  
  - *Items* represent processed entities (securities, offerings, listings).  
* **Inheritance without duplication:** shared attributes are defined once in `SecuritiesCore` and specialized in downstream packages.  
* **Jurisdictional modularity:** separate EU and U.S. restriction packages allow regulatory frameworks to evolve independently.  
* **Standards alignment:**  
  - ISO 10962 (CFI) for classification  
  - ISO 6166 (ISIN) and 10383 (MIC) for identification and venues  
  - SEC, ESMA, MiFID II, and Prospectus Regulation for restrictions  
* **Interoperability:** designed to integrate with Debt, Equities, Funds, and Derivatives models across FIBO.

---

## Coding Conventions
* **Packages:** `FIBO_SEC_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — processors (issuers, custodians, depositaries, agents)  
  - `item def` — processed securities, instruments, and records  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** `doc/* … */` aligned with EDM Council FIBO and regulatory standards  
* **Imports:** explicit `private` or `public` statements only — no implicit dependencies  

---

## Versioning & Configuration Policy
* Each subpackage is a self-contained **Configuration Item (CI)** under the FIBO_SEC domain.  
* Updates follow the **FIBO SysMLv2 Configuration Management Plan**.  
* Regional regulation packages (e.g., EU/US Restrictions) are versioned independently.  
* CI interoperability is maintained through shared public imports from foundational domains.

---

## Purpose
The **FIBO Securities (SEC)** domain provides the foundation for all **tradable financial instruments** within the FIBO ontology.  
It standardizes the representation of security metadata — identity, classification, issuance, restrictions, and structure — enabling consistent integration across:

- Capital market instruments (Debt, Equity, Funds)  
- Structured and pooled assets (ABS, MBS, CDOs)  
- Listing and restriction regimes (EU and U.S.)  
- Corporate actions, valuation, and regulatory reporting frameworks  

This SysMLv2 implementation supports **data lineage, regulatory traceability, and semantic interoperability** across the financial system.

---

### References
* [EDMC FIBO Securities Specification](https://spec.edmcouncil.org/fibo/)  
* [ISO 6166 (ISIN)](https://www.iso.org/standard/81537.html)  
* [ISO 10962 (CFI)](https://www.iso.org/standard/74838.html)  
* [MiFID II, Prospectus Regulation, SFDR, and UCITS Directives](https://finance.ec.europa.eu/)  
* [U.S. SEC Securities Act of 1933, Exchange Act of 1934, and Rule 144/144A](https://www.sec.gov/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
