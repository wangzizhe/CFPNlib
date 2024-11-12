within CFPNlib.Components.Composite;

model FeatureWithConditionEvent
  import CFPNlib.Components.FeaturePN.FeaturePlace;
  import CFPNlib.Components.FeaturePN.FeatureTransitionConditionEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter String featureName = "DefaultFeature" "Name of the feature";
  parameter String parentFeature = "" "Name of the parent feature (optional, empty if none)";
  parameter Integer startTokens = 0 "Initial token count for feature state";
  input Boolean activationCondition(start = false) "Condition to activate this feature";
  input Boolean parentActive = true "Indicates if the parent feature is active, defaults to true if no parent context";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  // Feature state and transitions
  FeaturePlace featureState(
    featureName = featureName,
    parentFeature = if parentFeature == "" then "" else parentFeature,
    startTokens = startTokens, 
    nIn = 1, 
    nOut = 1
  ) "Represents if feature is active";
  
  // Transitions to manage activation and deactivation
  FeatureTransitionConditionEvent activationTransition(
    targetFeature = featureName,
    nOut = 1,
    firingCon = activationCondition and (not (parentFeature == "") or parentActive)
  ) "Transition to activate feature";

  FeatureTransitionConditionEvent deactivationTransition(
    nIn = 1,
    firingCon = not activationCondition
  ) "Transition to deactivate feature";
  
  // Output to indicate if the feature is currently active
  output Boolean isActive = featureState.t > 0;
  
equation
  // Connect transitions to place
  connect(activationTransition.outPlaces[1], featureState.inTransition[1]);
  connect(featureState.outTransition[1], deactivationTransition.inPlaces[1]);

end FeatureWithConditionEvent;
