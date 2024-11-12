within CFPNlib.Examples.GreenIT;

model GreenIT
  import CFPNlib.Examples.GreenIT.HydrogenGenerator;
  import CFPNlib.Examples.GreenIT.HydrogenTank;
  import CFPNlib.Examples.GreenIT.ModularComputer;
  import CFPNlib.Examples.GreenIT.ContextSwitch;

  // Instantiate components
  HydrogenGenerator hydrogenGenerator;
  HydrogenTank hydrogenTank;
  ModularComputer modularComputer;
  ContextSwitch contextSwitch;

equation
  // Connect hydrogen production from generator to tank
  hydrogenTank.hydrogenProduction = hydrogenGenerator.hydrogenProduction;

  // Connect hydrogen level from tank to context switch
  contextSwitch.hydrogenLevel = hydrogenTank.hydrogenLevel;

  // Connect power demand factor from context switch to modular computer
  modularComputer.powerDemandFactor = contextSwitch.powerDemandFactor;

end GreenIT;
