within CFPNlib.Examples.GreenIT;

model HydrogenTank "Tank to store and supply hydrogen directly from production input"
  // State Variables
  output Real hydrogenLevel "Current hydrogen level in the tank, directly set by hydrogen production";
  Boolean hydrogenAvailable "Indicates if hydrogen is available in the tank";
  input Real hydrogenProduction "Hydrogen supplied by HydrogenGenerator";

equation
  // Set hydrogen level directly from production input
  hydrogenLevel = hydrogenProduction;

  // Determine hydrogen availability based on current level
  hydrogenAvailable = hydrogenLevel > 0;

end HydrogenTank;
