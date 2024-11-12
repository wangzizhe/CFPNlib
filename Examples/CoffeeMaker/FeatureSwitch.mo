within CFPNlib.Examples.CoffeeMaker;

model FeatureSwitch "Coffee maker with mutually exclusive feature states using FeatureWithConditionEvent"
  import CFPNlib.Components.Composite.FeatureWithConditionEvent;

  // User Button Inputs (to be connected externally)
  input Boolean startBrewingButton;
  input Boolean startGrindingButton;
  input Boolean startSteamingButton;

  // Define Brewing Feature as the priority element
  FeatureWithConditionEvent brewing(
    featureName = "Brewing",
    activationCondition = startBrewingButton
  ) "Brewing feature";

  // Define Grinding Feature as a non-priority exclusive element
  FeatureWithConditionEvent grinding(
    featureName = "Grinding",
    activationCondition = startGrindingButton and (not brewing.isActive)  // Grinding can only be activated if Brewing is not active
  ) "Grinding feature";

  // Define Steaming Feature as a non-priority, non-exclusive element
  FeatureWithConditionEvent steaming(
    featureName = "Steaming",
    activationCondition = startSteamingButton and (not brewing.isActive)  // Steaming can only be activated if Brewing is not active
  ) "Steaming feature";

  // Output flags for each feature
  output Boolean brewingIsActive = brewing.isActive;
  output Boolean grindingIsActive = grinding.isActive;
  output Boolean steamingIsActive = steaming.isActive;

end FeatureSwitch;
