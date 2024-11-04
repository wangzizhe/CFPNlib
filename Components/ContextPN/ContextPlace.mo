within CFPNlib.Components.ContextPN;
model ContextPlace "Place representing a context"
  // Discrete Place
  extends CFPNlib.Components.CFPNCore.DiscretePlace;

  // Parameters
  parameter String contextName = "DefaultContext" "The name of the context";

end ContextPlace;
