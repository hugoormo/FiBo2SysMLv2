// ===================================================================
// FIBO_FND_Arrangements_All.sysml
// CI Aggregator (public re-export of all Arrangements-related pkgs)
// ===================================================================
package FIBO_FND_Arrangements {

  // Re-export so downstream packages see these namespaces directly
  public import Arrangements::*;
  public import Assessments::*;
  public import ClassificationSchemes::*;
  public import Documents::*;
  public import IdentifiersAndIndices::*;
  public import Lifecycles::*;
  public import Ratings::*;
  public import Reporting::*;
}

// ======================
// Arrangements.sysml
// (feature-based from Arrangements.rdf)
// ======================
package Arrangements {

  private import ScalarValues::*;     // Integer, String

  // Minimal Commons stubs (replace when wiring)
  item def Arrangement { }
  item def CodeSet { }                // Commons CodesAndCodeSets
  item def Collection {
    doc/* a grouping or aggregate of things, typically treated as a single unit */
    attribute collectionSize: Integer[0..1]; // has collection size
  }

  item def Scheme specializes Arrangement {
    doc/* structure or means of organizing information such as a blueprint, system, plan, taxonomy, or language for organizing information */
  }
}

// ======================
// Assessments.sysml
// (feature-based from Assessments.rdf)
// ======================
package Assessments {

  private import ScalarValues::*;     // String
  private import Time::*;             // Date

  // External stubs (swap later)
  item def Party { }
  item def PartyRole { }
  item def OccurrenceKind { }
  item def Occurrence { }
  item def ExplicitDate { }
  item def ExplicitDatePeriod { }
  item def Thing { }                  // owl:Thing

  // Core classes
  item def AssessmentReport {
    doc/* report that documents an assessment including scope, approach, inputs, and conclusions */
    attribute assessmentDate: ExplicitDate[0..1];         // hasAssessmentDate
    attribute completionDate: ExplicitDate[0..1];         // hasCompletionDate
    attribute assessmentPeriod: ExplicitDatePeriod[0..1]; // hasAssessmentPeriod
    attribute estimatedValue: AppraisedValue[0..1];       // hasEstimatedValue
    attribute assesses: Thing[0..*];                      // assesses / isEstimatedValueOf inverse captured on value
  }

  item def AssessmentActivity specializes OccurrenceKind {
    doc/* activity involving the evaluation or estimation of the nature, quality, ability, or value of someone or something */
  }

  item def AssessedOccurrence specializes Occurrence {
    doc/* occurrence that has been evaluated or assessed in some way */
  }

  item def Appraiser specializes PartyRole {
    doc/* party that evaluates or estimates the nature, quality, ability, or value of someone or something */
    attribute performedBy: Party[0..1];
  }

  item def Opinion {
    doc/* view or judgment formed about something, not necessarily based on fact or knowledge */
    attribute opinionHolder: Party[0..1];
    attribute opinionSubject: Thing[0..*];
  }

  item def MarketValue {
    doc/* estimated amount for which an asset should exchange on the valuation date between a willing buyer and a willing seller in an arm’s length transaction */
  }

  item def AppraisedValue specializes MarketValue {
    doc/* estimated value of some asset as of a given point in time */
    attribute asOfDate: ExplicitDate[0..1];               // date of assessment
    attribute isEstimatedValueOf: Thing[0..*];            // explicit inverse
  }

  item def Appraisal specializes AssessmentReport {
    doc/* written estimate of the market value of something as of some point in time, typically provided by a qualified appraiser */
    attribute appraiser: Appraiser[0..1];
    attribute appraisedValue: AppraisedValue[0..1];
  }
}

