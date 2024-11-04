within CFPNlib.Components.FeaturePN;

model FeaturePlaceNested "Place representing a nested feature with support for parent and exclusion features"
  extends CFPNlib.Components.FeaturePN.FeaturePlace;

  // Parameters
  parameter String parentFeature = "" "Optional name of the parent feature, if any";
  parameter String exclusionFeatures[:] = {"Default"} "List of features that cannot be active simultaneously with this feature";

  // State Variables
  discrete Boolean parentActive "Indicates if the parent feature is active";

  // Helper function to check if another feature is active (similar to `isContextActive` in `ContextPlaceNested`)
  function isFeatureActive
    input String otherFeatureName;
    output Boolean result;
  algorithm 
    result := false; // Placeholder: Implement actual feature activity tracking here
  end isFeatureActive;

equation 
  // Set `parentActive` only if a parent feature is defined
  if parentFeature <> "" then
    parentActive = isFeatureActive(parentFeature);
  else
    parentActive = true; // Default to true if no parent feature
  end if;

  // Exclusion rule: Ensure this feature cannot be active with excluded features
  for i in 1:size(exclusionFeatures, 1) loop
    if exclusionFeatures[i] <> "" then
      assert(not ((t > 0) and isFeatureActive(exclusionFeatures[i])),
             "Feature '" + featureName + "' cannot be active simultaneously with '" + exclusionFeatures[i] + "'");
    end if;
  end for;

end FeaturePlaceNested;
