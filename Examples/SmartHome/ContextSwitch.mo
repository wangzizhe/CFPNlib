within CFPNlib.Examples.SmartHome;

model ContextSwitch "SmartHome context switch with encapsulated contexts"
  import CFPNlib.Components.Composite.ContextWithTimeEvent;

  // User-defined parameters
  parameter Integer numCycles = 100 "Maximum number of day-night cycles to simulate";
  parameter Real dayLength = 86400 "Length of a full day in seconds (24 hours)";
  parameter Real dayStartTime = 21600 "Time for activating Day Mode (6 AM)";
  parameter Real eveningStartTime = 64800 "Time for activating Evening Mode (6 PM)";
  parameter Real nightStartTime = 79200 "Time for activating Night Mode (10 PM)";

  // Generate repeating daily events for day, evening, and night mode activation
  parameter Real activateDayTimes[:] = {dayStartTime + i * dayLength for i in 0:numCycles-1} "Daily events for activating Day Mode";
  parameter Real activateEveningTimes[:] = {eveningStartTime + i * dayLength for i in 0:numCycles-1} "Daily events for activating Evening Mode";
  parameter Real activateNightTimes[:] = {nightStartTime + i * dayLength for i in 0:numCycles-1} "Daily events for activating Night Mode";

  // Encapsulated Contexts for each mode
  ContextWithTimeEvent dayMode(
    startTokens = 0,
    activationTimes = activateDayTimes,
    deactivationTimes = activateEveningTimes
  ) "Context for Day Mode";

  ContextWithTimeEvent eveningMode(
    startTokens = 0,
    activationTimes = activateEveningTimes,
    deactivationTimes = activateNightTimes
  ) "Context for Evening Mode";

  ContextWithTimeEvent nightMode(
    startTokens = 1,
    activationTimes = activateNightTimes,
    deactivationTimes = activateDayTimes
  ) "Context for Night Mode";

  //Outputs to set each feature model's state based on the context
  output Real V_input;
  output Real heatPower_input;
  output Boolean securityActive_input;

equation
  // Set V_input for LightModel based on active context
  V_input = if dayMode.isActive then 5.0
            else if eveningMode.isActive then 2.5
            else 0.0;

  // Set heatPower_input for HeatingModel based on active context
  heatPower_input = if eveningMode.isActive or nightMode.isActive then 10.0 else 0.0;

  // Set securityActive_input for SecurityModel based on active context
  securityActive_input = nightMode.isActive;

end ContextSwitch;