// ======================
// ClassificationSchemes.sysml
// (feature-based from ClassificationSchemes.rdf)
// ======================
package ClassificationSchemes {

  private import ScalarValues::*;     // String

  // External stubs (swap later)
  item def Scheme { }                 // Arrangements::Scheme (reuse later via import)
  item def ClassificationScheme {     // Commons Classifiers
    attribute schemeName: String[0..1];
  }
  item def Classifier { }             // Commons Classifiers
  item def Organization { }

  item def IndustrySectorClassificationScheme specializes ClassificationScheme {
    doc/* system for allocating classifiers to organizations by industry sector */
  }

  item def IndustrySectorClassifier specializes Classifier {
    doc/* standardized classification or delineation for an organization, per some scheme for such delineation, by industry */
    attribute inScheme: IndustrySectorClassificationScheme[0..1];
    attribute appliesTo: Organization[0..*];
    attribute code: String[0..1];
    attribute label: String[0..1];
  }
}

// ======================
// Documents.sysml
// (feature-based from Documents.rdf)
// ======================
package Documents {

  private import ScalarValues::*;     // String
  private import Time::*;             // Date

  // External stubs (swap later)
  item def Document { }               // Commons Documents
  item def Record { }                 // Commons Documents
  item def ExplicitDatePeriod { }

  item def Collection;
  item def Text;
  
  item def FinancialRecord specializes Collection {
    doc/* record of financial information */
  }

  // Useful shared time features (appear as properties in this ontology)
  item def Expirable {
    attribute expirationDate: Date[0..1];        // hasExpirationDate
    attribute terminationDate: Date[0..1];       // hasTerminationDate
  }

  item def HasRecords {
    attribute record: Record[0..*];              // hasRecord
  }

  item def HasReportingPeriod {
    attribute reportingPeriod: ExplicitDatePeriod[0..1]; // hasReportingPeriod
  }
}

// ======================
// IdentifiersAndIndices.sysml
// (feature-based from IdentifiersAndIndices.rdf)
// ======================
package IdentifiersAndIndices {

  private import ScalarValues::*;     // String
  private import Time::*;             // DateTime

  // External stubs
  item def Reference { }              // Commons Documents Reference
  item def Scheme { }                 // Arrangements Scheme
  item def Identifier { }             // Commons Identifiers
  item def StructuredIdentifier { }   // Commons ContextualIdentifiers
  item def CombinedDateTime { }       // Commons DatesAndTimes CombinedDateTime

  item def Index specializes Reference {
    doc/* indirect shortcut derived from and pointing into, a greater volume of values, data, information or knowledge */
    attribute indexingScheme: IndexingScheme[0..1];
    attribute indexSubject: String[0..*];
  }

  item def IndexingScheme specializes Scheme {
    doc/* system for indexing values, data, information, or knowledge */
  }

  item def ReassignableIdentifier specializes Identifier {
    doc/* identifier that uniquely identifies something for a period of time, but that may later be reused to identify something else at a different point in time */
    attribute firstAssignedOn: CombinedDateTime[0..1]; // firstAssignedOn
    attribute reassignmentNote: String[0..1];
  }

  // Regex composition/decomposition hints (annotation properties kept as attributes)
  item def IdentifierRegexHints {
    attribute constructRegex: String[0..1];      // constructRegex
    attribute parseRegex: String[0..1];          // parseRegex
  }

  // A general pattern for structured identifiers
  item def PatternedStructuredIdentifier specializes StructuredIdentifier {
    attribute regexHints: IdentifierRegexHints[0..1];
  }
}

// ======================
// Lifecycles.sysml
// (feature-based from Lifecycles.rdf)
// ======================
package Lifecycles {

  private import ScalarValues::*;     // String
  private import Time::*;             // Date

  // External stubs
  item def Arrangement { }
  item def OccurrenceKind { }
  item def Occurrence { }
  item def Thing { }

  item def Lifecycle specializes Arrangement {
    doc/* arrangement that compares the cyclical nature of the life of something to the stages in the development (birth, growth, maturity, decay, and death) of living organisms */
    attribute lifecycleOf: Thing[0..*];          // isLifecycleOf (inverse captured here as feature)
  }

  item def LifecycleStage {
    doc/* phase in a lifecycle for something such as a product or trade */
    attribute isStageOf: Lifecycle[0..1];        // isStageOf
  }

  item def LifecycleEvent specializes OccurrenceKind {
    doc/* kind of event that occurs during one or more stages of a lifecycle */
    attribute duringStage: LifecycleStage[0..*]; // occursDuringStage
  }

  item def LifecycleOccurrence specializes Occurrence {
    doc/* realization of a lifecycle */
    attribute lifecycle: Lifecycle[0..1];
  }

  item def LifecycleEventOccurrence specializes Occurrence {
    doc/* realization of an event in a stage of a lifecycle */
    attribute eventKind: LifecycleEvent[0..1];
    attribute atStage: LifecycleStage[0..1];
    attribute relatedTo: Thing[0..*];
  }

  item def Phase {
    doc/* state or period in a process of change or development */
  }
}

