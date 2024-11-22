within ContextVariabilityManager.Examples.GreenIT;
model ContextSwitch "Context management for GreenIT system with nested load levels"
  import ContextVariabilityManager.Components.Composite.ContextWithConditionEvent;

  // Input the hydrogen level from HydrogenTank
  input Real hydrogenLevel "Current hydrogen level from HydrogenTank";
  // Output the power demand factor for ModularComputer
  output Real powerDemandFactor;

  // Define Contexts for operation modes
  ContextWithConditionEvent energySavingMode(
    activationCondition = (hydrogenLevel < 20.0))
    "Energy-saving mode for low hydrogen levels";

  ContextWithConditionEvent normalMode(
    activationCondition = (hydrogenLevel >= 20.0 and hydrogenLevel < 80.0))
    "Normal operation mode for moderate hydrogen levels";

  ContextWithConditionEvent performanceMode(
    activationCondition = (hydrogenLevel >= 80.0))
    "High-performance mode for high hydrogen levels";

  // Nested Load Levels within Normal Mode
  ContextWithConditionEvent lowLoad(
    parentContext = "normalMode",
    activationCondition = (hydrogenLevel >= 20.0 and hydrogenLevel < 40.0) and normalMode.isActive)
    "Low load mode within normalMode";

  ContextWithConditionEvent mediumLoad(
    parentContext = "normalMode",
    activationCondition = (hydrogenLevel >= 40.0 and hydrogenLevel < 60.0) and normalMode.isActive)
    "Medium load mode within normalMode";

  ContextWithConditionEvent highLoad(
    parentContext = "normalMode",
    activationCondition = (hydrogenLevel >= 60.0 and hydrogenLevel < 80.0) and normalMode.isActive)
    "High load mode within normalMode";

equation
  // Define powerDemandFactor based on active context states
  powerDemandFactor = if energySavingMode.isActive then 0.3
                      else if performanceMode.isActive then 1.0
                      else if lowLoad.isActive then 0.6
                      else if mediumLoad.isActive then 0.7
                      else if highLoad.isActive then 0.85
                      else 0.0;

  annotation (experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end ContextSwitch;
