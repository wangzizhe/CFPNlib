within CFPNlib.Examples.GreenIT;

model HydrogenGenerator "Generates hydrogen based on hourly input over 24 hours"
  // Define a CombiTable1Ds to use inline data for hydrogen production
  Modelica.Blocks.Tables.CombiTable1Ds hydrogenTable(
    table = [
     0, 2.0;
     3600, 3.0;
     7200, 4.0;
     10800, 5.0;
     14400, 8.0;
     18000, 9.0;
     21600, 10.0;
     25200, 10.0;
     28800, 20.0;
     32400, 30.0;
     36000, 40.0;
     39600, 50.0;
     43200, 60.0;
     46800, 70.0;
     50400, 80.0;
     54000, 90.0;
     57600, 100.0;
     61200, 100.0;
     64800, 100.0;
     68400, 80.0;
     72000, 50.0;
     75600, 30.0;
     79200, 10.0;
     82800, 5.0
    ],
    columns = {1,2},  // Specifies that column 2 has hydrogen production values
    smoothness = Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint
  );

  output Real hydrogenProduction "Current hydrogen output rate based on table data";

equation
  // Set the time input for the hydrogenTable lookup
  hydrogenTable.u = time;

  // Set hydrogen production based on table lookup, limited by max production rate
  hydrogenProduction = hydrogenTable.y[2];
end HydrogenGenerator;
