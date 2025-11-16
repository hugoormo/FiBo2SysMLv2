# Foundations (FIBO_FND)

## Overview
The **FIBO_FND (Foundations)** domain provides the shared abstractions that all other FIBO domains depend on.  
It formalizes general-purpose concepts such as **people**, **organizations**, **parties**, **places**, **agreements**, **transactions**, **ownership**, **dates and times**, and **utilities** for metadata and analytics.

This repository represents the **SysML v2 implementation** of FIBO Foundations as a configuration-controlled **Configuration Item (CI)** family.  
All packages are feature-based and follow the **processor vs. processed** principle:
- **Parts** represent actors or processors (people, organizations, systems, facilities).  
- **Items** represent things that are acted upon or exchanged (documents, contracts, transactions, records).

---

## Scope & Objectives
* Provide a **domain-neutral base** for identifiers, classifiers, parties, roles, organizations, locations, and dates.  
* Capture the **legal and contractual infrastructure** common across FIBO domains.  
* Model **ownership, control, and influence** relationships between entities.  
* Represent **transactions, products, services, and schedules** in a consistent way.  
* Supply **utilities** for analytics, annotation, and model metadata.  
* Maintain strict **independence** from downstream domains to prevent circular dependencies.

---

## Package Structure
FIBO_FND  
│  
├─ FIBO_FND_Accounting # amounts, currencies, cash flows, equity  
├─ FIBO_FND_AgreementsContracts # agreements, commitments, contracts, terms  
├─ FIBO_FND_GoalsAndObjectives # goals, objectives, strategies, programs  
├─ FIBO_FND_Law # legal system, jurisdiction, capacity, rules  
├─ FIBO_FND_OwnershipAndControl # ownership interests, control, influence  
├─ FIBO_FND_Organizations # organizations (formal/informal, legal forms)  
├─ FIBO_FND_Parties # parties, roles, assignments, relationships  
├─ FIBO_FND_Places # addresses, locations, facilities, property  
├─ FIBO_FND_ProductsAndServices # products, services, offerings, payments  
├─ FIBO_FND_TransactionsExt # market, real estate, and securities transactions  
├─ FIBO_FND_DatesAndTimes # business dates, financial dates, occurrences  
├─ FIBO_FND_Utilities # analytics, annotations, and utility structures  
└─ FIBO_FND_Constraints # shared constraint definitions (imported by all)  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_Constraints`
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `Law ↔ AgreementsContracts` (jurisdiction, governing law)
- `Organizations ↔ Parties` (organizations as parties)
- `OwnershipAndControl ↔ Organizations/Parties`
- `Accounting ↔ DatesAndTimes ↔ Utilities`
- `Places ↔ RealProperty ↔ OwnershipAndControl`
- `ProductsAndServices ↔ Accounting/Parties/AgreementsContracts`
- `TransactionsExt ↔ ProductsAndServices/AgreementsContracts/Accounting`

**Downstream (consumers):**
- `FIBO_BE_*`, `FIBO_FBC_*`, `FIBO_IND_*`, `FIBO_SEC_*`

---

## Design Principles
* **Feature-based modeling:** use attributes rather than associations where relationships are unidirectional and well-defined.  
* **Processor vs. processed:**  
  - *Parts* act, own, decide, or process.  
  - *Items* are transacted, exchanged, or recorded.  
* **Explicit imports:** all cross-CI references use qualified imports; redundant local stubs are being phased out.  
* **Minimal core:** each subpackage is independent but interoperable through well-defined imports.  
* **Alignment:** concepts follow the EDM Council FIBO Foundations vocabulary with SysML v2 syntax and structure.

---

## Coding Conventions
* **Packages:** `FIBO_FND_<Subpackage>` (PascalCase)
* **Elements:**  
  - `part def` — processors or actors  
  - `item def` — artifacts, data, or transactions  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with literals in PascalCase  
* **Documentation:** use `doc/* … */` for ontology definitions and SKOS text  
* **Imports:** always marked as `private` or `public` explicitly

---

## Versioning & Configuration Policy
* Each subpackage is a self-contained **Configuration Item (CI)** with its own baseline.  
* CIs evolve incrementally: **minor** for additive features, **major** for breaking refactors.  
* Downstream models should import FND packages rather than replicate their definitions.

---

## Purpose
The **FIBO Foundations CI family** provides the conceptual backbone for all higher-level FIBO domains.  
By implementing the EDM Council’s FIBO FND in **SysML v2**, this project enables consistent, model-based reuse of the primitives underlying **business entities**, **financial contracts**, **market instruments**, and **analytics** across the entire financial ontology landscape.

---

### References
* [EDMC FIBO Foundations Specification](https://spec.edmcouncil.org/fibo/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
