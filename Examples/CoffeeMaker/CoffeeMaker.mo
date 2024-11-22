within ContextVariabilityManager.Examples.CoffeeMaker;
model CoffeeMaker "Coffee maker system integrating user actions and feature states with FeatureWithConditionEvent"
  import ContextVariabilityManager.Examples.CoffeeMaker.UserAction;
  import ContextVariabilityManager.Examples.CoffeeMaker.FeatureSwitch;

  UserAction userAction "Simulates user button presses for each feature";
  FeatureSwitch featureSwitch "Feature management using FeatureWithConditionEvent";

equation
  featureSwitch.startBrewingButton = userAction.startBrewingButton;
  featureSwitch.startGrindingButton = userAction.startGrindingButton;
  featureSwitch.startSteamingButton = userAction.startSteamingButton;

end CoffeeMaker;
