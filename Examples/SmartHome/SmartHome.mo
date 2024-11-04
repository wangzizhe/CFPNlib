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
  // Connect context state outputs from ContextSwitch to feature models
  lightModel.isDay = contextSwitch.isDay;
  lightModel.isEvening = contextSwitch.isEvening;
  lightModel.isNight = contextSwitch.isNight;

  heatingModel.isDay = contextSwitch.isDay;
  heatingModel.isEvening = contextSwitch.isEvening;
  heatingModel.isNight = contextSwitch.isNight;

  securityModel.isNight = contextSwitch.isNight;

  annotation (
    uses(PNlib(version = "3.0.0"), Modelica(version = "4.0.0"))
  );
end SmartHome;
