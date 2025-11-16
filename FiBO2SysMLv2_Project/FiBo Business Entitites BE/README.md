# Business Entities (FIBO_BE)

## Overview
The **FIBO_BE (Business Entities)** domain defines the structures, relationships, and legal characteristics of **organizations, enterprises, and legal persons**.  
It models the foundational concepts used to represent **corporations, partnerships, sole proprietors, trusts, and related ownership and control structures**.  
This domain provides the core ontology for understanding how entities are formed, governed, owned, and interact under various **legal and jurisdictional frameworks**.

This repository provides the **SysML v2 implementation** of the FIBO Business Entities domain as a collection of **Configuration Items (CIs)**, each representing a distinct legal or organizational construct.

---

## Scope & Objectives
* Define **legal persons and organizational structures** recognized under law.  
* Represent **corporate governance, ownership, and control relationships**.  
* Capture the life cycle of legal entities — formation, registration, operation, and dissolution.  
* Support **jurisdiction-specific specializations** (e.g., EU/US, limited companies, partnerships, trusts).  
* Integrate seamlessly with **FIBO_FND (Foundations)**, **FIBO_FBC (Financial Business & Commerce)**, and **FIBO_SEC (Securities)** domains for enterprise-level traceability.

---

## Package Structure
FIBO_BE  
│  
├─ FIBO_BE_Corporations # corporate legal entities, boards, directors, officers  
│ └─ Corporations # corporation definition, registration, share registers  
│  
├─ FIBO_BE_FunctionalEntities # functional, operational, and publishing organizations  
│ ├─ FunctionalEntities # general-purpose functional roles and units  
│ └─ Publishers # entities producing reports, datasets, or publications  
│  
├─ FIBO_BE_GovernmentEntities # governmental and public sector organizations  
│ └─ GovernmentEntities # ministries, agencies, oversight bodies, and officials  
│  
├─ FIBO_BE_LegalEntities # generic legal persons and business organizations  
│ ├─ LegalPersons # legal person abstraction (natural, juridical, etc.)  
│ ├─ LEIEntities # Legal Entity Identifiers and parent relationships  
│ ├─ CorporateBodies # corporate bodies (company, foundation, association)  
│ └─ FormalBusinessOrganizations # business organizations and governance structures  
│  
├─ FIBO_BE_OwnershipAndControl # ownership, control, and governance relationships  
│ ├─ Executives # executive roles, directors, and committees  
│ ├─ OwnershipParties # owner, beneficial owner, and nominee roles  
│ ├─ ControlParties # controller roles and mechanisms  
│ ├─ CorporateOwnership # equity and indirect ownership records  
│ └─ CorporateControl # control relationships and parent hierarchies  
│  
├─ FIBO_BE_Partnerships # partnership structures and agreements  
│ └─ Partnerships # partners, capital accounts, allocations, and dissolution  
│  
├─ FIBO_BE_PrivateLimitedCompanies # private limited companies (LLCs, LTDs, close corps)  
│ └─ PrivateLimitedCompanies # officers, shareholders, registers, compliance, filings  
│  
├─ FIBO_BE_SoleProprietors # unincorporated individual business owners  
│ └─ SoleProprietors # sole proprietorships, registration, licensing, and risk  
│  
└─ FIBO_BE_Trusts # trusts and fiduciary arrangements  
└─ Trusts # trustees, settlors, beneficiaries, and trust property  

---

## Dependencies
**Upstream (imports):**
- `FIBO_FND_*` — foundational ontologies for Law, Contracts, Parties, Organizations, Ownership, and Control  
- `FIBO_FBC_*` — Financial Business and Commerce (Markets, Institutions, Registries)  
- `FIBO_FND_Utilities` — AnnotationVocabulary and Analytics for documentation and metadata  
- `ScalarValues::*`, `Time::*` — SysML standard libraries for datatypes and temporal modeling

**Internal CI cross-links:**
- `Corporations` ↔ `OwnershipAndControl` (shareholding, directors, control relationships)  
- `LegalEntities` ↔ `Corporations`, `Partnerships`, `PrivateLimitedCompanies`, and `SoleProprietors` (legal form hierarchy)  
- `GovernmentEntities` ↔ `FunctionalEntities` (operational and jurisdictional functions)  
- `Trusts` ↔ `OwnershipAndControl` (beneficial ownership and fiduciary relationships)

**Downstream (consumers):**
- `FIBO_FBC_*` (Financial Institutions, Markets, Registries)  
- `FIBO_SEC_*` (Securities — issuer, corporate actions, shareholding)  
- `FIBO_BP_*` (Business Processes — entity registration, compliance, and reporting)

---

## Design Principles
* **Feature-based modeling:** All relationships are expressed as attributes or compositions — no associations.  
* **Processor vs. processed:**  
  - *Parts* are active entities (corporations, trustees, government bodies).  
  - *Items* are passive or descriptive entities (documents, registrations, records).  
* **Legal realism:** Reflects real-world legal distinctions among incorporated, unincorporated, and fiduciary entities.  
* **Jurisdictional extensibility:** Each structure can be adapted to country-specific company law or regulatory frameworks.  
* **Governance traceability:** Directors, officers, shareholders, and controllers are linked to relevant laws, filings, and jurisdictions.  
* **Interoperability:** Consistent integration with the FIBO foundational models for Law, Parties, and Organizations.

---

## Coding Conventions
* **Packages:** `FIBO_BE_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — active entities or agents (corporations, trustees, partners, executives)  
  - `item def` — passive entities or artifacts (records, filings, documents)  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** `doc/* … */` aligned with EDM Council FIBO semantics  
* **Imports:** explicit `private` or `public` declarations only; no implicit cross-package dependencies  

---

## Versioning & Configuration Policy
* Each subpackage is an independent **Configuration Item (CI)** with its own baseline.  
* Updates follow the **FIBO SysMLv2 Configuration Management Plan** for traceability and governance.  
* CIs may be maintained and versioned independently (e.g., corporate law updates or jurisdictional changes).  
* Integration across domains (FND, FBC, SEC) is managed through explicit public imports and consistent feature naming.

---

## Purpose
The **FIBO Business Entities (BE)** domain provides the ontological foundation for representing **real-world legal entities** and their relationships.  
It enables interoperability across finance, law, and regulatory systems by defining:

- Core legal forms (corporations, partnerships, trusts, proprietors)  
- Ownership, control, and governance structures  
- Registration, compliance, and reporting processes  
- Jurisdictional and legal context for all entity types  

Through **SysML v2**, this domain offers a modular, transparent, and standards-aligned approach for modeling the entities that make up the financial ecosystem.

---

### References
* [EDMC FIBO Business Entities Specification](https://spec.edmcouncil.org/fibo/)  
* [OECD Beneficial Ownership Standards](https://www.oecd.org/)  
* [FATF Recommendations on Legal Persons and Arrangements](https://www.fatf-gafi.org/)  
* [ISO 17442 – Legal Entity Identifier (LEI)](https://www.iso.org/standard/59771.html)  
* [OECD Corporate Governance Principles](https://www.oecd.org/corporate/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
