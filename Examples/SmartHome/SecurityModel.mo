within CFPNlib.Examples.SmartHome;
model SecurityModel
  // Parameters for the Security system
  parameter Boolean SecurityOn = true "Indicates if the security system is active";
  parameter Boolean SecurityOff = false "Indicates if the security system is inactive";

  // Security system state
  Boolean securityActive "Current state of the security system";

  // External input for context state
  input Boolean isNight;

equation
  // Activate security system only during night
  securityActive = if isNight then SecurityOn else SecurityOff;

end SecurityModel;
