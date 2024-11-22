within ContextVariabilityManager.Examples.SmartHome;
model SecurityModel "Security system with context-based activation controlled externally"
  Boolean securityActive "Current state of the security system";

  // Direct input for security activation
  input Boolean securityActive_input "Security activation set externally";

equation
  // Directly assign the input to the output security state
  securityActive = securityActive_input;

end SecurityModel;
