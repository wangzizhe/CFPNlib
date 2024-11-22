within ContextVariabilityManager.CaseStudies.ElectricGridCaseStudy;
model ElectricGridCaseStudy
  // Base model: TransiEnt.Examples.Electric.ElectricGrid_StandAlone

  // Importing necessary component for context-based conditional event handling
  import ContextVariabilityManager.Components.Composite.ContextWithConditionEvent;

  inner TransiEnt.SimCenter simCenter(useHomotopy=false, ambientConditions(
      redeclare TransiEnt.Basics.Tables.Ambient.GHI_Hamburg_3600s_2012_TMY globalSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.Temperature_Berlin_3600s_2012 temperature,
      redeclare TransiEnt.Basics.Tables.Ambient.Wind_Hamburg_Fuhlsbuettel_3600s_2012 wind)) annotation (Placement(transformation(extent={{-238,186},{-198,226}})));
  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-198,186},{-158,226}})));

  TransiEnt.Producer.Combined.LargeScaleCHP.ContinuousCHP CHP(
    P_el_n=3e6,
    Q_flow_n_CHP=CHP.P_el_n/0.3,
    PQCharacteristics=TransiEnt.Producer.Combined.LargeScaleCHP.Base.Characteristics.PQ_Characteristics_STGeneric(),
    p_nom=18e5,
    T_feed_init=373.15) annotation (Placement(transformation(extent={{-238,112},{-180,42}})));
  TransiEnt.Basics.Tables.GenericDataTable heatDemandTable(relativepath="heat/HeatDemand_HHWilhelmsburg_MFH3000_900s_01012012_31122012.txt", constantfactor=-1.2) annotation (Placement(transformation(extent={{8,184},{48,224}})));
  Modelica.Blocks.Sources.RealExpression constHeatDemandCHP(y=max(heatDemandTable.y1 - 5e5, -CHP.Q_flow_n_CHP)) annotation (Placement(transformation(
        extent={{20,-10},{-20,10}},
        rotation=270,
        origin={-197,-42})));
  Modelica.Blocks.Sources.RealExpression electricityDemandCHP1(y=CHP_input) annotation (Placement(transformation(
        extent={{20,-10},{-20,10}},
        rotation=270,
        origin={-226,-44})));
  TransiEnt.Consumer.Electrical.LinearElectricConsumer electricDemand annotation (Placement(transformation(
        extent={{-169.786,-5.35691},{-129.6,35.3561}},
        rotation=90,
        origin={134.356,297.6})));
  TransiEnt.Producer.Electrical.Wind.PowerProfileWindPlant windProduction(P_el_n=2e6) annotation (Placement(transformation(extent={{-188,-254},{-148,-216}})));
  TransiEnt.Producer.Electrical.Photovoltaics.PVProfiles.SolarProfileLoader solarProfileLoader(change_of_sign=true, P_el_n=2e4) annotation (Placement(transformation(extent={{-278,-130},{-238,-90}})));
  TransiEnt.Producer.Electrical.Wind.WindProfiles.WindProfileLoader windProfileLoader(change_of_sign=true, P_el_n=2e6) annotation (Placement(transformation(extent={{-282,-212},{-244,-172}})));
  TransiEnt.Producer.Electrical.Photovoltaics.PhotovoltaicProfilePlant pVPlant(P_el_n=2e4, P_el_is=PV_output)                annotation (Placement(transformation(extent={{-188,-178},{-148,-138}})));
  TransiEnt.Basics.Tables.GenericDataTable electricDemandTable(relativepath="electricity/ElectricityDemand_VDI4665_ExampleHousehold_RG1_HH_2012_900s.txt", constantfactor=1500) annotation (Placement(transformation(extent={{8,128},{48,168}})));
  TransiEnt.Components.Electrical.Grid.Line line_L1_1 annotation (Placement(transformation(extent={{-24,-134},{6,-102}})));
  TransiEnt.Components.Sensors.ElectricActivePower P_12(change_of_sign=true) annotation (Placement(transformation(extent={{56,-108},{76,-128}})));
  TransiEnt.Grid.Electrical.LumpedPowerGrid.LumpedGrid UCTE(
    delta_pr=0.2/50/(3/150 - 0.2*0.01),
    P_pr_max_star=0.02,
    k_pr=0.5,
    T_r=150,
    lambda_sec=simCenter.P_n_ref_2/(simCenter.P_n_ref_1 + simCenter.P_n_ref_2)*3e9/0.2,
    P_pr_grad_max_star=0.02/30,
    beta=0.2,
    redeclare TransiEnt.Grid.Electrical.Noise.TypicalLumpedGridError genericGridError) annotation (Placement(transformation(extent={{244,-158},{164,-78}})));
  Modelica.Blocks.Sources.RealExpression massFlowDHN(y=-25) annotation (Placement(transformation(
        extent={{14,-15},{-14,15}},
        rotation=0,
        origin={-8,55})));
  Modelica.Blocks.Sources.RealExpression returnTemperatureDNH(y=70 + 273) annotation (Placement(transformation(
        extent={{14,-15},{-14,15}},
        rotation=0,
        origin={-8,29})));
  TransiEnt.Components.Boundaries.FluidFlow.BoundaryVLE_Txim_flow boundaryVLE_Txim_flow(variable_T=true, boundaryConditions(p_nom=20e5)) annotation (Placement(transformation(extent={{-48,28},{-68,48}})));
  TransiEnt.Components.Boundaries.FluidFlow.BoundaryVLE_pTxi boundaryVLE_pTxi(boundaryConditions(p_const=16e5)) annotation (Placement(transformation(extent={{-48,4},{-68,24}})));

  // Variables
  Real currentDemand;
  Real currentPVPower;
  Real currentWindPower;
  Real CHP_input;
  Real PV_output;

  // Context-based event for Renewable Priority Operation
  ContextWithConditionEvent renewablePriority(
    weakInclusionContext = "windOnly",
    activationCondition = (currentDemand < 1e6 and currentPVPower > 500 and currentWindPower > 5e5) or windOnly.isActive);

  // Context-based event for Wind Only Operation
  ContextWithConditionEvent windOnly(
    activationCondition = (currentDemand < 5e5));

