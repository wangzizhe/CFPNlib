within CFPNlib.Components.Composite;

model ContextWithTimeEvent
  import CFPNlib.Components.ContextPN.ContextPlace;
  import CFPNlib.Components.ContextPN.ContextTransitionTimeEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter String contextName = "DefaultContext" "Name of the context";
  parameter String parentContext = "" "Name of the parent context (optional)";
  parameter Integer startTokens = 0 "Initial token count for context state";
  parameter Real[:] activationTimes "Array of times to activate this context";
  parameter Real[:] deactivationTimes "Array of times to deactivate this context";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  // Define the nested context place with exclusion and nesting settings
  ContextPlace contextState(
    contextName = contextName,
    parentContext = parentContext,
    startTokens = startTokens,
    nIn = 1,
    nOut = 1
  ) "Nested context place indicating active state";

  // Define transitions for activation and deactivation based on specified times
  ContextTransitionTimeEvent activateTransition(
    targetContext = contextName,
    nOut = 1,
    event = activationTimes
  ) "Transition to activate context at specified times";

  ContextTransitionTimeEvent deactivateTransition(
    targetContext = contextName,
    nIn = 1,
    event = deactivationTimes
  ) "Transition to deactivate context at specified times";

  // Output to indicate if the context is currently active
  output Boolean isActive = contextState.t > 0;

equation
  // Connect transitions to manage the state of the context
  connect(activateTransition.outPlaces[1], contextState.inTransition[1]);
  connect(contextState.outTransition[1], deactivateTransition.inPlaces[1]);

end ContextWithTimeEvent;
