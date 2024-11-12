within CFPNlib.Components.Composite;

model ContextWithConditionEvent
  import CFPNlib.Components.ContextPN.ContextPlace;
  import CFPNlib.Components.ContextPN.ContextTransitionConditionEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter String contextName = "DefaultContext" "Name of the nested context";
  parameter String parentContext = "" "Name of the parent context (optional, empty if none)";
  parameter Integer startTokens = 0 "Initial token count for context state";
  input Boolean activationCondition(start = false) "Condition to activate this context";
  input Boolean parentActive = true "Indicates if the parent context is active, defaults to true if no parent context";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  // Define the nested context place with exclusion and nesting settings
  ContextPlace contextState(
    contextName = contextName,
    parentContext = if parentContext == "" then "" else parentContext,
    startTokens = startTokens,
    nIn = 1,
    nOut = 1
  ) "Nested context place indicating active state";

  // Define transitions for activation and deactivation based on conditions
  ContextTransitionConditionEvent activateTransition(
    targetContext = contextName,
    nOut = 1,
    firingCon = activationCondition and (not (parentContext == "") or parentActive)
  ) "Transition to activate context when activationCondition is met and parent is active (if applicable)";

  ContextTransitionConditionEvent deactivateTransition(
    targetContext = contextName,
    nIn = 1,
    firingCon = not activationCondition or (not (parentContext == "") and not parentActive)
  ) "Transition to deactivate context when deactivationCondition or parent deactivation is met";

  // Output to indicate if the context is currently active
  output Boolean isActive = contextState.t > 0;

equation
  // Connect transitions to manage the state of the context
  connect(activateTransition.outPlaces[1], contextState.inTransition[1]);
  connect(contextState.outTransition[1], deactivateTransition.inPlaces[1]);

end ContextWithConditionEvent;
