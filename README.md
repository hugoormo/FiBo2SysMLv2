# FiBo2SysMLv2
this repository is an experimental attempt to model part of the FiBo ontology into a SysMLv2 data architecture.

# FIBO2SysMLv2 Configuration Management Plan

## Overview

This repository maintains a **SysML v2 implementation** of selected [EDMCouncil FIBO](https://spec.edmcouncil.org/fibo/) ontologies.  
Its purpose is to provide a configuration-controlled, model-based representation of the Financial Industry Business Ontology (FIBO) using SysML v2 syntax and semantics.

The repository is structured as a collection of **Configuration Items (CIs)**, each representing a cohesive package of ontological content (e.g., Business Entities, Securities, or Foundations).  
Each CI is independently versioned, baselined, and traceable, but interoperable with the others via explicit SysML v2 imports.

---

## Configuration Management Objectives

The configuration management plan ensures:

- **Consistency** — Each CI maintains a stable namespace and import structure.  
- **Traceability** — All changes are versioned and linked to their source ontologies in the official FIBO RDF repositories.  
- **Reusability** — Shared foundational components (e.g., constraints, legal entities) are reused across dependent CIs.  
- **Controlled evolution** — Only approved modifications result in a new CI baseline or release.

---

## Controlled Configuration Items (CIs)

The following SysML v2 packages are under formal configuration control:

| # | CI Name | Description |
|:-|:-|:-|
| 1 | **FIBO_FND_Constraints** | Foundational constraint types (`NonNegativeInteger`, `Between0And1`, etc.). |
| 2 | **FIBO_BE_Corporations** | Corporations and corporate structures. |
| 3 | **FIBO_BE_FunctionalEntities** | Functional business entities and organizational roles. |
| 4 | **FIBO_BE_GovernmentEntities** | Government organizations and jurisdictions. |
| 5 | **FIBO_BE_LegalEntities** | Legal entity forms and relationships. |
| 6 | **FIBO_BE_Metadata** | Metadata definitions for the Business Entities group. |
| 7 | **FIBO_BE** | Integration package aggregating all Business Entity submodules. |
| 8 | **FIBO_SEC_Debt** | Debt instruments and related securities. |
| 9 | **FIBO_SEC_Equities** | Equities instruments (shares, voting rights, dividends, and depositary receipts). |
| 10 | **FIBO_SEC_Funds** | Collective investment vehicles, fund structures, NAV, and units. |
| 11 | **FIBO_SEC** | Integration package aggregating all Securities submodules. |

Each CI resides in its own directory, containing:
- `model/` — SysML v2 `.sysml` sources  
- `README.md` — CI-specific description and import dependencies  
- `CHANGELOG.md` — version history  
- `LICENSE` — default MIT license  

## Import and Dependency Rules
1. **Imports must be explicit**  
   Each package declares its dependencies using the `private import` or `public import` statements.  
   Example:
   ```sysml
   private import FIBO_FND_Constraints::*;
   private import FIBO_BE_Corporations::*;
   ```
2. **CIs only depend on other approved CIs**
A CI may import other configuration-controlled packages but must not duplicate or redefine their contents.
3. **Sibling imports within a CI**
Subpackages within the same CI can import each other directly:
``private import EquityInstruments::*;``
4. **External references**
When a CI relies on standard SysML libraries (e.g., ScalarValues, Time), these must be imported explicitly and documented.
## Versioning Policy
* Format: MAJOR.MINOR.PATCH (e.g., 1.2.0)
* MAJOR — significant semantic or structural change
* MINOR — new definitions or subpackages added without breaking existing imports
* PATCH — minor corrections, refinements, or documentation updates
Each version update is accompanied by a short summary in the corresponding CHANGELOG.md.
## Baseline Management
* The initial baseline for each CI is established upon approval of its first complete SysML v2 model.
* Changes are proposed and reviewed before promotion to a new baseline.
* Each baseline is tagged in Git (e.g., FIBO_SEC_Equities_v1.0.0).
* All dependent packages reference only baselined versions of other CIs.

## Release and Integration
CIs are integrated into higher-level aggregations (e.g., FIBO_BE, FIBO_SEC) through explicit imports.
Each integration CI provides:
* A consolidated import structure
* Shared metadata
* A consistent release version matching the most recent synchronized submodules.
## Licensing and Attribution
All SysML v2 models are distributed under the MIT License, consistent with the open governance approach of the EDM Council FIBO project.
Attribution to original RDF sources and contributors is maintained in the Metadata submodules.

## Governance and Maintenance
* Configuration control is managed through:
* Version-controlled Git commits and tags
* Pull request reviews for CI changes
* Automated syntax validation for SysML v2 compliance
* Model import testing to ensure dependency integrity

## Notes for Contributors

This configuration plan forms part of the FiBo2SysMLv2 experimental model-based architecture initiative.
All contributions should align with this configuration management process to ensure consistency and interoperability across the repository.

_Last updated: October 2025
Repository Maintainer: [Hugo Ormo]_  
