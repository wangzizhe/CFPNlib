within ContextVariabilityManager.CaseStudies.CarSharingSystemCaseStudy;
model CarSharingSystem
  // Parameters
  parameter Integer numCars = 10 "Number of cars in the system at starting point";
  parameter Integer numUsers = 1 "Number of users in the system at starting point";
  parameter Real userArrivalRate = 10.0 "User arrival rate (users per time unit)";
  parameter Real returnRate = 0.5 "Car return rate";
  parameter Real chargingTime = 1.0 "Time to fully charge a car";
  parameter Real usageTime = 1.0 "Car usage time by a customer";
  parameter Real userPatience = 10.0 "Maximum waiting time for users";

  // State variables
  output Real currentNumUsers(start = numUsers) "Current number of users in the system";
  output Real currentNumCars(start = numCars) "Current number of available cars in the system";
  input Real carDispatch "Current number of dispatched cars into the system because of high usage";
  input Real currentPrice "Current price base on demand";

  // State variables for additional information
  Real totalWaitingTime(start = 0) "Total waiting time for users";
  Real totalCarsRented(start = 0) "Total number of cars rented";
  Real totalChargingTime(start = 0) "Total charging time for all cars";
  Integer usersLeaving(start = 0) "Total number of left users";

  // Discrete Place: Number of free places in the station
  PNlib.Components.PD PSCii(nIn = 1, nOut = 1) annotation (
    Placement(transformation(origin = {-328, 90}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  // Stochastic Transition: Car is ready and available for users after charging operation
  PNlib.Components.TES TCRi(nIn = 1, nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/chargingTime) annotation (
    Placement(transformation(origin = {-280, 16}, extent = {{-10, -10}, {10, 10}})));
  // Discrete Place: Cars parked at the station, ready and then available for users
  PNlib.Components.PD PSRi(nIn = 1, nOut = 1, startTokens = numCars) annotation (
    Placement(transformation(origin = {-242, 82}, extent = {{-10, -10}, {10, 10}})));
  // Discrete Place: Number of free places in the station
  PNlib.Components.PD PSCi(nIn = 1, nOut = 1, startTokens = 0) annotation (
    Placement(transformation(origin = {-240, 116}, extent = {{10, -10}, {-10, 10}})));
  // Immediate Transition: User demand "satisfied" and then "user departure" from station
  PNlib.Components.T TUSi(nIn = 2, nOut = 2) annotation (
    Placement(transformation(origin = {-180, 82}, extent = {{-14, -14}, {14, 14}})));
  // Discrete Place: Car in use by customers
  PNlib.Components.PD PCU(nIn = 2, nOut = 3, startTokens = 5) annotation (
    Placement(transformation(origin = {1, 17}, extent = {{21, -21}, {-21, 21}}, rotation = -90)));
  // Discrete Place: Users waiting during a given random delay- for available and ready cars in the station
  PNlib.Components.PD PSDi(nIn = 1, nOut = 2, startTokens = numUsers) annotation (
    Placement(transformation(origin = {-268, -90}, extent = {{-10, -10}, {10, 10}})));
  // Deterministic transition: User demand “not satisfied” at station
  PNlib.Components.TD TUNi(nIn = 1, delay = userPatience) annotation (
    Placement(transformation(origin = {-178, -90}, extent = {{-10, -10}, {10, 10}})));
  // Stochastic Transition: User demand arrival at station
  PNlib.Components.TES TUDi(nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/userArrivalRate) annotation (
    Placement(transformation(origin = {-312, -90}, extent = {{-10, -10}, {10, 10}})));
  // Stochastic Transition: Car return to station by user. Then, the car is in a charging situation
  PNlib.Components.TES TCCi(nIn = 2, nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/chargingTime) annotation (
    Placement(transformation(origin = {-316, 126}, extent = {{10, -10}, {-10, 10}})));
  // Stochastic Transition: Car picked up for “long” maintenance (e.g. due to an incident/ accident) by service provider
  PNlib.Components.TES TCM(nIn = 1, nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/chargingTime) annotation (
    Placement(transformation(origin = {222, 160}, extent = {{-10, -10}, {10, 10}})));
  // Discrete Place: Cars under maintenance
  PNlib.Components.PD PCM(nIn = 1, nOut = 1, startTokens = 2) annotation (
    Placement(transformation(origin = {384, 160}, extent = {{-10, -10}, {10, 10}})));
  // Stochastic Transition: After maintenance, car is parked at the station Park. It is ready and available for users
  PNlib.Components.TES TMPR(nIn = 1, nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/usageTime) annotation (
    Placement(transformation(origin = {468, 74}, extent = {{-10, -10}, {10, 10}})));
  // Discrete Place: Car in use by customers
  PNlib.Components.PD PCU_1(nIn = 2, nOut = 1, startTokens = 3) annotation (
    Placement(transformation(origin = {392, -8}, extent = {{10, -10}, {-10, 10}})));
  // Stochastic Transition: The car is ready and available for other users, after its charging operation
  PNlib.Components.TES TCPR(nIn = 1, nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/returnRate) annotation (
    Placement(transformation(origin = {342, -94}, extent = {{-10, -10}, {10, 10}})));
  // Discrete Place: Car in use by customers
  PNlib.Components.PD PCU_2(nIn = 1, nOut = 1, startTokens = 1) annotation (
    Placement(transformation(origin = {296, -130}, extent = {{-10, -10}, {10, 10}})));
  // Stochastic transition: Car return to station Park by user. This car will be in charging operation
  PNlib.Components.TES TCPc(nIn = 1, nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/usageTime) annotation (
    Placement(transformation(origin = {186, -92}, extent = {{-10, -10}, {10, 10}})));
  // Immediate Transition: User demand “satisfied” and then “user departure” from station park
  PNlib.Components.T TUSp(nIn = 2, nOut = 1) annotation (
    Placement(transformation(origin = {113, -7}, extent = {{21, -21}, {-21, 21}})));
  // Stochastic Transition: User demand arrival at station park
  PNlib.Components.TES TUDp(nIn = 0, nOut = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/userPatience) annotation (
    Placement(transformation(origin = {336, 74}, extent = {{10, -10}, {-10, 10}})));
  // Helper transition
  PNlib.Components.PD P1(nIn = 1, nOut = 2) annotation (
    Placement(transformation(origin = {280, 74}, extent = {{10, -10}, {-10, 10}})));
  // Stochastic Transition: User demand “not satisfied” at Park. The user leaves the station without having been served
  PNlib.Components.TDS TUNp(nIn = 1, distributionType = PNlib.Types.DistributionType.Exponential, h = 1/userPatience) annotation (
    Placement(transformation(origin = {144, 74}, extent = {{10, -10}, {-10, 10}})));

  inner PNlib.Components.Settings settings(showTokenFlow = true, showTransitionName = true, animateHazardFunc = true) annotation (
    Placement(transformation(origin = {-356, 208}, extent = {{-10, -10}, {10, 10}})));

equation
  // Retrieve the current number of users
  currentNumUsers = PSDi.t;
  // Retrieve the current number of cars
  currentNumCars = PSRi.t;

  // Calculate total waiting time when users leave
  when change(PSDi.tokenFlow.outflow[2]) then
    usersLeaving = PSDi.tokenFlow.outflow[2];
  // Number of users leaving
    totalWaitingTime = pre(totalWaitingTime) + usersLeaving * userPatience;
  end when;
  // Calculate total number of cars rented
  when change(PSRi.tokenFlow.outflow[1]) then
    totalCarsRented = PSRi.tokenFlow.outflow[1];
  end when;
  // Calculate total charging time
  when TCCi.active then
    totalChargingTime = pre(totalChargingTime) + chargingTime;
  end when;

  // Connections
  connect(TUDi.outPlaces, PSDi.inTransition) annotation (
    Line(points={{-307.2,-90},{-278.8,-90}},      thickness = 0.5));
  connect(PSRi.outTransition[1], TUSi.inPlaces[1]) annotation (
    Line(points={{-231.2,82},{-208,82},{-208,81.65},{-186.72,81.65}},
                                              thickness = 0.5));
  connect(PSDi.outTransition[1], TUSi.inPlaces[2]) annotation (
    Line(points={{-257.2,-90.25},{-213.2,-90.25},{-213.2,82.35},{-186.72,82.35}},
                                                                          thickness = 0.5));
  connect(PSDi.outTransition[2], TUNi.inPlaces[1]) annotation (
    Line(points={{-257.2,-89.75},{-220,-89.75},{-220,-90},{-182.8,-90}},
                                                  thickness = 0.5));
  connect(PSCi.outTransition[1], TCCi.inPlaces[1]) annotation (
    Line(points={{-250.8,116},{-267,116},{-267,125.75},{-311.2,125.75}},  thickness = 0.5));
  connect(TCCi.outPlaces[1], PSCii.inTransition[1]) annotation (
    Line(points={{-320.8,126},{-328.8,126},{-328.8,100.8},{-328,100.8}},    thickness = 0.5));
  connect(PSCii.outTransition[1], TCRi.inPlaces[1]) annotation (
    Line(points={{-328,79.2},{-328,16},{-284.8,16}},    thickness = 0.5));
  connect(TCRi.outPlaces[1], PSRi.inTransition[1]) annotation (
    Line(points={{-275.2,16},{-275.2,82},{-252.8,82}},    thickness = 0.5));
  connect(TCM.outPlaces[1], PCM.inTransition[1]) annotation (
    Line(points={{226.8,160},{373.2,160}},  thickness = 0.5));
  connect(PCM.outTransition[1], TMPR.inPlaces[1]) annotation (
    Line(points={{394.8,160},{449,160},{449,73.5215},{463.2,73.5215},{463.2,74}},      thickness = 0.5));
  connect(TMPR.outPlaces[1], PCU_1.inTransition[1]) annotation (
    Line(points={{472.8,74},{450,74},{450,-8.25},{402.8,-8.25}},thickness = 0.5));
  connect(TCPR.outPlaces[1], PCU_1.inTransition[2]) annotation (
    Line(points={{346.8,-94},{346.8,-51},{402.8,-51},{402.8,-7.75}},
                                                                   thickness = 0.5));
  connect(PCU_2.outTransition[1], TCPR.inPlaces[1]) annotation (
    Line(points={{306.8,-130},{323,-130},{323,-94},{337.2,-94}},      thickness = 0.5));
  connect(TCPc.outPlaces[1], PCU_2.inTransition[1]) annotation (
    Line(points={{190.8,-92},{241,-92},{241,-130},{285.2,-130}},      thickness = 0.5));
  connect(PCU_1.outTransition[1], TUSp.inPlaces[1]) annotation (
    Line(points={{381.2,-8},{123.08,-8},{123.08,-7.525}},
                                                     thickness = 0.5));
  connect(TUDp.outPlaces[1], P1.inTransition[1]) annotation (
    Line(points={{331.2,74},{290.8,74}},  thickness = 0.5));
  connect(P1.outTransition[1], TUNp.inPlaces[1]) annotation (
    Line(points={{269.2,73.75},{210,73.75},{210,74},{148.8,74}},
                                          thickness = 0.5));
  connect(P1.outTransition[2], TUSp.inPlaces[2]) annotation (
    Line(points={{269.2,74.25},{266,74.25},{266,22},{123.08,22},{123.08,-6.475}},
                                                                           thickness = 0.5));
  connect(PCU.outTransition[1], TCCi.inPlaces[2]) annotation (
    Line(points={{0.3,39.68},{2.25,39.68},{2.25,140},{-102,140},{-102,139},{-105,139},{-105,139.25},{-279,139.25},{-279,131.312},{-311.2,131.312},{-311.2,126.25}},         thickness = 0.5));
  connect(PCU.outTransition[2], TCM.inPlaces[1]) annotation (
    Line(points={{1,39.68},{108,39.68},{108,95},{199,95},{199,160.812},{217.2,160.812},{217.2,160}},      thickness = 0.5));
  connect(PCU.outTransition[3], TCPc.inPlaces[1]) annotation (
    Line(points={{1.7,39.68},{163,39.68},{163,-92},{181.2,-92}},thickness = 0.5));
  connect(TUSi.outPlaces[1], PCU.inTransition[1]) annotation (
    Line(points={{-173.28,81.65},{-100,81.65},{-100,-48},{0.5,-48},{0.5,-5.68},{0.475,-5.68}},
                                                                                         thickness = 0.5));
  connect(TUSi.outPlaces[2], PSCi.inTransition[1]) annotation (
    Line(points={{-173.28,82.35},{-157,82.35},{-157,116},{-229.2,116}},
                                                                      thickness = 0.5));
  connect(TUSp.outPlaces[1], PCU.inTransition[2]) annotation (
    Line(points={{102.92,-7},{53.5,-7},{53.5,-5.68},{1.525,-5.68}},
                                                                thickness = 0.5));

  annotation (
    uses(PNlib(version = "3.0.0"), Modelica(version = "4.0.0")),
    Diagram(graphics={  Text(origin = {-335, -114}, extent = {{3, 0}, {-3, 0}}, textString = "text"), Text(origin = {-310, 194}, extent = {{42, -20}, {-42, 0}}, textString = "Station subnet", fontSize = 12, fontName = "Open Sans"), Rectangle(origin = {-244, 77}, lineColor = {0, 0, 255}, lineThickness = 0.5, extent = {{-104, 97}, {104, -97}}), Rectangle(origin = {-244, -90}, lineColor = {0, 255, 0}, lineThickness = 0.5, extent = {{-104, 30}, {104, -30}}), Text(origin = {-293, -132}, extent = {{55, -6}, {-55, 0}}, textString = "User demand subnet", fontSize = 12, fontName = "Open Sans"), Rectangle(origin = {227, 31}, lineColor = {0, 170, 255}, lineThickness = 0.5, extent = {{-135, 71}, {135, -71}}), Text(origin = {113, 140}, extent = {{85, -54}, {-85, 0}}, textString = "User Demand (park) subnet", fontSize = 12, fontName = "Open Sans"), Polygon(origin = {342, 55}, lineColor = {255, 85, 255}, lineThickness = 0.5, points = {{-154, 111}, {-154, 57}, {32, 57}, {32, -139}, {142, -139}, {142, 137}, {-154, 137}, {-154, 127}, {-154, 111}}), Text(origin = {273, 204}, extent = {{-117, 26}, {117, -26}}, textString = "Car Maintenance (Center) subnet", fontSize = 12, fontName = "Open Sans"), Rectangle(origin = {293, -77}, lineColor = {85, 85, 0}, lineThickness = 0.5, extent = {{-145, 87}, {145, -87}}), Text(origin = {232, -176}, extent = {{-92, 20}, {92, -20}}, textString = "Car-Sharing Park (Center) subnet", fontSize = 12, fontName = "Open Sans"), Text(extent = {{-16, 40}, {-16, 40}}, textString = "text")}, coordinateSystem(extent = {{-380, 240}, {500, -200}})),
    version = "");
end CarSharingSystem;
