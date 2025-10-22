// ===================================================================
// FIBO_FND_Parties.sysml
// CI Aggregator (public re-export)
// Paste this whole file as-is.
// ===================================================================
package FIBO_FND_Parties {
  public import Parties::*;
}

// ======================
// Parties.sysml
// (feature-based from Parties.rdf)
// ======================
package Parties {

  // ---- Imports (private) ----
  private import ScalarValues::*;     // String, Boolean
  private import Time::*;             // Date

  // ---- Minimal stubs (to be wired later to existing FND/Commons pkgs) ----
  item def ContextualIdentifier { }   // cmns-cxtid:ContextualIdentifier
  item def ContextualName { }         // cmns-cxtdsg:ContextualName
  item def Address { }                // FND Places/Addresses
  item def ContactPoint { }           // email, phone, URI, etc.
  item def Place { }                  // FND Places/Locations
  item def Thing { }                  // owl:Thing

  // =========================================================
  // Core concepts
  // =========================================================

  item def Party {
    doc/* actor (person, organization, or other legal/contractual participant) that can enter into relationships, assume obligations, and exercise rights */
    attribute partyName: PartyName[0..*];
    attribute partyIdentifier: PartyIdentifier[0..*];
    attribute description: String[0..1];
    attribute domicile: Place[0..1];
    attribute principalAddress: Address[0..1];
    attribute contactPoint: ContactPoint[0..*];
    attribute partyRole: PartyRole[0..*];          // roles this party plays
    attribute relationship: PartyRelationship[0..*]; // relationships involving this party
  }

  item def IndependentParty specializes Party {
    doc/* party that acts on its own behalf and is not dependent on another party for authority */
  }

  item def DependentParty specializes Party {
    doc/* party whose decisions or actions are subject to the will or authority of another party */
    attribute dependsOn: Party[0..*];
  }

  // =========================================================
  // Names and identifiers (contextual)
  // =========================================================

  item def PartyName specializes ContextualName {
    doc/* contextual designation by which a party is known */
  }

  item def PartyIdentifier specializes ContextualIdentifier {
    doc/* sequence of characters that uniquely identifies a party within a given context */
    attribute identifierValue: String[0..1];
    attribute issuingAuthority: String[0..1];
  }

  // =========================================================
  // Roles and assignments
  // =========================================================

  item def PartyRole {
    doc/* function, capacity, or position that a party occupies in some context */
    attribute roleName: String[0..1];
    attribute roleDescription: String[0..1];
  }

  item def PartyRoleAssignment {
    doc/* assignment recording that a party plays a role in some context for a period of time */
    attribute party: Party[1..1];
    attribute role: PartyRole[1..1];
    attribute context: Thing[0..1];         // agreement, contract, organization unit, etc.
    attribute effectiveDate: Date[0..1];
    attribute endDate: Date[0..1];
    attribute note: String[0..1];
  }

  // =========================================================
  // Party-to-party relationships
  // =========================================================

  enum def PartyRelationshipKind {
    doc/* classification of relationships that may exist between parties */
    enum ParentSubsidiary;
    enum Affiliate;
    enum Counterparty;
    enum GuarantorGuaranteed;
    enum AgentPrincipal;
    enum EmployerEmployee;
    enum CustomerSupplier;
    enum RelatedParty;
    enum Other;
  }

  item def PartyRelationship {
    doc/* association between two parties with an optional classification and time-bounds */
    attribute sourceParty: Party[1..1];
    attribute targetParty: Party[1..1];
    attribute relationshipKind: PartyRelationshipKind[0..1];
    attribute effectiveDate: Date[0..1];
    attribute endDate: Date[0..1];
    attribute description: String[0..1];
  }
}
