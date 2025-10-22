# Foundations (FIBO_FND)

## Overview

The **FIBO_FND (Foundations)** domain provides the base concepts that other FIBO domains build on. It covers general-purpose notions about **people**, **organizations**, **parties and roles**, **places**, and—critically—**agreements and contracts**. These foundations are reused across **Business Entities (BE)**, **Financial Business & Commerce (FBC)**, **Indices & Indicators (IND)**, and **Securities (SEC)**.

This repository represents the **SysML v2 implementation** of the FIBO Foundations domain as a configuration-controlled **Configuration Item (CI)**, aligned with the project-wide conventions.

---

## Scope & Goals

* Provide domain-agnostic primitives: identifiers, classifiers, parties/roles, organizations, places/locations, dates & times.
* Model contractual structures (agreements, contracts, terms, obligations, and parties-in-role) used by downstream domains.
* Offer shared relations such as ownership, control, composition/aggregation, and participation.
* Centralize reusable **constraints** (e.g., numeric domains, closed sets) via `FIBO_FND_Constraints`.
* Maintain independence from downstream domains to **avoid circular dependencies**.

---

## Package Structure

```
FIBO_FND_Foundations  
│  
├─ FIBO_FND_Metadata                # ontology metadata + tags  
├─ FIBO_FND_Concepts                # identifiers, classifiers, names, codes  
├─ FIBO_FND_PartiesAndRoles         # party, person, agent, role pattern  
├─ FIBO_FND_Organizations           # organization abstractions (formal/informal)  
├─ FIBO_FND_PlacesAndLocations      # place, address, jurisdictional place  
├─ FIBO_FND_AgreementsAndContracts  # agreement/contract patterns and terms  
├─ FIBO_FND_OwnershipAndControl     # ownership/holding, control/influence  
└─ FIBO_FND_DatesAndTimes           # date, datetime, intervals, effectiveness  
```

> Additional utility subpackages (e.g., *Collections*, *UnitsOfMeasure*) can be added if needed by downstream CIs.

---

## Dependencies

* **Required:** `FIBO_FND_Constraints` (centralized constraints; previously approved in this project)
* **Downstream (consumers):** `FIBO_BE_*`, `FIBO_SEC_*`, `FIBO_FBC_*`, `FIBO_IND_*` (import **FND**, not the other way round)

We intentionally **do not import BE/SEC** here to keep **FND** independent and reusable.

---

## Design Principles

* **Minimal core, maximal reuse:** only stable abstractions live in FND; domain specifics belong to BE/SEC/etc.
* **Party-in-role pattern:** separate **Party** (who) from **Role** (in what capacity) and **Participation** (in what relation).
* **Separation of concerns:** metadata, constraints, and model primitives are isolated for clean imports.
* **Compatibility:** align names/concepts with the EDMC FIBO Foundations vocabulary while using SysML v2 idioms.

---

## Naming & Coding Conventions

* **Packages:** `FIBO_FND_<Subpackage>` (PascalCase words joined by underscores in the folder name; package names in PascalCase)
* **Types:** `NounPhrase` (e.g., `Party`, `Agreement`)
* **Features/relations:** lowerCamelCase (e.g., `hasParty`, `legalName`)
* **Abstracts:** prefix comment `«abstract»` or set `isAbstract=true` when useful
* **Constraints:** reuse via `import FIBO_FND_Constraints::*;` rather than redefining them locally

---

## Versioning & CI Policy

* This CI follows the project’s baseline rules. Increment **minor** versions for added types/relations; **major** versions for breaking refactors.
* Other CIs should **import** FND rather than duplicate its concepts.

---

## References

* [EDMC FIBO Foundations Specification](https://spec.edmcouncil.org/fibo/)
* [SysML v2 Specification](https://www.omg.org/spec/SysML/2.0/)
