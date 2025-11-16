# Loans (FIBO_LOAN)

## Overview
The **FIBO_LOAN (Loans)** domain models the full lifecycle of lending — from **origination** and **underwriting** to **disbursement**, **servicing**, **default**, and **regulatory reporting**.  
It provides a comprehensive framework for all types of loan products, including **consumer**, **commercial**, **real estate**, **green**, and **specialized finance** instruments.

This repository provides the **SysML v2 implementation** of the FIBO Loans domain as a family of **Configuration Items (CIs)**.  
Each CI is feature-based and aligned with FIBO’s foundational (FND) and financial (FBC) structures, applying the modeling principle that:
- **Parts** represent processors or actors (borrowers, lenders, agents, servicers),  
- **Items** represent processed artifacts (loans, applications, payments, contracts, events).

---

## Scope & Objectives
* Define the **contractual, economic, and operational structure** of loan instruments.  
* Capture **origination**, **credit underwriting**, **disbursement**, and **repayment** processes.  
* Model **regulatory classifications** (Basel, IFRS 9, HMDA) and **non-performing loan tracking**.  
* Represent both **standardized loan products** and **specialized segments** (student, green, marine, commercial, construction).  
* Integrate seamlessly with **FIBO_FND**, **FIBO_FBC**, and **FIBO_SEC** domains for collateral, ownership, and market interactions.

---

## Package Structure

FIBO_LOAN  
│  
├─ FIBO_LOAN_LoansGeneral # foundational model for loan terms, contracts, and events  
│ ├─ Loans # general-purpose loan definition (interest, repayment, collateral)  
│ ├─ LoanApplications # origination, credit scoring, underwriting, decisioning  
│ ├─ LoanEvents # lifecycle and payment events  
│ └─ LoansRegulatory # regulatory classifications (Basel, IFRS9, NPL, supervisory reporting)  
│  
├─ FIBO_LOAN_LoanSpecific # specialized loan products and product catalogs  
│ ├─ LoanProducts # product templates, pricing, and eligibility criteria  
│ ├─ ConsumerLoans # retail installment, auto, mortgage, line of credit  
│ ├─ CardAccounts # revolving credit accounts and card transactions  
│ ├─ CommercialLoans # business lending, facilities, and secured loans  
│ ├─ StudentLoans # education financing and repayment plan variants  
│ ├─ GreenLoans # green and sustainability-linked loans  
│ └─ MarineFinance # vessel-backed loans and maritime collateral  
│  
└─ FIBO_LOAN_RealEstateLoans # mortgage and construction lending structures  
├─ Mortgages # property-secured loan models (FHA/VA, ARMs, servicing)  
├─ MortgageOrigination # underwriting, appraisal, title, and disclosures  
├─ HMDACoveredMortgages # HMDA compliance and reporting model  
└─ ConstructionLoans # construction and construction-to-permanent financing  

## Dependencies
**Upstream (imports):**
- `FIBO_FND_*` — foundational packages for Parties, Organizations, Law, Contracts, and CurrencyAmount  
- `FIBO_FBC_*` — Financial Business and Commerce (FunctionalEntities, Markets, BusinessCenters, ProductsAndServices)  
- `FIBO_FND_TransactionsExt` — cash flow, transaction, and accounting structures  
- `FIBO_FND_Places` — RealProperty and Locations  
- `ScalarValues::*`, `Time::*` (SysML standard libraries)

**Internal CI cross-links:**
- `LoansGeneral` ↔ `LoanSpecific` (general vs. product-specific definitions)  
- `LoansGeneral` ↔ `RealEstateLoans` (mortgages extend general loan structures)  
- `LoanApplications` ↔ `LoanProducts` (eligibility and origination mapping)  
- `LoansRegulatory` ↔ `Mortgages` ↔ `ConstructionLoans` (Basel/IFRS/HMDA compliance)

**Downstream (consumers):**
- `FIBO_BP_*` (Business Processes – loan origination and servicing processes)  
- `FIBO_FBC_*` (Financial institutions – banks, credit agencies, and regulators)  
- `FIBO_SEC_*` (Securities – securitization of mortgage or loan assets)

---

## Design Principles
* **Feature-based modeling:** use of SysML attributes for contractual and economic relationships.  
* **Processor vs. processed:**  
  - *Parts* act as processors (borrowers, lenders, underwriters, regulators).  
  - *Items* are the processed entities (loans, contracts, applications, events).  
* **Inheritance without redundancy:** attributes already defined in base loan or contract types are not redefined in specialized subtypes.  
* **Alignment with standards:** models follow terminology and structure from Basel III, IFRS 9, HMDA, LMA, and ICMA loan standards.  
* **Integration-ready:** direct interoperability with collateral, payments, cash flow, and property models from other FIBO domains.

---

## Coding Conventions
* **Packages:** `FIBO_LOAN_<Subpackage>` (PascalCase)  
* **Elements:**  
  - `part def` — actors or processors (borrowers, lenders, servicers)  
  - `item def` — processed entities (loans, applications, payments, reports)  
* **Features:** lowerCamelCase  
* **Enumerations:** `enum def <Name>` with PascalCase literals  
* **Documentation:** `doc/* … */` used for every element with SKOS-aligned semantics  
* **Imports:** explicit `private` or `public` import statements across all CIs

---

## Versioning & Configuration Policy
* Each subpackage is maintained as an independent **Configuration Item (CI)** with its own baseline.  
* Updates follow the same **FIBO SysMLv2 configuration management plan** used across all domains.  
* Cross-domain integration is maintained through stable imports rather than internal duplication.

---

## Purpose
The **FIBO Loans CI family** provides a unified ontology for modeling the structure, terms, and lifecycle of loans across consumer, commercial, and real estate contexts.  
It supports:
- consistent representation of credit exposures and agreements,  
- detailed modeling of origination and regulatory reporting, and  
- interoperability with securities, business processes, and financial analytics.

By implementing these models in **SysML v2**, this domain provides a modular and interoperable representation of credit products within the broader **FIBO financial architecture**.

---

### References
* [EDMC FIBO Loans Specification](https://spec.edmcouncil.org/fibo/)  
* [Basel Committee on Banking Supervision – Credit Risk Framework](https://www.bis.org/basel_framework/)  
* [IFRS 9 Financial Instruments](https://www.ifrs.org/issued-standards/list-of-standards/ifrs-9-financial-instruments/)  
* [U.S. CFPB HMDA Rule](https://www.consumerfinance.gov/data-research/hmda/)  
* [ICMA and LMA Green & Sustainability-Linked Loan Principles](https://www.icmagroup.org/)  
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
