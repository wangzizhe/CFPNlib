within CFPNlib.Examples.CoffeeMaker;

model UserAction "Simulates user pushing start buttons for one-time pulses using simple when statements"
  // Output Boolean signals for each button
  output Boolean startBrewingButton;
  output Boolean startGrindingButton;
  output Boolean startSteamingButton;

initial equation
  startBrewingButton = false;
  startGrindingButton = false;
  startSteamingButton = false;

equation
  // Trigger
  when time >= 10 then
    startBrewingButton = true;
  elsewhen time >= 41 then
    startBrewingButton = false;
  end when;

  when time >= 30 then
    startGrindingButton = true;
  elsewhen time >= 71 then
    startGrindingButton = false;
  end when;

  when time >= 80 then
    startSteamingButton = true;
  elsewhen time >= 121 then
    startSteamingButton = false;
  end when;

end UserAction;
