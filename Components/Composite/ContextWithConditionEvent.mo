within ContextVariabilityManager.Components.Composite;
model ContextWithConditionEvent
  import ContextVariabilityManager.Components.ContextPN.ContextPlace;
  import ContextVariabilityManager.Components.ContextPN.ContextTransitionConditionEvent;

  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter String parentContext = "" "Optional name of the parent context";
  parameter String weakInclusionContext = "" "Optional name of a weakly included context";
  parameter String strongInclusionContext = "" "Optional name of a weakly included context";
  parameter String exclusionContext = "" "Optional name of a mutual excluded context";
  parameter Integer startTokens = 0 "Initial token count for context state";
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  input Boolean activationCondition(start = false) "Condition to activate this context";
  output Boolean isActive = contextState.t > 0 "Output to indicate if the context is currently active";

  // Define the nested context place with exclusion and nesting settings
  ContextPlace contextState(
    parentContext = parentContext,
    weakInclusionContext = weakInclusionContext,
    strongInclusionContext = strongInclusionContext,
    startTokens = startTokens,
    nIn = 1,
    nOut = 1)
    "Context place indicating active state";

  // Define transitions for activation and deactivation based on conditions
  ContextTransitionConditionEvent activateTransition(
    nOut = 1,
    firingCon = activationCondition)
    "Transition to activate context";

  ContextTransitionConditionEvent deactivateTransition(
    nIn = 1,
    firingCon = not activationCondition)
    "Transition to deactivate context";

equation
  // Connect transitions to manage the state of the context
  connect(activateTransition.outPlaces[1], contextState.inTransition[1]);
  connect(contextState.outTransition[1], deactivateTransition.inPlaces[1]);

  annotation (Diagram(graphics={
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
          extent={{-50,32},{50,-30}},
          textColor={0,0,0},
          textString="ContextWithConditionEvent")}), Icon(graphics={
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
          textString="ConditionContext"),                                                                                                                                    Text(extent={{0.5,23.5},{0.5,-23.5}},        lineColor = {0, 0, 0}, textString = DynamicSelect("%startTokens", if animateMarking then String(t) else " "))}));
end ContextWithConditionEvent;
