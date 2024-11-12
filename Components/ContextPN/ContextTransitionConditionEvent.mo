within CFPNlib.Components.ContextPN;

model ContextTransitionConditionEvent "Transition to handle context activation and deactivation"
  // Discrete Transition with condition-based event
  extends CFPNlib.Components.CFPNCore.ConditionEventTransition;

  // Parameters
  parameter String targetContext = "DefaultContext" "The target context this transition manages";

end ContextTransitionConditionEvent;
