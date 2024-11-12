within CFPNlib.Examples.SmartHome;

model LightModel "Light system with context-based intensity controlled externally"
  Real V "Voltage representing light intensity";

  // Direct input for light intensity
  input Real V_input "Light intensity set externally";

equation
  // Directly assign the input to the output voltage
  V = V_input;
  
end LightModel;
