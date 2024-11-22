within ContextVariabilityManager.Examples.SmartHome;
model HeatingModel "Heating system with context-based power controlled externally"
  Real heatPower "Current power consumption of the heating system";

  // Direct input for heating power
  input Real heatPower_input "Heating power set externally";

equation
  // Directly assign the input to the output heating power
  heatPower = heatPower_input;

end HeatingModel;
