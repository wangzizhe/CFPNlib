within CFPNlib.Components.FeaturePN;
model FeaturePlace "Place representing features using tokens"
  // Discrete Place
  extends CFPNlib.Components.CFPNCore.DiscretePlace;

  // Additional Parameters or Attributes specific to FeaturePlace
  parameter String featureName = "DefaultFeature";

end FeaturePlace;
