within ContextVariabilityManager.Examples.GreenIT;
model GreenIT
  import ContextVariabilityManager.Examples.GreenIT.HydrogenGenerator;
  import ContextVariabilityManager.Examples.GreenIT.HydrogenTank;
  import ContextVariabilityManager.Examples.GreenIT.ModularComputer;
  import ContextVariabilityManager.Examples.GreenIT.ContextSwitch;

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
