within CFPNlib.Components.FeaturePN;

model FeatureTransitionConditionEvent "Transition to handle feature state changes"
  // Discrete Transition with condition-based event
  extends CFPNlib.Components.CFPNCore.ConditionEventTransition;

  // Parameters
  parameter String targetFeature = "DefaultFeature" "The target feature this transition manages";

end FeatureTransitionConditionEvent;
