# Corporate Actions and Events (FIBO_CAE)

## Overview
The **FIBO_CAE (Corporate Actions and Events)** domain models all events and issuer-driven actions that impact securities, their holders, and associated entitlements.  
It captures **corporate action events**, **issuer communications**, **entitlement calculations**, and **holder instructions**, aligned with global market standards such as **ISO 15022**, **ISO 20022**, and **GLEIF** corporate action datasets.

This domain complements the **FIBO_SEC (Securities)** and **FIBO_BP (Business Processes)** domains by defining the structures and lifecycle for corporate events that modify security characteristics, ownership positions, or cash flows.

The repository provides the **SysML v2 implementation** of the FIBO Corporate Actions and Events domain as a **Configuration Item (CI)** family.  
All entities follow the same FIBO-wide modeling conventions, distinguishing between **processors** (actors, organizations) and **processed items** (events, records, transactions, documents).

---

## Scope & Objectives
* Define a **formal ontology of corporate actions** applicable to debt, equity, and structured securities.  
* Represent **event types**, **entitlements**, **elections**, and **processing statuses** consistent with ISO 15022/20022.  
* Model **issuer announcements**, **holder instructions**, and **proxy voting events**.  
* Capture both **generic event structures** and **canonical examples** aligned with **GLEIF** and **ISO** corporate action datasets.  
* Support integration with **Securities Transactions**, **Issuance**, and **Ownership & Control** models in FIBO.

---

## Package Structure
FIBO_CAE  
│  
├─ FIBO_CAE_CorporateActionsAndEvents # corporate action event definitions  
│ ├─ CorporateActions # generic corporate action event model  
│ ├─ SecurityRelatedCorporateActions # equity and debt action specializations  
│ ├─ GLEIF_CorporateActionIndividuals # GLEIF example individuals and mappings  
│ └─ ISO15022_CorporateActionIndividuals # ISO 15022 canonical event examples  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_Organizations`, `FIBO_FND_Parties` — issuers, holders, and agents  
- `FIBO_FND_CurrencyAmount` — entitlements, payouts  
- `FIBO_FND_ProductsAndServices` — affected securities  
- `FIBO_FND_Contracts` and `FIBO_FND_AgreementsContracts` — governing terms  
- `FIBO_FND_DatesAndTimes` — event dates, schedules  
- `FIBO_FND_TransactionsExt` — settlement and cash flow references  
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `CorporateActions` ↔ `SecurityRelatedCorporateActions` (general vs. specific events)  
- `CorporateActions` ↔ `GLEIF_CorporateActionIndividuals` (data alignment examples)  
- `CorporateActions` ↔ `ISO15022_CorporateActionIndividuals` (standardized event codes)

**Downstream (consumers):**
- `FIBO_SEC_*` (Securities holdings, positions, and lifecycle)  
- `FIBO_BP_*` (Corporate action processing workflows)  
- `FIBO_FBC_*` (financial business and reporting contexts)

---

## Design Principles
* **Feature-based modeling:** events and relationships are expressed through attributes (features) rather than abstract associations.  
* **Processor vs. processed:**  
  - *Parts* = issuers, agents, and parties who initiate or process events.  
  - *Items* = corporate actions, entitlements, instructions, and documents affected by these parts.  
* **Event hierarchy:**  
  - `CorporateActionEvent` defines a universal base class for all events.  
  - Specialized events (e.g., `DividendEvent`, `RightsIssueEvent`, `MergerEvent`) capture market-standard semantics.  
* **Standards alignment:** event codes and semantics align with **ISO 15022**, **ISO 20022**, and **GLEIF** data structures.  
* **Traceability:** each event may reference issuer communications, governing contracts, and settlement transactions.

---

## Coding Conventions
* **Packages:** `FIBO_CAE_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — active agents (issuers, trustees, agents)  
  - `item def` — events, entitlements, documents, and records  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** every definition includes a `doc/* … */` annotation aligned with FIBO or ISO terminology  
* **Imports:** all dependencies explicitly declared as `private` or `public`

---

## Versioning & Configuration Policy
* Each subpackage is a **Configuration Item (CI)** under the FIBO_CAE family.  
* Updates to event structures or enumerations are version-controlled and traceable to FIBO CAE ontology sources.  
* ISO and GLEIF example individuals are maintained separately to prevent interference with generic event definitions.

---

## Purpose
The **FIBO Corporate Actions and Events** domain provides a unified representation of all issuer-driven events that modify securities or investor holdings.  
It connects the **legal**, **organizational**, and **transactional** aspects of these events to ensure consistent handling of:
- dividend and income distributions,  
- capital structure changes (splits, mergers, spin-offs),  
- reorganizations and redemptions,  
- proxy voting and meeting events, and  
- post-issuance event tracking across markets and jurisdictions.

Through SysML v2, these models enable **clear lineage**, **semantic interoperability**, and **regulatory traceability** across financial systems.

---

### References
* [EDMC FIBO Corporate Actions and Events Specification](https://spec.edmcouncil.org/fibo/)  
* [ISO 15022 / ISO 20022 Corporate Actions Messaging Standards](https://www.iso20022.org/)  
* [GLEIF Corporate Action Data](https://www.gleif.org/en/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