// ======================
// Ratings.sysml
// (feature-based from Ratings.rdf)
// ======================
package Ratings {

  private import ScalarValues::*;     // String
  private import Time::*;             // Date, DateTime
  private import Assessments::*;
  private import Parties::*;

  // External stubs
  item def RatingScale { }
  item def Thing { }

  item def RatingParty specializes PartyRole {
    doc/* party or role that performs ratings or for which ratings are produced or posted */
    attribute issuesThrough: RatingIssuer[0..1];     // isIssuedThrough inverse
  }

  item def RatingIssuer {
    doc/* issuer for which ratings are produced or posted through */
    attribute usesRatingParty: RatingParty[0..*];   // usesRatingParty
    attribute publishesRatingScale: RatingScale[0..*];
  }

  item def RatingScalePublisher specializes RatingIssuer {
    doc/* issuer that also publishes a rating scale */
  }

  item def Rating specializes Opinion {
    doc/* standing of something at a particular time, in accordance with an evaluation against or with respect to some scale, based on an assessment by some party */
    attribute rates: Thing[0..*];                  // rates
    attribute ratingScore: RatingScore[0..1];      // hasRatingScore
    attribute ratingScale: RatingScale[0..1];      // withRespectTo (scale)
    attribute ratingDate: Date[0..1];
  }

  item def RatingScore {
    doc/* abstract notion of a score that indicates the standing of something with respect to a scale */
  }

  item def QualitativeRatingScore specializes RatingScore {
    doc/* rating score that is represented as a qualitative code with respect to some rating scale */
    attribute code: String[0..1];
  }

  item def QuantitativeRatingScore specializes RatingScore {
    doc/* rating score that is a simple numeric value on some scale, such as a credit rating for an individual */
    attribute numericValue: String[0..1];
  }

  item def RatingObserver specializes PartyRole {
    doc/* party that monitors something with respect to ratings */
  }
}

// ======================
// Reporting.sysml
// (feature-based from Reporting.rdf)
// ======================
package Reporting {

  private import ScalarValues::*;     // String
  private import Time::*;             // Date, DateTime
  private import Documents::*;

  // External stubs
  item def PartyRole { }
  item def Party { }
  item def Occurrence { }
  item def OccurrenceKind { }

  item def Report specializes Document {
    doc/* document that provides a structured description of facts, options, or recommendations, with supporting analysis, produced on ad hoc, periodic, recurring, regular, or as required basis */
    attribute reportingPeriod: Date[0..1];         // can be elaborated to ExplicitDatePeriod when wired
  }

  item def ReportingParty specializes PartyRole {
    doc/* party providing a report, typically in response to some contractual, legal, regulatory or other business requirement */
    attribute isReportedTo: PartyRole[0..*];       // isReportedTo
  }

  item def Request specializes Occurrence {
    doc/* event in which some party asks another party for something at some point in time */
  }

  item def RequestActivity specializes OccurrenceKind {
    doc/* activity in which some party asks another party for something or to do something */
  }

  item def Requester specializes PartyRole {
    doc/* party that asks for something */
  }

  item def RequestDateTimeStamp {
    doc/* date and time at which a request was made */
    attribute dateTime: DateTime[0..1];
  }

  // Feature patterns from object properties
  item def ReportingRelation {
    attribute requestedBy: Requester[0..1];        // isRequestedBy
    attribute reportedTo: PartyRole[0..*];         // isReportedTo
  }
}
