# Financial Business and Commerce (FIBO_FBC)

## Overview
The **FIBO_FBC (Financial Business and Commerce)** domain defines the foundational concepts and structures that support **financial institutions**, **markets**, **instruments**, and **commercial relationships** across the financial system.  
It builds on **FIBO_FND (Foundations)** to model the **entities**, **registries**, **financial products**, **services**, and **infrastructures** that enable real-world financial operations and transactions.

This repository provides a **SysML v2 implementation** of the FIBO Financial Business and Commerce domain, structured as a family of **Configuration Items (CIs)**.  
Each CI represents a cohesive aspect of the financial ecosystem, consistently applying the **processor vs. processed** principle established across all FIBO SysMLv2 domains.

---

## Scope & Objectives
* Represent the **core financial entities** — institutions, markets, registries, and authorities — that support global commerce.  
* Model **debt and equity instruments**, **financial instruments**, and **related contractual constructs**.  
* Capture the **operational and functional entities** that conduct financial business (banks, brokers, regulators, registries).  
* Define **financial products and services** offered to clients, and their underlying instruments, accounts, and servicing models.  
* Provide a semantic framework for **pricing, settlement, and market reference data**.  
* Serve as a **bridge domain** linking Foundations (FND) with Securities (SEC), Business Processes (BP), and Corporate Actions and Events (CAE).

---

## Package Structure
FIBO_FBC  
│  
├─ FIBO_FBC_DebtAndEquities # debt, loans, credit events, ratings, guaranties  
│ ├─ Debt # core debt instruments and terms  
│ ├─ CreditEvents # credit events (default, restructuring, bankruptcy)  
│ ├─ CreditRatings # agencies, rating scales, and credit opinions  
│ └─ Guaranty # guarantees, letters of credit, and credit enhancements  
│  
├─ FIBO_FBC_FinancialInstruments # instruments, pricing, and settlement  
│ ├─ FinancialInstruments # general financial instrument abstraction  
│ ├─ InstrumentPricing # price quotes, market data, valuations  
│ └─ Settlement # post-trade settlement, accounts, and obligations  
│  
├─ FIBO_FBC_FunctionalEntities # institutions, markets, authorities, registries  
│ ├─ FinancialServicesEntities # banks, brokers, asset managers, custodians, etc.  
│ ├─ Markets # exchanges, trading venues, post-trade infrastructures  
│ ├─ BusinessRegistries # registries of legal entities  
│ ├─ RegistrationAuthorities # identifier authorities and assignment schemes  
│ ├─ InternationalRegistriesAndAuthorities # global and ISO code-maintaining authorities  
│ ├─ RegulatoryAgencies # regulators by jurisdiction and function  
│ ├─ BusinessCenters # business day centers and calendars  
│ └─ BusinessCentersIndividuals # example business center codes (e.g., GBLO, USNY)  
│  
└─ FIBO_FBC_ProductsAndServices # financial products, services, clients, and accounts  
├─ FinancialProductsAndServices # product definitions, services, eligibility, fees  
└─ ClientsAndAccounts # client entities, accounts, balances, servicing  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_*` — core foundational models (Parties, Organizations, Law, CurrencyAmount, DatesAndTimes, Utilities)  
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `DebtAndEquities` ↔ `FinancialInstruments` (debt as tradable instrument subclass)  
- `FunctionalEntities` ↔ `FinancialInstruments` (markets, registries, regulators)  
- `ProductsAndServices` ↔ `FunctionalEntities` (providers, banks, custodians)  
- `ProductsAndServices` ↔ `FinancialInstruments` (linked products and investment accounts)

**Downstream (consumers):**
- `FIBO_SEC_*` (Securities domain — issuance, trading, and holdings)  
- `FIBO_BP_*` (Business Processes domain — processes and issuance workflows)  
- `FIBO_CAE_*` (Corporate Actions domain — event management on issued instruments)

---

## Design Principles
* **Feature-based modeling:** all relationships are expressed as SysML features (attributes) rather than abstract associations.  
* **Processor vs. processed:**  
  - *Parts* represent entities that act or perform functions (e.g., banks, brokers, markets, regulators).  
  - *Items* represent instruments, products, documents, and contracts that are acted upon.  
* **Semantic layering:** FBC acts as the **operational and institutional layer** bridging FND with domain-specific extensions like SEC and CAE.  
* **Standard alignment:** concepts align with ISO standards (ISO 10962 CFI, ISO 10383 MIC, ISO 17442 LEI, ISO 20022 message structures).  
* **Traceability:** every product, instrument, and market entity can be traced to its issuer, registry, regulator, and jurisdiction.

---

## Coding Conventions
* **Packages:** `FIBO_FBC_<Subpackage>` (PascalCase)
* **Elements:**  
  - `part def` — processors or active entities (banks, markets, regulators)  
  - `item def` — financial instruments, contracts, records, data, or products  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** all elements include `doc/* … */` with SKOS-aligned definitions  
* **Imports:** all cross-package references declared explicitly as `private` or `public`

---

## Versioning & Configuration Policy
* Each subpackage is a **Configuration Item (CI)** with its own baseline.  
* Updates follow the same **incremental configuration management plan** used for other FIBO domains.  
* CIs are **mutually interoperable**, allowing independent evolution and reuse.

---

## Purpose
The **FIBO Financial Business and Commerce (FBC)** CI family provides the structural, institutional, and transactional framework for all financial activities modeled in FIBO.  
It defines how markets operate, how financial instruments exist and are valued, how institutions interact, and how clients engage with products and services.

Through its SysML v2 implementation, FBC enables:
- consistent modeling of financial infrastructures and services,  
- integration of market data and regulatory concepts,  
- clear traceability from financial products to institutions and authorities, and  
- interoperability with FIBO’s Securities, Corporate Actions, and Business Process domains.

---

### References
* [EDMC FIBO Financial Business and Commerce Specification](https://spec.edmcouncil.org/fibo/)  
* [ISO 17442 – Legal Entity Identifier (LEI)](https://www.gleif.org/)  
* [ISO 10962 – Classification of Financial Instruments (CFI)](https://www.iso.org/standard/74838.html)  
* [ISO 10383 – Market Identifier Codes (MIC)](https://www.iso.org/standard/51081.html)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)