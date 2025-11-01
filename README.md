# FiBo2SysMLv2  TL;DR

## FiBo2SysMLv2 — Summary

**Title:** Translating the Financial Industry Business Ontology (FIBO) into a SysML v2 Data Library  
**Version:** November 2025  
**Maintainer:** Hugo Ormo  

---

### Overview
The **FiBo2SysMLv2** project transforms the *Financial Industry Business Ontology (FIBO)* from its original RDF/OWL representation into a **SysML v2 data library** — a structured, configuration-controlled collection of reusable model elements.  
This work demonstrates how semantic ontologies can be expressed in SysML v2 to enable **interoperable, machine-readable, and maintainable system models** for use across financial, legal, and regulatory domains.

---

### Purpose
- Provide a **standardized SysML v2 representation** of FIBO concepts.  
- Support **reuse** of well-defined legal and financial abstractions in systems engineering.  
- Enable **cross-domain interoperability** between ontology-based data standards and model-based engineering (MBSE).  
- Establish a **library** of validated, versioned Configuration Items (CIs) for future automation and data traceability.

---

### Methodology
FiBo2SysMLv2 employs a **modular, configuration-controlled workflow**, structured as follows:

1. **Ontology Source Alignment** — FIBO RDF/OWL ontologies are analyzed and mapped to SysML v2 elements.  
2. **Model Translation** — Classes, properties, and individuals are converted into SysML definitions (`item def`, `part def`, `enum def`) with embedded documentation.  
3. **Dependency Structuring** — Each CI defines explicit imports and public interfaces, ensuring strong modular boundaries.  
4. **Configuration Control** — Every CI is versioned, validated, and baselined under a documented change process.  
5. **Integration and Aggregation** — Domain-level packages (BE, SEC, FND, FBC, etc.) re-export validated submodels into cohesive libraries.  
6. **Validation and Review** — Automated SysML syntax validation is complemented by human semantic review for accuracy and fidelity.

---

### Human–AI Collaboration
The modeling process was performed using **AI-assisted ontology interpretation** and **human oversight**:

- **AI systems** parsed, translated, and structured the RDF ontologies into SysML v2 models.  
- **Human experts** defined the objectives, corrected early translation errors, validated scope, and approved baselines.  

This **human-in-the-loop** workflow combined **machine precision** with **domain judgment**, resulting in a credible and traceable model library.

**Total effort:** ≈ 230 hours (≈ 180 AI + 50 human verification)  

---

### Outcome
The FiBo2SysMLv2 library currently includes over **50 configuration items** across nine major FIBO domains:  
**Foundations (FND)**, **Business Entities (BE)**, **Financial Business & Commerce (FBC)**, **Indices & Indicators (IND)**, **Securities (SEC)**, **Business Processes (BP)**, **Corporate Actions (CAE)**, **Derivatives (DER)**, and **Market Data (MD)**.  

Each CI forms a reusable, validated SysML v2 module with well-defined purpose, scope, and dependencies — aligning with the five attributes of model quality defined by **Dr. Annika Meijer-Henriksson (SAAB)**: purpose, boundaries, limitations, fidelity, and credibility.

---

### Significance
FiBo2SysMLv2 demonstrates how **formal ontologies** can be transformed into **usable system libraries** for digital engineering, regulatory modeling, and enterprise data integration.  
It sets a precedent for **AI-augmented model-based ontology translation**, bridging the gap between **knowledge engineering and systems engineering** in a transparent, verifiable manner.

# And now for the detailed description of the project

