within CarSharingSystemCaseStudy;

model CarSharingSystemCaseStudy
  import CarSharingSystem;
  import PeakHoursContextSwitch;
  import PricingStrategyContextSwitch;

  // Instantiate components for the car sharing system and context switches
  CarSharingSystem carSharingSystem;
  PeakHoursContextSwitch peakHoursContextSwitch;
  PricingStrategyContextSwitch pricingStrategyContextSwitch;
  
equation
  // Pass the current number of cars to the PeakHoursContextSwitch
  peakHoursContextSwitch.currentNumCars = carSharingSystem.currentNumCars;
  
  // Pass the current number of users to the PricingStrategyContextSwitch
  pricingStrategyContextSwitch.currentNumUsers = carSharingSystem.currentNumUsers;
  
  // Pass the output from PeakHoursContextSwitch to CarSharingSystem
  carSharingSystem.carDispatch = peakHoursContextSwitch.carDispatch;
  
  // Pass the current price from PricingStrategyContextSwitch to CarSharingSystem
  carSharingSystem.currentPrice = pricingStrategyContextSwitch.currentPrice;

end CarSharingSystemCaseStudy;
