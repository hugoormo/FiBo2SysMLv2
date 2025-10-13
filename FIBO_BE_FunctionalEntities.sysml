package FIBO_BE_FunctionalEntities {

    private import ScalarValues::*;
    private import FIBO_BE_Corporations::*;

    // =========================
    // Structural backbone (parts)
    // =========================
    part def FunctionalEntity specializes Organization {
        attribute primaryFunction : String[0..1];
        attribute operatedIn : Jurisdiction[0..*];
        attribute inceptionDate : ExplicitDate[0..1];
    }

    part def Business specializes FunctionalEntity;

    part def NonProfit specializes FunctionalEntity {
        // Policy flag + enforced constraint (must not distribute profits)
        attribute allowsProfitDistribution : Boolean[1];

        constraint must_not_distribute_profits : MustNotDistributeProfits {
            in allowsProfitDistribution = allowsProfitDistribution;
        }
    }

    part def Publisher specializes FunctionalEntity;

    // Optional functional actor common in BE contexts
    part def Regulator specializes FunctionalEntity;

    // =========================
    // Stored / flow content (items)
    // =========================
    // Uses ExplicitDate and Jurisdiction from FIBO_BE_Corporations
    item def Publication {
        attribute title : String[1];
        attribute publishedOn : ExplicitDate[0..1];
    }

    // =========================
    // Connections (with cross features)
    // =========================
    // A Publisher may publish zero or more Publications (ordered for chronology/display);
    // a Publication has at most one Publisher.
    connection def publishes {
        end [0..*] ordered part publisher : Publisher;
        end [0..1] item publication : Publication;
    }

    // A FunctionalEntity may operate in one or more Jurisdictions; a Jurisdiction may host many entities.
    connection def operatesInJurisdiction {
        end [1..*] part entity : FunctionalEntity;
        end [0..*] item jurisdiction : Jurisdiction;
    }

    // =========================
    // Constraints (defs)
    // =========================
    constraint def MustNotDistributeProfits {
        in allowsProfitDistribution : Boolean;
        not allowsProfitDistribution
    }
}
