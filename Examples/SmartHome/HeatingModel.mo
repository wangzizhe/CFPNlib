within CFPNlib.Examples.SmartHome;
model HeatingModel
  // Parameters for the Heating system
  parameter Real HeatPowerOn = 10 "Heating power in Watts when active";
  parameter Real HeatPowerOff = 0 "Heating power when off";

  // Heating power output
  Real heatPower "Current power consumption of the heating system";

  // External inputs for context states
  input Boolean isDay;
  input Boolean isEvening;
  input Boolean isNight;

equation
  // Control heating based on context
  heatPower = if isEvening or isNight then HeatPowerOn else HeatPowerOff;

end HeatingModel;