equation
  connect(electricityDemandCHP1.y, CHP.P_set) annotation (Line(points={{-226,-22},{-226.69,-22},{-226.69,50.1667}},              color={0,0,127}));
  connect(solarProfileLoader.y1, pVPlant.P_el_set) annotation (Line(points={{-236,-110},{-236,-112},{-171,-112},{-171,-138.2}},                                       color={0,0,127}));
  connect(windProfileLoader.y1, windProduction.P_el_set) annotation (Line(points={{-242.1,-192},{-171,-192},{-171,-216.19}},                                          color={0,0,127}));
  connect(line_L1_1.epp_2, P_12.epp_IN) annotation (Line(
      points={{5.85,-118},{56.8,-118}},
      color={0,135,135},
      thickness=0.5));
  connect(P_12.epp_OUT, UCTE.epp) annotation (Line(
      points={{75.4,-118},{164,-118}},
      color={0,135,135},
      thickness=0.5));
  connect(CHP.epp, line_L1_1.epp_1) annotation (Line(
      points={{-181.45,66.5},{-156,66.5},{-156,-118.16},{-23.85,-118.16}},
      color={0,135,135},
      thickness=0.5));
  connect(electricDemand.epp, line_L1_1.epp_1) annotation (Line(
      points={{119.356,128.216},{119.356,-92},{-32,-92},{-32,-118.16},{-23.85,-118.16}},
      color={0,135,135},
      thickness=0.5));
  connect(pVPlant.epp, line_L1_1.epp_1) annotation (Line(
      points={{-150,-144},{-44,-144},{-44,-118.16},{-23.85,-118.16}},
      color={0,135,135},
      thickness=0.5));
  connect(windProduction.epp, line_L1_1.epp_1) annotation (Line(
      points={{-150,-221.7},{-44,-221.7},{-44,-118.16},{-23.85,-118.16}},
      color={0,135,135},
      thickness=0.5));
  connect(CHP.Q_flow_set, constHeatDemandCHP.y) annotation (Line(points={{-198.27,50.1667},{-197,50.1667},{-197,-20}},      color={0,0,127}));
  connect(CHP.inlet, boundaryVLE_Txim_flow.fluidPortOut) annotation (Line(
      points={{-179.42,92.75},{-80,92.75},{-80,38},{-68,38}},
      color={175,0,0},
      thickness=0.5));
  connect(boundaryVLE_pTxi.fluidPortIn, CHP.outlet) annotation (Line(
      points={{-68,14},{-152,14},{-152,84.5833},{-179.42,84.5833}},
      color={175,0,0},
      thickness=0.5));
  connect(boundaryVLE_Txim_flow.T, returnTemperatureDNH.y) annotation (Line(points={{-46,38},{-36,38},{-36,29},{-23.4,29}},    color={0,0,127}));
  connect(massFlowDHN.y, boundaryVLE_Txim_flow.m_flow) annotation (Line(points={{-23.4,55},{-32,55},{-32,44},{-46,44}},  color={0,0,127}));
  connect(electricDemandTable.y1, electricDemand.P_el_set) annotation (Line(points={{50,148},{72.8714,148},{72.8714,147.907},{95.7429,147.907}},
                                                                                                                                   color={0,0,127}));
  // Equations to assign real values based on the current power consumption and production
  currentDemand = electricDemand.epp.P;
  currentPVPower = abs(pVPlant.epp.P);
  currentWindPower = abs(windProduction.epp.P);

  // Conditional assignment based on the status of renewablePriority
  CHP_input = if renewablePriority.isActive then 0 else -min(electricDemandTable.y1 + 0.5e6, 1e6);

  // Conditional assignment based on the status of windOnly
  PV_output = if windOnly.isActive then 0 else currentPVPower;

  annotation (
    Icon(graphics, coordinateSystem(preserveAspectRatio=false, initialScale=0.1)),
    Diagram(          coordinateSystem(
        preserveAspectRatio=false,
        extent={{-300,-300},{300,300}},
        initialScale=0.1)),
    experiment(StopTime=86400, Interval=900),
    __Dymola_experimentSetupOutput(inputs=false, events=false),
    __Dymola_experimentFlags(
      Advanced(
        EvaluateAlsoTop=false,
        GenerateVariableDependencies=false,
        OutputModelicaCode=false),
      Evaluate=true,
      OutputCPUtime=true,
      OutputFlatModelica=false));
end ElectricGridCaseStudy;
