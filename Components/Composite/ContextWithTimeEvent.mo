within ContextVariabilityManager.Components.Composite;
model ContextWithTimeEvent
  import ContextVariabilityManager.Components.ContextPN.ContextPlace;
  import ContextVariabilityManager.Components.ContextPN.ContextTransitionTimeEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Integer startTokens = 0 "Initial token count for context state";
  parameter Real[:] activationTimes "Array of times to activate this context";
  parameter Real[:] deactivationTimes "Array of times to deactivate this context";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  // Define the nested context place with exclusion and nesting settings
  ContextPlace contextState(
    startTokens = startTokens,
    nIn = 1,
    nOut = 1)
    "Context place indicating active state";

  // Define transitions for activation and deactivation based on specified times
  ContextTransitionTimeEvent activateTransition(
    nOut = 1,
    event = activationTimes)
    "Transition to activate context at specified times";

  ContextTransitionTimeEvent deactivateTransition(
    nIn = 1,
    event = deactivationTimes)
    "Transition to deactivate context at specified times";

  // Output to indicate if the context is currently active
  output Boolean isActive = contextState.t > 0;

equation
  // Connect transitions to manage the state of the context
  connect(activateTransition.outPlaces[1], contextState.inTransition[1]);
  connect(contextState.outTransition[1], deactivateTransition.inPlaces[1]);

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
          extent={{-50,112},{50,50}},
          textColor={0,0,0},
          textString="TimeContext"),                                                                                                                                         Text(extent={{0.5,23.5},{0.5,-23.5}},        lineColor = {0, 0, 0}, textString = DynamicSelect("%startTokens", if animateMarking then String(t) else " "))}));
end ContextWithTimeEvent;
