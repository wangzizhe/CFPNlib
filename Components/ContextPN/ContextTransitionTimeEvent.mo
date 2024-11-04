within CFPNlib.Components.ContextPN;
model ContextTransitionTimeEvent "Transition to handle context activation and deactivation"
  // Discrete Transition with time-based event
  extends CFPNlib.Components.CFPNCore.TimeEventTransition;

  // Parameters
  parameter String targetContext = "DefaultContext" "The target context this transition manages";

end ContextTransitionTimeEvent;
