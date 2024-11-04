within CFPNlib.Examples.CoffeeMaker;

model FeatureSwitch "Coffee maker with mutually exclusive feature states"
  import CFPNlib.Components.FeaturePN.FeaturePlace;
  import CFPNlib.Components.FeaturePN.FeatureTransitionConditionEvent;

  // User Button Inputs (to be connected externally)
  input Boolean startBrewingButton;
  input Boolean startGrindingButton;
  input Boolean startSteamingButton;

  // Feature Places representing coffee maker states
  FeaturePlace brewing(featureName = "Brewing", startTokens = 0, nIn = 1) "Brewing state";
  FeaturePlace grinding(featureName = "Grinding", startTokens = 0, nIn = 1) "Grinding state";
  FeaturePlace steaming(featureName = "Steaming", startTokens = 0, nIn = 1) "Steaming state";

  // Feature Transitions with mutually exclusive firing conditions
  FeatureTransitionConditionEvent startBrewing(
    targetFeature = "Brewing", 
    nOut = 1, 
    firingCon = startBrewingButton and not pre(startGrinding.active) and not pre(startSteaming.active)) 
    "Start brewing transition";

FeatureTransitionConditionEvent startGrinding(
    targetFeature = "Grinding", 
    nOut = 1, 
    firingCon = startGrindingButton and not pre(startBrewing.active) and not pre(startSteaming.active)) 
    "Start grinding transition";

FeatureTransitionConditionEvent startSteaming(
    targetFeature = "Steaming", 
    nOut = 1, 
    firingCon = startSteamingButton and not pre(startBrewing.active) and not pre(startGrinding.active)) 
    "Start steaming transition";

equation
  // Connect transitions to their respective places
  connect(startBrewing.outPlaces[1], brewing.inTransition[1]);
  connect(startGrinding.outPlaces[1], grinding.inTransition[1]);
  connect(startSteaming.outPlaces[1], steaming.inTransition[1]);

end FeatureSwitch;
