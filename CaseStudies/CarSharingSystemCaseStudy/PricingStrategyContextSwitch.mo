within ContextVariabilityManager.CaseStudies.CarSharingSystemCaseStudy;
model PricingStrategyContextSwitch
  import ContextVariabilityManager.Components.Composite.ContextWithConditionEvent;

  input Real currentNumUsers;

  // Parameters defining the demand thresholds for switching pricing strategies
  parameter Integer highDemandThreshold = 8 "Threshold for High Demand Pricing (number of users)";

  // Parameters for pricing in different contexts
  parameter Real highDemandPrice = 20.0 "Price during high demand (per unit)";
  parameter Real normalDemandPrice = 10.0 "Price during low demand (per unit)";

  // Pricing Contexts
  ContextWithConditionEvent highDemandPricing(
    activationCondition = currentNumUsers > highDemandThreshold)
    "Context for High Demand Pricing";

  // Output to indicate the current pricing based on demand
  output Real currentPrice;

equation
  // Adjust the price based on the active pricing context
  currentPrice = if highDemandPricing.isActive then highDemandPrice
                 else normalDemandPrice;

end PricingStrategyContextSwitch;
