within CFPNlib.Examples.SmartHome;

model SmartHome
  import CFPNlib.Examples.SmartHome.LightModel;
  import CFPNlib.Examples.SmartHome.HeatingModel;
  import CFPNlib.Examples.SmartHome.SecurityModel;
  import CFPNlib.Examples.SmartHome.ContextSwitch;

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
