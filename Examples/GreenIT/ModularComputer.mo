within CFPNlib.Examples.GreenIT;

model ModularComputer "Modular computer system that adjusts power consumption based on context"
  parameter Real maxPowerConsumption = 500 "Maximum power consumption in watts";

  // Outputs
  output Real powerDemand "Actual power consumption based on active context";

  // Context inputs from ContextSwitch
  input Boolean isEnergySaving;
  input Boolean isNormal;
  input Boolean isPerformance;
  
  // Load level inputs within performance mode
  input Boolean isLowLoad;
  input Boolean isMediumLoad;
  input Boolean isHighLoad;

equation
  // Adjust power consumption based on current operational context and load level
  powerDemand = if isEnergySaving then maxPowerConsumption * 0.3
                else if isNormal and isLowLoad then maxPowerConsumption * 0.6
                else if isNormal and isMediumLoad then maxPowerConsumption * 0.7
                else if isNormal and isHighLoad then maxPowerConsumption * 0.85
                else if isPerformance then maxPowerConsumption
                else 0;
end ModularComputer;
