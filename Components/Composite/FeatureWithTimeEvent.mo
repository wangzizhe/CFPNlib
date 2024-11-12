within CFPNlib.Components.Composite;

model FeatureWithTimeEvent
  import CFPNlib.Components.FeaturePN.FeaturePlace;
  import CFPNlib.Components.FeaturePN.FeatureTransitionTimeEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter String featureName = "DefaultFeature" "Name of the feature";
  parameter String parentFeature = "" "Optional name of the parent feature";
  parameter Integer startTokens = 0 "Initial token count for feature state";
  parameter Real[:] activationTimes "Array of times to activate this feature";
  parameter Real[:] deactivationTimes "Array of times to deactivate this feature";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  // Feature state and transitions
  FeaturePlace featureState(
    featureName = featureName,
    parentFeature = parentFeature,
    startTokens = startTokens,
    nIn = 1,
    nOut = 1
  ) "Represents if feature is active";

  // Activation and deactivation transitions with exclusive conditions
  FeatureTransitionTimeEvent activateTransition(
    targetFeature = featureName,
    nOut = 1,
    event = activationTimes
  ) "Transition to activate feature at specified times, if no exclusions are active";

  FeatureTransitionTimeEvent deactivateTransition(
    targetFeature = featureName,
    nIn = 1,
    event = deactivationTimes
  ) "Transition to deactivate feature at specified times";

  // Output to indicate if the feature is currently active
  output Boolean isActive = featureState.t > 0;

equation
  // Connect transitions to place
  connect(activateTransition.outPlaces[1], featureState.inTransition[1]);
  connect(featureState.outTransition[1], deactivateTransition.inPlaces[1]);

end FeatureWithTimeEvent;
