# Business Processes (FIBO_BP)

## Overview
The **FIBO_BP (Business Processes)** domain defines the process-oriented foundation of financial operations — how **financial activities**, **transactions**, and **issuances** are organized, executed, governed, and documented.  
It complements the structural abstractions of **FIBO_FND** by describing **how** things get done: from the orchestration of business processes to the mechanics of issuing financial securities.

This repository provides a **SysML v2 implementation** of the FIBO Business Processes domain as a family of **Configuration Items (CIs)**.  
Each package represents a well-defined scope of process semantics, aligned with the EDM Council’s FIBO specifications.

---

## Scope & Objectives
* Define **business process abstractions** relevant across financial services, including actors, procedures, activities, and controls.  
* Represent **financial issuance processes**, including equity, debt, securitization, and municipal offerings.  
* Model **roles, responsibilities, and evidence** supporting governance and compliance.  
* Capture **orchestration**, **dependencies**, and **documentation** associated with process execution.  
* Integrate tightly with the foundational FIBO domains such as **Parties**, **Organizations**, **Contracts**, and **Transactions**.

---

## Package Structure
FIBO_BP  
│  
├─ FIBO_BP_Processes # generic financial business processes, roles, controls  
│ └─ FinancialContextAndProcess # process lifecycle, orchestration, governance, evidence  
│  
└─ FIBO_BP_SecuritiesIssuance # processes and documents related to securities issuance  
├─ IssuanceProcess # overarching securities issuance workflow  
├─ IssuanceDocuments # prospectus, term sheets, indentures, pooling agreements  
├─ DebtIssuance # bonds, notes, tranches, and debt terms  
├─ EquitiesIPOIssuance # IPOs, follow-ons, and syndication records  
├─ MBSIssuance # mortgage-backed securities structures and pooling  
├─ AgencyMBSIssuance # agency-sponsored MBS issuance (FNMA, FHLMC, GNMA)  
├─ PrivateLabelMBSIssuance # non-agency securitizations and credit enhancement  
└─ MuniIssuance # municipal and public debt offerings  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_Parties`, `FIBO_FND_Organizations`
- `FIBO_FND_AgreementsContracts`, `FIBO_FND_TransactionsExt`
- `FIBO_FND_CurrencyAmount`, `FIBO_FND_DatesAndTimes`
- `FIBO_FND_ProductsAndServices`, `FIBO_FND_Documents`
- `FIBO_FND_Utilities` (for annotations and analytics)
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `Processes` ↔ `SecuritiesIssuance` (common actors, governance, and document references)
- `IssuanceProcess` ↔ `IssuanceDocuments` (document flow and disclosure)
- `DebtIssuance` ↔ `EquitiesIPOIssuance` ↔ `MBSIssuance` (different security types)
- `AgencyMBSIssuance` ↔ `PrivateLabelMBSIssuance` (agency vs. private label structures)
- `MuniIssuance` ↔ `IssuanceDocuments` (official statements and disclosure)

**Downstream (consumers):**
- `FIBO_SEC_*`, `FIBO_BE_*`, `FIBO_FBC_*` — issuance, trading, and regulatory domains.

---

## Design Principles
* **Process-oriented abstraction:** each CI models not the entity itself, but the *process* by which it is created, executed, or governed.  
* **Processor vs. processed:**  
  - *Parts* represent active agents (process owners, performers, issuers, underwriters).  
  - *Items* represent managed artifacts (documents, processes, securities, evidence).  
* **Feature-based modeling:** dependencies, roles, and evidence are modeled as features rather than loose associations.  
* **Separation of concerns:**  
  - `Processes` handles generic workflows and governance.  
  - `SecuritiesIssuance` handles issuance-specific financial processes.  
* **Alignment:** naming and definitions are consistent with EDM Council FIBO and industry terminology (ISDA, ICMA, SEC, FINRA, etc.).

---

## Coding Conventions
* **Packages:** `FIBO_BP_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — processors or active participants  
  - `item def` — processes, records, documents, or other processed entities  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** all elements contain `doc/* … */` extracted or aligned with SKOS definitions  
* **Imports:** all dependencies are explicitly marked as `private` or `public`

---

## Versioning & Configuration Policy
* Each package is a self-contained **Configuration Item (CI)** with an independent baseline.  
* Changes to CIs follow the same configuration management plan as FIBO Foundations.  
* FIBO_BP builds directly on **FIBO_FND** packages — no downstream dependency loops are introduced.

---

## Purpose
The **FIBO Business Processes CI family** provides the process semantics and issuance lifecycle modeling required to link **organizational structures** and **financial instruments**.  
It enables consistent representation of:
- business process governance,  
- regulatory disclosure and documentation,  
- securities creation and issuance, and  
- end-to-end traceability from process steps to resulting financial products.

By integrating these concepts into the broader **FIBO SysMLv2 architecture**, the BP domain ensures that all business activities are not only *modeled structurally* but also *operationally understood*.

---

### References
* [EDMC FIBO Business Processes Specification](https://spec.edmcouncil.org/fibo/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)  
* [ISDA, ICMA, SEC & FINRA regulatory frameworks](https://www.sec.gov/)