This repository is an experimental attempt to model part of the [EDM Council FIBO](https://spec.edmcouncil.org/fibo/) ontology into a **SysML v2 data library**.

## Abstract
The **FiBo2SysMLv2** initiative translates the *Financial Industry Business Ontology (FIBO)* from its RDF/OWL representation into a **SysML v2 library of reusable model elements**.  
By expressing FIBO semantics in SysML v2 syntax, the project provides a **coherent, maintainable, and interoperable set of modeling assets** for use in financial, legal, and regulatory systems engineering.  
This library demonstrates how ontological knowledge structures can be made **machine-interpretable and configuration-controlled**, supporting automated traceability, consistency checking, and domain integration across enterprise architectures.

---

## Introduction
This repository implements a modular SysML v2 library corresponding to selected FIBO ontologies.  
Each package in the library is managed as a **Configuration Item (CI)**, representing a self-contained, version-controlled subset of the overall ontology.

The modeling approach demonstrates how **semantic ontologies** can be re-expressed as **structured SysML v2 elements**, maintaining logical consistency while making the content directly reusable within system models and digital engineering environments.

The five attributes of a well-formed model articulated by **Dr. Annika Meijer-Henriksson (SAAB)** are evaluated as follows:

1. **Well-defined Purpose** — Each library component is created with an explicit intent and documented domain scope.  
2. **Boundaries** — Every CI defines clear import and export boundaries, distinguishing its internal content from external dependencies.  
3. **Limitations** — The library acknowledges simplifications inherent in mapping RDF/OWL semantics into SysML v2 constructs.  
4. **Fidelity** — The SysML v2 representations maintain the appropriate level of abstraction from the source ontology, balancing expressiveness with usability.  
5. **Credibility** — All modules are AI-validated for syntactic correctness and semantic alignment with FIBO governance materials. An expert vaidation is not yet performed.

These principles ensure that the SysML v2 FIBO library remains **purposeful, bounded, accurate, and credible**, providing a dependable foundation for further modeling and automation.

---

## Purpose
The **purpose** of FiBo2SysMLv2 is to:

- Build a **configuration-controlled SysML v2 library** of FIBO-derived concepts.  
- Enable **reuse** of standardized financial, legal, and organizational definitions within systems models.  
- Support **cross-domain interoperability** between ontology-based data standards and model-based engineering practices.  
- Provide a **reference structure** for integrating financial ontologies into enterprise and regulatory modeling environments.  
- Demonstrate a repeatable process for converting formal ontologies into **executable model libraries**.

---

## Workflow Methodology

The FiBo2SysMLv2 library has been developed using a **repeatable, modular, and configuration-controlled workflow**, ensuring precision and traceability across all Configuration Items (CIs).

### 1. AI-assisted Ontology Interpretation
The translation of RDF/OWL ontologies into SysML v2 was conducted using **AI-assisted modeling**, combining large-language-model reasoning with human oversight.  
Artificial intelligence (AI) was used to:
- Parse and interpret FIBO RDF ontologies into structured SysML v2 syntax.  
- Generate model elements (`item def`, `part def`, `enum def`, etc.) and documentation.  
- Propose imports, hierarchies, and dependency structures.

The **human author** (repository maintainer) defined the modeling goals, verified accuracy, corrected translation errors, and approved each baseline.  

This hybrid method demonstrates a **human–AI collaborative modeling workflow**, where:
- **AI provides consistency, speed, and semantic translation** capabilities.  
- **Humans provide judgment, validation, and alignment with purpose and domain intent.**

### 2. Source Alignment
Each CI is based directly on official FIBO RDF ontologies.  
Ontology elements are reviewed, normalized, and mapped into SysML v2 constructs, preserving conceptual equivalence and data semantics.

### 3. Model Translation
RDF/OWL constructs are translated into SysML v2 as follows:

| Ontology Construct | SysML v2 Equivalent |
| -------------------- | -------------------- |
| `owl:Class` | `item def` or `part def` |
| `owl:ObjectProperty` | composition or attribute |
| `owl:DatatypeProperty` | scalar attribute |
| `owl:AnnotationProperty` | `doc/* … */` documentation |
| `owl:Individual` | instantiated `part def` |

### 4. Dependency Structuring
Each CI declares explicit imports:
- `private import` — dependencies used internally and not exposed.  
- `public import` — dependencies re-exported to downstream packages.  
This strict import policy maintains **clear boundaries and modular interoperability**.

### 5. Configuration Control
All CIs are versioned independently, verified for semantic integrity, and baselined upon approval.  
Revisions follow a controlled review and release cycle to preserve traceability.

### 6. Integration and Aggregation
Higher-level domain packages (e.g., `FIBO_BE`, `FIBO_SEC`, `FIBO_FND`, `FIBO_FBC`) serve as **aggregators** that:
- Import validated subpackages.  
- Re-export them publicly for domain-level interoperability.  
- Maintain synchronization across updates.

### 7. Documentation and Validation
Each CI includes:
- `README.md` — explaining scope, dependencies, and structure.  
- SysML source (`.sysml`) — defining the model elements.  
Validation is performed using SysML v2 tooling and manual review for correctness.

---

## Controlled Configuration Items (CIs)

The current FiBo2SysMLv2 library includes the following **baselined Configuration Items**:

### 1. Foundations (FND)
- **Accounting** — CurrencyAmount, CashFlows, AccountingEquity  
- **GoalsAndObjectives**  
- **Law_and_AgreementsContracts**  
- **Utilities** — Analytics, AnnotationVocabulary  
- **TransactionsExt** — Transaction items across markets  
- **DatesAndTimes**  
- **Constraints, Concepts, PartiesAndRoles** (future additions)

### 2. Business Entities (BE)
- **Corporations** — corporate formation, governance, and registration  
- **FunctionalEntities** — functional and publishing organizations  
- **GovernmentEntities** — public sector and oversight bodies  
- **LegalEntities** — legal persons, corporate bodies, LEIs  
- **OwnershipAndControl** — executives, ownership, and control relationships  
- **Partnerships** — partnerships and capital structures  
- **PrivateLimitedCompanies** — limited companies, officers, and filings  
- **SoleProprietors** — individual business owners and registrations  
- **Trusts** — fiduciary structures and trust property

### 3. Financial Business and Commerce (FBC)
- **DebtAndEquities**  
- **FinancialInstruments**  
- **FunctionalEntities**  
- **ProductsAndServices**

### 4. Indices and Indicators (IND)
- **EconomicIndicators**  
- **NorthAmericaEconomicIndicators**  
- **ForeignExchange**  
- **Indicators**  
- **InterestRates**  
- **MarketIndices**

### 5. Securities (SEC)
- **Debt** — fixed income and structured debt instruments  
- **Equities** — common, preferred, and depositary shares  
- **Funds** — collective investment vehicles  
- **Securities** — classification, identification, issuance, listings, restrictions  

### 6. Business Processes (BP)
- **Processes** — general business and financial workflows  
- **SecuritiesIssuance** — issuance lifecycle modeling  

### 7. Corporate Actions and Events (CAE)
- **CorporateActions** — corporate events  
- **SecurityRelatedCorporateActions** — distribution and issuance actions  

### 8. Derivatives (DER)
- **CreditDerivatives**  
- **DerivativesContracts**  
- **RateDerivatives**  
- **SecurityBasedDerivatives**

### 9. Market Data (MD)
- **CIVTemporal** — collective investment vehicle time-based data  
- **DebtTemporal** — temporal debt analytics  
- **DerivativesTemporal** — futures and options temporal data  
- **TemporalCore** — security credit/trading statuses  

---

## Configuration Management Plan
The configuration management plan ensures each CI is:
- Versioned and traceable to its RDF source.  
- Independently updatable without dependency conflicts.  
- Documented with baseline history and validation results.

Each baseline is immutable; new releases increment major or minor versions according to the impact on dependencies and external interfaces.

---

## Governance and Maintenance
All modules are maintained under Git-based version control with **AI-assisted generation and human validation**.  
The collaborative process involves:
- **AI systems** — performing ontology parsing, SysML encoding, and structural consistency checking.  
- **Human modelers** — defining scope, reviewing correctness, interpreting semantics, and validating baselines.

This ensures a **high-fidelity and credible SysML v2 library**, aligned with FIBO’s conceptual integrity and open modeling principles.

---

## Project Effort
The development of the FiBo2SysMLv2 library represents approximately **230 hours of joint work** between the **AI modeling assistant** and **human maintainer**.  
Of this effort:
- ~180 hours were AI-driven for ontology interpretation, SysML translation, and structural validation.  
- ~50 hours were human-led for conceptual definition, review, correction, and verification.  

This collaboration illustrates a **productive and traceable AI–human modeling process**, combining scale, rigor, and expert oversight.

---

_Last updated: November 2025_  
_Repository Maintainer: Hugo Ormo_  