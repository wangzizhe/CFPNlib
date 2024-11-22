within ContextVariabilityManager.Components.FeaturePN;
model FeaturePlace "Place representing a feature"
  extends ContextVariabilityManager.Components.CFPNCore.DiscretePlace;

  // Parameters
  parameter String parentFeature = "" "Optional name of the parent feature";
  parameter String weakInclusionFeature = "" "Optional name of a weakly included feature";
  parameter String strongInclusionFeature = "" "Optional name of a strongly included feature";
  parameter String exclusionFeature = "" "Optional name of a mutual excluded feature";

end FeaturePlace;
