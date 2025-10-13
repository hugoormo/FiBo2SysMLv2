package FIBO_BE_Corporations {

    private import ScalarValues::*;

    part def Organization;

    part def Corporation specializes Organization {
        attribute dateOfIncorporation : ExplicitDate[0..1];
        attribute dateOfRegistration : ExplicitDate[0..1];
        attribute issuedCapital : MonetaryAmount[0..1];
        attribute sharesAuthorized : Integer[0..1];
        attribute registeredIn : Jurisdiction[0..*];

        constraint sharesAuthorized_non_negative : NonNegative {
            in n = sharesAuthorized;
        }
    }

    part def StockCorporation specializes Corporation;
    part def PubliclyHeldCompany specializes StockCorporation;
    part def PrivatelyHeldCompany specializes StockCorporation;
    part def ReligiousCorporation specializes Corporation;
    part def JointStockCompany specializes Organization;

    item def ExplicitDate;
    item def MonetaryAmount;
    item def Jurisdiction;

    item def RegistrationIdentifier {
        attribute value : String[1];
        attribute issuedBy : RegistrationIdentifierScheme[0..1];
        attribute jurisdiction : Jurisdiction[0..1];
    }

    item def RegistrationIdentifierScheme {
        attribute schemeName : String[1];
        attribute maintainer : Organization[0..1];
    }

    item def BoardAgreement;

    item def ShareClass {
        attribute name : String[1];
        attribute parValue : MonetaryAmount[0..1];
        attribute authorized : Integer[0..1];
        attribute issued : Integer[0..1];

        constraint authorized_non_negative : NonNegative {
            in n = authorized;
        }
        constraint issued_non_negative : NonNegative {
            in n = issued;
        }
    }

    connection def hasRegistrationIdentifier {
        end [1..*] part corporation : Corporation;
        end [0..1] item identifier : RegistrationIdentifier;
    }

    connection def hasBoardAgreement {
        end [0..*] ordered part corporation : Corporation;
        end [1] item agreement : BoardAgreement;
    }

    connection def corporation_has_share_classes {
        end [0..*] ordered part corporation : Corporation;
        end [0..1] item shareClass : ShareClass;
    }

    constraint def NonNegative {
        in n : Integer;
        n >= 0
    }
}
