within CFPNlib.Examples.GreenIT;

model ContextSwitch "Context management for GreenIT system with nested load levels"
  import CFPNlib.Components.Composite.ContextWithConditionEvent;

  // Input the hydrogen level from HydrogenTank
  input Real hydrogenLevel "Current hydrogen level from HydrogenTank";
  // Output the power demand factor for ModularComputer
  output Real powerDemandFactor;

  // Define Contexts for Energy Modes
  ContextWithConditionEvent energySavingMode(
    contextName = "EnergySavingMode", 
    activationCondition = (hydrogenLevel < 20.0)
  ) "Energy-saving mode for low hydrogen levels";

  ContextWithConditionEvent normalMode(
    contextName = "NormalMode", 
    activationCondition = (hydrogenLevel >= 20.0 and hydrogenLevel < 80.0)
  ) "Normal operation mode for moderate hydrogen levels";

  ContextWithConditionEvent performanceMode(
    contextName = "PerformanceMode", 
    activationCondition = (hydrogenLevel >= 80.0)
  ) "High-performance mode for high hydrogen levels";

  // Nested Load Levels within Normal Mode
  ContextWithConditionEvent lowLoad(
    contextName = "LowLoad", 
    parentContext = "NormalMode", 
    activationCondition = (hydrogenLevel >= 20.0 and hydrogenLevel < 40.0)
  ) "Low load mode within NormalMode";

  ContextWithConditionEvent mediumLoad(
    contextName = "MediumLoad", 
    parentContext = "NormalMode", 
    activationCondition = (hydrogenLevel >= 40.0 and hydrogenLevel < 60.0)
  ) "Medium load mode within NormalMode";

  ContextWithConditionEvent highLoad(
    contextName = "HighLoad", 
    parentContext = "NormalMode", 
    activationCondition = (hydrogenLevel >= 60.0 and hydrogenLevel < 80.0)
  ) "High load mode within NormalMode";

equation
  // Define powerDemandFactor based on active context states
  powerDemandFactor = if energySavingMode.isActive then 0.3
                      else if performanceMode.isActive then 1.0
                      else if lowLoad.isActive then 0.6
                      else if mediumLoad.isActive then 0.7
                      else if highLoad.isActive then 0.85
                      else 0.0;

end ContextSwitch;
