within CarSharingSystemCaseStudy;

model PeakHoursContextSwitch
  import CFPNlib.Components.Composite.ContextWithTimeEvent;
  import CFPNlib.Components.Composite.ContextWithConditionEvent;
  
  input Real currentNumCars;

  // Morning Peak Times (7 AM to 10 AM)
  parameter Real morningPeakStartTime = 25200 "Start time for Morning Peak Mode (7 AM)";
  parameter Real morningPeakEndTime = 36000 "End time for Morning Peak Mode (10 AM)";
  // Evening Peak Times (5 PM to 8 PM)
  parameter Real eveningPeakStartTime = 61200 "Start time for Evening Peak Mode (5 PM)";
  parameter Real eveningPeakEndTime = 72000 "End time for Evening Peak Mode (8 PM)";

  ContextWithTimeEvent morningPeakMode(
    startTokens = 0,
    activationTimes = {morningPeakStartTime},
    deactivationTimes = {morningPeakEndTime}
  ) "Context for Morning Peak Mode";

  ContextWithTimeEvent eveningPeakMode(
    startTokens = 0,
    activationTimes = {eveningPeakStartTime},
    deactivationTimes = {eveningPeakEndTime}
  ) "Context for Evening Peak Mode";
  
  ContextWithConditionEvent morningCarDispatchMode(
    startTokens = 0,
    parentContext = "morningPeakMode",
    activationCondition = (currentNumCars < 2)
  ) "Condition-based context to increase car availability during Morning Peak Mode"; 
  
  ContextWithConditionEvent eveningCarDispatchMode(
    startTokens = 0,
    parentContext = "eveningPeakMode",
    activationCondition = (currentNumCars < 1)
  ) "Condition-based context to increase car availability Evening Peak Mode";
  
  // Output variable to dynamically adjust based on active context
  output Real carDispatch; 

equation
  // Adjust the car dispatch based on the active peak mode context
  carDispatch = if morningCarDispatchMode.isActive then 2
                  elseif eveningCarDispatchMode.isActive then 1
                  else 0;

end PeakHoursContextSwitch;
