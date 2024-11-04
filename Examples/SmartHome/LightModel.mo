within CFPNlib.Examples.SmartHome;
model LightModel
  // Define Parameters for light intensity
  parameter Real Vday = 5 "Maximum Voltage during the Day Mode representing full light intensity";
  parameter Real Vevening = 2.5 "Reduced Voltage in Evening Mode representing dimmed light";
  parameter Real Vnight = 0 "Voltage during Night Mode representing light off";

  // Voltage across the capacitor representing light intensity
  Real V "Voltage representing light intensity";

  // External inputs for context states
  input Boolean isDay;
  input Boolean isEvening;
  input Boolean isNight;

equation
  // Control voltage based on context
  V = if isDay then Vday
    else if isEvening then Vevening
    else Vnight;

  annotation (
    uses(PNlib(version = "3.0.0"), Modelica(version = "4.0.0")));
end LightModel;
