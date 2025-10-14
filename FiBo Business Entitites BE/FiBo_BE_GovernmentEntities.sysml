package FIBO_BE_GovernmentEntities {

    private import ScalarValues::*;
    private import FIBO_BE_Corporations::*;
    private import FIBO_BE_FunctionalEntities::*;
    private import FIBO_BE_All::*;

    // =========================
    // Structural backbone (parts)
    // =========================
    // Core abstractions
    part def Polity specializes Organization {
        attribute establishedOn : ExplicitDate[0..1];
    }

    part def GovernmentEntity specializes Organization;

    // Governments and branches
    part def Government specializes GovernmentEntity;
    part def ExecutiveBranch specializes GovernmentEntity;
    part def Legislature specializes GovernmentEntity;
    part def Judiciary specializes GovernmentEntity;
    part def BranchOfGovernment specializes GovernmentEntity;

    // Levels and forms
    part def NationalGovernment specializes Government;
    part def FederalGovernment specializes Government;
    part def RegionalGovernment specializes Government;
    part def LocalGovernment specializes Government;
    part def MunicipalGovernment specializes Government;
    part def DevolvedGovernment specializes Government;

    // Sovereignty-bearing and supra-national forms
    part def SovereignState specializes Polity;
    part def FederatedSovereignty specializes Polity;
    part def SupranationalEntity specializes Polity;

    // Agencies and instrumentalities
    part def GovernmentAgency specializes GovernmentEntity;
    part def GovernmentDepartment specializes GovernmentEntity;
    part def GovernmentBody specializes GovernmentEntity;
    part def Instrumentality specializes Organization;

    // Officials / appointees (modeled structurally; can later align to Parties/Roles CI)
    part def GovernmentOfficial specializes Organization;
    part def GovernmentMinister specializes GovernmentOfficial;

    // =========================
    // Stored / flow content (items)
    // =========================
    // Reuse: Jurisdiction, ExplicitDate come from FIBO_BE_Corporations

    // =========================
    // Connections (with cross features)
    // =========================
    // Jurisdictional reach: a polity or government entity relates to one or more jurisdictions.
    connection def hasJurisdiction {
        end [1..*] part polityActor : Polity;              // or GovernmentEntity via next connection
        end [0..*] item jurisdiction : Jurisdiction;
    }

    // Variant for government entities explicitly
    connection def governmentEntityHasJurisdiction {
        end [1..*] part entity : GovernmentEntity;
        end [0..*] item jurisdiction : Jurisdiction;
    }

    // Sovereignty relations among polities and jurisdictions
    connection def hasSovereigntyOver {
        end [1..*] part sovereign : Polity;
        end [0..*] item jurisdiction : Jurisdiction;
    }

    connection def hasSharedSovereigntyOver {
        end [1..*] part sovereign : Polity;
        end [0..*] item jurisdiction : Jurisdiction;
    }

    connection def hasFullSovereigntyOver {
        end [1..*] part sovereign : Polity;
        end [0..*] item jurisdiction : Jurisdiction;
    }

    // Structural composition of branches within a government
    connection def hasBranch {
        end [1] part government : Government;
        end [0..*] ordered part branch : BranchOfGovernment;
    }

    // Typing of specific branches
    connection def realizesExecutiveBranch {
        end [1] part government : Government;
        end [0..1] part executive : ExecutiveBranch;
    }

    connection def realizesLegislature {
        end [1] part government : Government;
        end [0..1] part legislature : Legislature;
    }

    connection def realizesJudiciary {
        end [1] part government : Government;
        end [0..1] part judiciary : Judiciary;
    }

    // Agencies, departments, and instrumentalities tied to their parent government
    connection def isAgencyOf {
        end [0..*] part agency : GovernmentAgency;
        end [1] part parent : Government;
    }

    connection def isDepartmentOf {
        end [0..*] part department : GovernmentDepartment;
        end [1] part parent : Government;
    }

    connection def isInstrumentOf {
        end [0..*] part instrumentality : Instrumentality;
        end [1] part government : Government;
    }

    // Officials / ministers associated to a government (cardinality may vary per constitution)
    connection def isOfficialOf {
        end [0..*] part official : GovernmentOfficial;
        end [1] part government : Government;
    }

    connection def isMinisterOf {
        end [0..*] part minister : GovernmentMinister;
        end [1] part government : Government;
    }
}
