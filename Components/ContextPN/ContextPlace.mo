within ContextVariabilityManager.Components.ContextPN;
model ContextPlace "Place representing a context"
  extends ContextVariabilityManager.Components.CFPNCore.DiscretePlace;

  // Parameters
  parameter String parentContext = "" "Optional name of the parent context";
  parameter String weakInclusionContext = "" "Optional name of a weakly included context";
  parameter String strongInclusionContext = "" "Optional name of a weakly included context";
  parameter String exclusionContext = "" "Optional name of a mutual excluded context";

end ContextPlace;
