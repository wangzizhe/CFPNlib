within CFPNlib.Examples.GreenIT;

model ModularComputer "Modular computer system that adjusts power consumption based on context"
  parameter Real maxPowerConsumption = 500 "Maximum power consumption in watts";
  input Real powerDemandFactor "Power demand factor calculated in ContextSwitch";
  output Real powerDemand "Actual power consumption based on active context";

equation
  // Adjust power consumption based on current operational context and load level
  powerDemand = maxPowerConsumption * powerDemandFactor;

end ModularComputer;
