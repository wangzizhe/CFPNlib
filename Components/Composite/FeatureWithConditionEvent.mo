within ContextVariabilityManager.Components.Composite;
model FeatureWithConditionEvent
  import ContextVariabilityManager.Components.FeaturePN.FeaturePlace;
  import ContextVariabilityManager.Components.FeaturePN.FeatureTransitionConditionEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter String parentFeature = "" "Optional name of the parent feature";
  parameter String weakInclusionFeature = "" "Optional name of a weakly included feature";
  parameter String strongInclusionFeature = "" "Optional name of a strongly included feature";
  parameter String exclusionFeature = "" "Optional name of a mutual excluded feature";
  parameter Integer startTokens = 0 "Initial token count for feature state";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  input Boolean activationCondition(start = false) "Condition to activate this feature";
  output Boolean isActive = featureState.t > 0 "Output to indicate if the feature is currently active";

  // Feature state and transitions
  FeaturePlace featureState(
    parentFeature = parentFeature,
    weakInclusionFeature = weakInclusionFeature,
    strongInclusionFeature = strongInclusionFeature,
    startTokens = startTokens,
    nIn = 1,
    nOut = 1)
    "Feature place indicating active state";

  // Transitions to manage activation and deactivation
  FeatureTransitionConditionEvent activationTransition(
    nOut = 1,
    firingCon = activationCondition)
    "Transition to activate feature";

  FeatureTransitionConditionEvent deactivationTransition(
    nIn = 1,
    firingCon = not activationCondition)
    "Transition to deactivate feature";

equation
  // Connect transitions to place
  connect(activationTransition.outPlaces[1], featureState.inTransition[1]);
  connect(featureState.outTransition[1], deactivationTransition.inPlaces[1]);

  annotation (Icon(graphics={
        Ellipse(extent={{-60,60},{60,-60}}, lineColor={0,0,0}),
        Rectangle(
          extent={{-100,60},{-80,-60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,60},{100,-60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,0},{-60,0}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{60,0},{80,0}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-52,112},{48,50}},
          textColor={0,0,0},
          textString="ConditionFeature"),                                                                                                                                    Text(extent={{0.5,23.5},{0.5,-23.5}},        lineColor = {0, 0, 0}, textString = DynamicSelect("%startTokens", if animateMarking then String(t) else " "))}));
end FeatureWithConditionEvent;
