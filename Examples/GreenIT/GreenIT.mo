within CFPNlib.Examples.GreenIT;

model GreenIT "GreenIT system with context switching and hydrogen-based power storage"
  import CFPNlib.Examples.GreenIT.*;

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

  // Set computer operational modes based on context states from ContextSwitch
  modularComputer.isEnergySaving = contextSwitch.isEnergySaving;
  modularComputer.isNormal = contextSwitch.isNormal;
  modularComputer.isPerformance = contextSwitch.isPerformance;
  modularComputer.isLowLoad = contextSwitch.isLowLoad;
  modularComputer.isMediumLoad = contextSwitch.isMediumLoad;
  modularComputer.isHighLoad = contextSwitch.isHighLoad;

end GreenIT;
