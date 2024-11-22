within ContextVariabilityManager.Components.Composite;
model FeatureWithTimeEvent
  import ContextVariabilityManager.Components.FeaturePN.FeaturePlace;
  import ContextVariabilityManager.Components.FeaturePN.FeatureTransitionTimeEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Integer startTokens = 0 "Initial token count for feature state";
  parameter Real[:] activationTimes "Array of times to activate this feature";
  parameter Real[:] deactivationTimes "Array of times to deactivate this feature";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  // Feature state and transitions
  FeaturePlace featureState(
    startTokens = startTokens,
    nIn = 1,
    nOut = 1)
    "Feature place indicating active state";

  // Activation and deactivation transitions with exclusive conditions
  FeatureTransitionTimeEvent activateTransition(
    nOut = 1,
    event = activationTimes)
    "Transition to activate feature at specified times";

  FeatureTransitionTimeEvent deactivateTransition(
    nIn = 1,
    event = deactivationTimes)
    "Transition to deactivate feature at specified times";

  // Output to indicate if the feature is currently active
  output Boolean isActive = featureState.t > 0;

equation
  // Connect transitions to place
  connect(activateTransition.outPlaces[1], featureState.inTransition[1]);
  connect(featureState.outTransition[1], deactivateTransition.inPlaces[1]);

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
          extent={{-48,112},{52,50}},
          textColor={0,0,0},
          textString="TimeFeature"),                                                                                                                                         Text(extent={{0.5,23.5},{0.5,-23.5}},        lineColor = {0, 0, 0}, textString = DynamicSelect("%startTokens", if animateMarking then String(t) else " "))}));
end FeatureWithTimeEvent;
