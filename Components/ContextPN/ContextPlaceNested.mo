within CFPNlib.Components.ContextPN;

model ContextPlaceNested "Place representing a context with nested context support"
  // Discrete Place
  extends CFPNlib.Components.CFPNCore.DiscretePlace;

  // Parameters
  parameter String contextName = "DefaultContext" "The name of the context";
  parameter String parentContext = "" "Optional name of the parent context";
  parameter String exclusionContexts[:] = {"Default"} "List of contexts that cannot be active simultaneously with this context";

  // State Variables
  discrete Boolean parentActive "State of the parent context (true if no parent)";

  // Helper function to check if a context is active based on `t > 0`
  function isContextActive
    input String otherContextName;
    output Boolean result;
  algorithm 
    result := false; // Placeholder for central context tracking logic
  end isContextActive;

equation 
  // Set `parentActive` only if a parent context is defined
  if parentContext <> "" then
    parentActive = isContextActive(parentContext);
  else
    parentActive = true; // Default to true if no parent context
  end if;

  // Exclusion rule: Ensure this context cannot be active with excluded contexts
  for i in 1:size(exclusionContexts, 1) loop
    if exclusionContexts[i] <> "" then
      assert(not ((t > 0) and isContextActive(exclusionContexts[i])),
             "Context '" + contextName + "' cannot be active simultaneously with '" + exclusionContexts[i] + "'");
    end if;
  end for;

end ContextPlaceNested;
