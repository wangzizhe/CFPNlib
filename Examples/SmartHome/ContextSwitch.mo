within CFPNlib.Examples.SmartHome;
model ContextSwitch
  import CFPNlib.Components.ContextPN.ContextPlace;
  import CFPNlib.Components.ContextPN.ContextTransitionTimeEvent;
  
  // User-defined parameters
  parameter Integer numCycles = 100 "Maximum number of day-night cycles to simulate";
  parameter Real dayLength = 86400 "Length of a full day in seconds (24 hours)";
  parameter Real dayStartTime = 21600 "Time for activating Day Mode (6 AM)";
  parameter Real eveningStartTime = 64800 "Time for activating Evening Mode (6 PM)";
  parameter Real nightStartTime = 79200 "Time for activating Night Mode (10 PM)";
  
  // Generate repeating daily events for day and night mode activation
  parameter Real activateDayTimes[:] = {dayStartTime + i * dayLength for i in 0:numCycles-1} "Daily events for activating Day Mode";
  parameter Real activateEveningTimes[:] = {eveningStartTime + i * dayLength for i in 0:numCycles-1} "Daily events for activating Evening Mode";
  parameter Real activateNightTimes[:] = {nightStartTime + i * dayLength for i in 0:numCycles-1} "Daily events for activating Night Mode";

  // Define Contexts
  ContextPlace dayMode(contextName = "DayMode", startTokens = 0, nIn = 1, nOut = 1);
  ContextPlace eveningMode(contextName = "EveningMode", startTokens = 0, nIn = 1, nOut = 1);
  ContextPlace nightMode(contextName = "NightMode", startTokens = 1, nIn = 1, nOut = 1);

  // Define Transitions
  ContextTransitionTimeEvent activateDay(targetContext = "DayMode", nIn = 1, nOut = 1, event = activateDayTimes);
  ContextTransitionTimeEvent activateEvening(targetContext = "EveningMode", nIn = 1, nOut = 1, event = activateEveningTimes);
  ContextTransitionTimeEvent activateNight(targetContext = "NightMode", nIn = 1, nOut = 1, event = activateNightTimes);

  // Outputs for context states
  output Boolean isDay = dayMode.t > 0;
  output Boolean isEvening = eveningMode.t > 0;
  output Boolean isNight = nightMode.t > 0;

equation
  // Connect transitions to manage states
  connect(activateDay.outPlaces[1], dayMode.inTransition[1]);
  connect(dayMode.outTransition[1], activateEvening.inPlaces[1]);
  connect(activateEvening.outPlaces[1], eveningMode.inTransition[1]);
  connect(eveningMode.outTransition[1], activateNight.inPlaces[1]);
  connect(activateNight.outPlaces[1], nightMode.inTransition[1]);
  connect(nightMode.outTransition[1], activateDay.inPlaces[1]);

  annotation (
    uses(PNlib(version = "3.0.0"), Modelica(version = "4.0.0")));
end ContextSwitch;
