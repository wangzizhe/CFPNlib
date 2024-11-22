within ContextVariabilityManager.Examples.CoffeeMaker;
model FeatureSwitch "Coffee maker with mutually exclusive feature states using FeatureWithConditionEvent"
  import ContextVariabilityManager.Components.Composite.FeatureWithConditionEvent;

  // User Button Inputs (to be connected externally)
  input Boolean startBrewingButton;
  input Boolean startGrindingButton;
  input Boolean startSteamingButton;

  // Define Brewing Feature as the priority element
  FeatureWithConditionEvent brewing(
    activationCondition = startBrewingButton)
    "Brewing feature";

  // Define Grinding Feature as a non-priority exclusive element (Grinding can only be activated if Brewing is not active)
  FeatureWithConditionEvent grinding(
    activationCondition = startGrindingButton and (not brewing.isActive))
    "Grinding feature";

  // Define Steaming Feature as a non-priority, non-exclusive element (Steaming can only be activated if Brewing is not active)
  FeatureWithConditionEvent steaming(
    activationCondition = startSteamingButton and (not brewing.isActive))
    "Steaming feature";

end FeatureSwitch;
