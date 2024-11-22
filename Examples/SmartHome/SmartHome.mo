within ContextVariabilityManager.Examples.SmartHome;
model SmartHome
  import ContextVariabilityManager.Examples.SmartHome.LightModel;
  import ContextVariabilityManager.Examples.SmartHome.HeatingModel;
  import ContextVariabilityManager.Examples.SmartHome.SecurityModel;
  import ContextVariabilityManager.Examples.SmartHome.ContextSwitch;

  // Instantiate feature models and context switch
  LightModel lightModel;
  HeatingModel heatingModel;
  SecurityModel securityModel;
  ContextSwitch contextSwitch;

equation
  // Connect contextSwitch outputs directly to feature model inputs
  lightModel.V_input = contextSwitch.V_input;
  heatingModel.heatPower_input = contextSwitch.heatPower_input;
  securityModel.securityActive_input = contextSwitch.securityActive_input;

end SmartHome;
