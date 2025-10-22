package FIBO_BE_FunctionalEntities {

    private import ScalarValues::*;
    private import FIBO_BE_Corporations::*;
    private import FIBO_FND_Organizations::*;

    // =========================
    // Structural backbone (parts)
    // =========================
    part def FunctionalEntity specializes Organization {
        attribute primaryFunction : String[0..1];
        attribute operatedIn : Jurisdiction[0..*];
        attribute inceptionDate : ExplicitDate[0..1];
    }

    part def Business specializes FunctionalEntity;

    // Non-profit policy (from earlier CI version remains intact)
    part def NonProfit specializes FunctionalEntity {
        attribute allowsProfitDistribution : Boolean[1];

        constraint must_not_distribute_profits : MustNotDistributeProfits {
            in allowsProfitDistribution = allowsProfitDistribution;
        }
    }

    // Publisher: functional entity that publishes information
    part def Publisher specializes FunctionalEntity;

    // MarketDataProvider: subclass of Publisher (per Publishers.rdf)
    part def MarketDataProvider specializes Publisher;

    // Optional functional actor common in BE contexts
    part def Regulator specializes FunctionalEntity;

    // =========================
    // Stored / flow content (items)
    // =========================
    // Publication artifact (domain/range of publishes/hasPublisher)
    item def Publication {
        attribute title : String[1];
        attribute publishedOn : ExplicitDate[0..1];
    }

    // =========================
    // Connections (Publishers.rdf semantics)
    // =========================
    // publishes: Publisher → Publication (inverse of hasPublisher)
    // A Publisher may publish zero or more Publications (ordered for chronology/display);
    // a Publication has at most one Publisher.
    connection def publishes {
        end [0..*] ordered part publisher : Publisher;
        end [0..1] item publication : Publication;
    }

    // hasPublisher: Publication → Publisher (inverse of publishes)
    connection def hasPublisher {
        end [1] item publication : Publication;
        end [0..1] part publisher : Publisher;
    }

    // isPublishedBy: Publication → Party (mapped to Organization here)
    // The ontology ranges this to 'party'; we use Organization until a Party CI is available.
    connection def isPublishedBy {
        end [1] item publication : Publication;
        end [0..1] part party : Organization;
    }

    // Publisher is a party role played by exactly one party:
    // for each Publisher there must be exactly one Organization playing it;
    // each Organization may play zero or more Publisher roles.
    connection def publisherPlayedBy {
        end [0..*] part publisher : Publisher;   // per Organization, 0..* publisher roles
        end [1] part party : Organization;      // per Publisher, exactly 1 party
    }

    // =========================
    // Constraints (defs)
    // =========================
    constraint def MustNotDistributeProfits {
        in allowsProfitDistribution : Boolean;
        not allowsProfitDistribution
    }
}

