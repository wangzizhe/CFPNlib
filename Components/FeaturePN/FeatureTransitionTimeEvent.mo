within CFPNlib.Components.FeaturePN;
model FeatureTransitionTimeEvent "Transition to handle feature state changes"
  // Discrete Transition with time-based event
  extends CFPNlib.Components.CFPNCore.TimeEventTransition;

  // Parameters
  parameter String targetFeature = "DefaultFeature" "The target feature this transition manages";

end FeatureTransitionTimeEvent;
