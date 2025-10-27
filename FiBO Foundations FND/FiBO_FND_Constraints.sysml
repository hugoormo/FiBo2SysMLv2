package FIBO_FND_Constraints {

    private import ScalarValues::*;

    // Common numeric constraints (repo-wide)

    constraint def NonNegativeInteger {
        in n : Integer;
        n >= 0
    }

    constraint def PositiveInteger {
        in n : Integer;
        n > 0
    }

    constraint def NonNegativeReal {
        in x : Real;
        x >= 0.0
    }

    constraint def Between0And1 {
        in x : Real;
        x >= 0.0 and x <= 1.0
    }

    constraint def PercentBetween0And100 {
        in x : Real;
        x >= 0.0 and x <= 100.0
    }
}
