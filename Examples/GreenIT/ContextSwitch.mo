within CFPNlib.Examples.GreenIT;

model ContextSwitch "Context management for GreenIT system with nested load levels"
  import CFPNlib.Components.ContextPN.ContextPlaceNested;
  import CFPNlib.Components.ContextPN.ContextTransitionConditionEvent;

  // Inputs
  input Real hydrogenLevel "Current hydrogen level from HydrogenTank";

  // Define Context Places for Energy Modes
  ContextPlaceNested energySavingMode(
    contextName = "EnergySavingMode", 
    startTokens = 0, 
    nIn = 1, 
    exclusionContexts = {"NormalMode", "PerformanceMode"}
  );
  ContextPlaceNested normalMode(
    contextName = "NormalMode", 
    startTokens = 0, 
    nIn = 1, 
    exclusionContexts = {"EnergySavingMode", "PerformanceMode"}
  );
  ContextPlaceNested performanceMode(
    contextName = "PerformanceMode", 
    startTokens = 0, 
    nIn = 1, 
    exclusionContexts = {"EnergySavingMode", "NormalMode"}
  );
  
  // Define Transitions between Contexts based on Hydrogen Level
  ContextTransitionConditionEvent activateEnergySavingMode(
    targetContext = "EnergySavingMode", 
    nOut = 1,
    firingCon = hydrogenLevel < 20.0);

  ContextTransitionConditionEvent activateNormalMode(
    targetContext = "NormalMode", 
    nOut = 1,
    firingCon = hydrogenLevel >= 20.0 and hydrogenLevel < 80.0);

  ContextTransitionConditionEvent activatePerformanceMode(
    targetContext = "PerformanceMode", 
    nOut = 1,
    firingCon = hydrogenLevel >= 80.0);

  // Load level management within Performance Mode
  ContextPlaceNested lowLoad(contextName = "LowLoad", startTokens = 0, parentContext = "NormalMode", nIn = 1);
  ContextPlaceNested mediumLoad(contextName = "MediumLoad", startTokens = 0, parentContext = "NormalMode", nIn = 1);
  ContextPlaceNested highLoad(contextName = "HighLoad", startTokens = 0, parentContext = "NormalMode", nIn = 1);

  // Transitions for Load Levels
  ContextTransitionConditionEvent activateLowLoad(
    targetContext = "LowLoad", 
    nOut = 1,
    firingCon = hydrogenLevel >= 20.0 and hydrogenLevel < 40.0);

  ContextTransitionConditionEvent activateMediumLoad(
    targetContext = "MediumLoad", 
    nOut = 1,
    firingCon = hydrogenLevel >= 40.0 and hydrogenLevel < 60.0);

  ContextTransitionConditionEvent activateHighLoad(
    targetContext = "HighLoad", 
    nOut = 1,
    firingCon = hydrogenLevel >= 60.0 and hydrogenLevel < 80.0);

  // Outputs for current context states
  output Boolean isEnergySaving = activateEnergySavingMode.active;
  output Boolean isNormal = activateNormalMode.active;
  output Boolean isPerformance = activatePerformanceMode.active;
  output Boolean isLowLoad = activateLowLoad.active;
  output Boolean isMediumLoad = activateMediumLoad.active;
  output Boolean isHighLoad = activateHighLoad.active;

equation
  // Connections for activating EnergySavingMode, NormalMode, PerformanceMode
  connect(activateEnergySavingMode.outPlaces[1], energySavingMode.inTransition[1]);
  connect(activateNormalMode.outPlaces[1], normalMode.inTransition[1]);
  connect(activatePerformanceMode.outPlaces[1], performanceMode.inTransition[1]);

  // Connections for nested load levels within NormalMode (Low, Medium, High)
  connect(activateLowLoad.outPlaces[1], lowLoad.inTransition[1]);
  connect(activateMediumLoad.outPlaces[1], mediumLoad.inTransition[1]);
  connect(activateHighLoad.outPlaces[1], highLoad.inTransition[1]);

end ContextSwitch;
