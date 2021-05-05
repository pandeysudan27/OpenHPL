within OpenHPL.Tests;
model ParallelTurbineCaseDroopControl
  "This is parallel operation of hydro powers for droop control mechanism."
  extends Modelica.Icons.Example;
  //Modelica.Blocks.Sources.Ramp load(duration = 1, height = -5e6, offset = 80e6, startTime = 600) annotation(
  //  Placement(visible = true, transformation(extent = {{-40, -6}, {-20, 14}}, rotation = 0)));
  //OpenHPL.HydroPower.Aggregate aggregate annotation(
  //  Placement(visible = true, transformation(extent = {{-4, -6}, {16, 14}}, rotation = 0)));
  inner OpenHPL.Constants Const annotation (
    Placement(visible = true, transformation(origin={-210,132},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ElectroMech.Generators.SimpleGen Gen(
    J=1,
    theta_e=1,
    k_b=1000) annotation (Placement(transformation(extent={{82,32},{102,52}})));
  Modelica.Blocks.Sources.Ramp puLoad(
    duration=20,
    height=0.3,
    offset=0.5,
    startTime=100) annotation (Placement(visible=true, transformation(
        origin={26,8},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=4*60e6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={56,8})));
  Modelica.Blocks.Continuous.LimPID PI1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=10000,
    yMax=1,
    yMin=0.01,
    Ni=0.01,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{56,-68},{76,-48}})));
  Waterway.Reservoir         reservoir1(H_r=50)
                                               annotation (Placement(visible=true, transformation(
        origin={-200,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         intake1(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-182,80},
            {-162,100}},                                                                                            rotation=0)));
  Waterway.Pipe         discharge1(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{-80,80},
            {-60,100}},                                                                                                      rotation=0)));
  Waterway.Reservoir         tail1(H_r=5)
                                         annotation (Placement(visible=true, transformation(
        origin={-40,90},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock1(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={-120,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank1(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=40)                                      annotation (Placement(visible=true, transformation(
        origin={-144,90},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine1(C_v=3.7, ConstEfficiency=false)
                                                                       annotation (Placement(visible=true, transformation(
        origin={-96,88},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Reservoir         reservoir2(H_r=50)
                                               annotation (Placement(visible=true, transformation(
        origin={-200,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         intake2(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-182,16},
            {-162,36}},                                                                                             rotation=0)));
  Waterway.Pipe         discharge2(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{-80,16},
            {-60,36}},                                                                                                       rotation=0)));
  Waterway.Reservoir         tail2(H_r=5)
                                         annotation (Placement(visible=true, transformation(
        origin={-40,26},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock2(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={-120,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank2(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=40)                                      annotation (Placement(visible=true, transformation(
        origin={-144,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine2(C_v=3.7, ConstEfficiency=false)
                                                                       annotation (Placement(visible=true, transformation(
        origin={-96,26},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Reservoir         reservoir3(H_r=50)
                                               annotation (Placement(visible=true, transformation(
        origin={-198,-42},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         intake3(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-180,
            -52},{-160,-32}},                                                                                       rotation=0)));
  Waterway.Pipe         discharge3(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{-78,-52},
            {-58,-32}},                                                                                                      rotation=0)));
  Waterway.Reservoir         tail3(H_r=5)
                                         annotation (Placement(visible=true, transformation(
        origin={-38,-42},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock3(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={-118,-42},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank3(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=40)                                      annotation (Placement(visible=true, transformation(
        origin={-142,-42},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine3(C_v=3.7, ConstEfficiency=false)
                                                                       annotation (Placement(visible=true, transformation(
        origin={-94,-42},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.RealExpression G1(y=Gen1.W_g)
    annotation (Placement(transformation(extent={{-20,78},{0,98}})));
  Modelica.Blocks.Sources.RealExpression G2(y=Gen2.W_g)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Sources.RealExpression G3(y=Gen3.W_g)
    annotation (Placement(transformation(extent={{-20,42},{0,62}})));
  Modelica.Blocks.Sources.RealExpression G4(y=Gen4.W_g)
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  Modelica.Blocks.Math.MultiSum PGenTotal(nu=4)
    annotation (Placement(transformation(extent={{34,58},{46,70}})));
  Waterway.Reservoir         reservoir4(H_r=50)
                                               annotation (Placement(visible=true, transformation(
        origin={-198,-110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.Pipe         intake4(
    H=20,
    L=4500,
    D_i=6,
    SteadyState=true)                annotation (Placement(visible=true, transformation(extent={{-180,
            -120},{-160,-100}},                                                                                     rotation=0)));
  Waterway.Pipe         discharge4(
    H=5,
    L=700,
    SteadyState=true)                           annotation (Placement(visible=true, transformation(extent={{-78,
            -120},{-58,-100}},                                                                                               rotation=0)));
  Waterway.Reservoir         tail4(H_r=5)
                                         annotation (Placement(visible=true, transformation(
        origin={-38,-110},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Waterway.Pipe         penstock4(
    D_i=4,
    D_o=4,
    H=300,
    L=500,
    SteadyState=true)
           annotation (Placement(visible=true, transformation(
        origin={-118,-110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Waterway.SurgeTank         surgeTank4(
    H=80,
    L=80,
    D=4,
    SteadyState=true,
    h_0=40)                                      annotation (Placement(visible=true, transformation(
        origin={-142,-110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Turbines.Turbine turbine4(C_v=3.7, ConstEfficiency=false)
                                                                       annotation (Placement(visible=true, transformation(
        origin={-94,-110},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  ElectroMech.Generators.SimpleGen Gen1(J=5e5)
    annotation (Placement(transformation(extent={{-106,52},{-86,72}})));
  ElectroMech.Generators.SimpleGen Gen2(J=5e5)
    annotation (Placement(transformation(extent={{-106,-12},{-86,8}})));
  ElectroMech.Generators.SimpleGen Gen3(J=5e5)
    annotation (Placement(transformation(extent={{-104,-80},{-84,-60}})));
  ElectroMech.Generators.SimpleGen Gen4(J=5e5)
    annotation (Placement(transformation(extent={{-104,-150},{-84,-130}})));
  Modelica.Blocks.Sources.RealExpression DeltaP1(y=65/0.02*(Gen.f - 50))
    annotation (Placement(transformation(extent={{-142,52},{-122,72}})));
  Modelica.Blocks.Sources.RealExpression DeltaP2(y=65/0.04*(Gen.f - 50))
    annotation (Placement(transformation(extent={{-144,-12},{-124,8}})));
  Modelica.Blocks.Sources.RealExpression DeltaP3(y=65/0.04*(Gen.f - 50))
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Modelica.Blocks.Sources.RealExpression DeltaP4(y=65/0.06*(Gen.f - 50))
    annotation (Placement(transformation(extent={{-140,-150},{-120,-130}})));
  Modelica.Blocks.Sources.RealExpression PrefDy1(y=-DeltaP1.y - G1.y)
    annotation (Placement(transformation(extent={{12,-68},{32,-48}})));
  Modelica.Blocks.Sources.RealExpression Pg1(y=Gen1.W_g)
    annotation (Placement(transformation(extent={{12,-82},{32,-62}})));
  Modelica.Blocks.Continuous.LimPID PI2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=10000,
    yMax=1,
    yMin=0.01,
    Ni=0.1,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{56,-112},{76,-92}})));
  Modelica.Blocks.Sources.RealExpression PrefDy2(y=-DeltaP2.y - G2.y)
    annotation (Placement(transformation(extent={{12,-112},{32,-92}})));
  Modelica.Blocks.Sources.RealExpression Pg2(y=Gen2.W_g)
    annotation (Placement(transformation(extent={{12,-126},{32,-106}})));
  Modelica.Blocks.Continuous.LimPID PI3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=10000,
    yMax=1,
    yMin=0.01,
    Ni=0.1,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{142,-66},{162,-46}})));
  Modelica.Blocks.Sources.RealExpression PrefDy3(y=-DeltaP3.y - G3.y)
    annotation (Placement(transformation(extent={{98,-66},{118,-46}})));
  Modelica.Blocks.Sources.RealExpression Pg3(y=Gen3.W_g)
    annotation (Placement(transformation(extent={{98,-80},{118,-60}})));
  Modelica.Blocks.Continuous.LimPID PI4(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=10000,
    yMax=1,
    yMin=0.01,
    Ni=0.1,
    initType=Modelica.Blocks.Types.InitPID.SteadyState)
    annotation (Placement(transformation(extent={{142,-108},{162,-88}})));
  Modelica.Blocks.Sources.RealExpression PrefDy4(y=-DeltaP4.y - G4.y)
    annotation (Placement(transformation(extent={{98,-108},{118,-88}})));
  Modelica.Blocks.Sources.RealExpression Pg4(y=Gen4.W_g)
    annotation (Placement(transformation(extent={{98,-122},{118,-102}})));
  Modelica.Blocks.Sources.RealExpression Cont1(y=PI1.y)
    annotation (Placement(transformation(extent={{-120,108},{-100,128}})));
  Modelica.Blocks.Sources.RealExpression Cont2(y=PI2.y)
    annotation (Placement(transformation(extent={{-140,38},{-120,58}})));
  Modelica.Blocks.Sources.RealExpression Cont3(y=PI3.y)
    annotation (Placement(transformation(extent={{-144,-28},{-124,-8}})));
  Modelica.Blocks.Sources.RealExpression Cont4(y=PI4.y)
    annotation (Placement(transformation(extent={{-140,-96},{-120,-76}})));
equation
  //connect(turbine.P_out, aggregate.P_in) annotation(
  //  Line(points = {{-3.8, 34}, {2, 34}, {2, 14}, {2, 14}}, color = {0, 0, 127}));
  //connect(load.y, aggregate.u) annotation(
  //  Line(points = {{-19, 4}, {-12.5, 4}, {-12.5, 4}, {-4, 4}}, color = {0, 0, 127}));
  connect(discharge1.n, tail1.n)
    annotation (Line(points={{-60,90},{-50,90}}, color={28,108,200}));
  connect(penstock1.n, turbine1.p) annotation (Line(points={{-110,90},{-108,90},
          {-108,88},{-106,88}}, color={28,108,200}));
  connect(reservoir1.n, intake1.p)
    annotation (Line(points={{-190,90},{-182,90}}, color={28,108,200}));
  connect(intake1.n, surgeTank1.p)
    annotation (Line(points={{-162,90},{-154,90}}, color={28,108,200}));
  connect(surgeTank1.n, penstock1.p)
    annotation (Line(points={{-134,90},{-130,90}}, color={28,108,200}));
  connect(turbine1.n, discharge1.p) annotation (Line(points={{-86,88},{-84,88},
          {-84,90},{-80,90}}, color={28,108,200}));
  connect(discharge2.n, tail2.n)
    annotation (Line(points={{-60,26},{-50,26}}, color={28,108,200}));
  connect(penstock2.n, turbine2.p)
    annotation (Line(points={{-110,26},{-106,26}}, color={28,108,200}));
  connect(reservoir2.n, intake2.p)
    annotation (Line(points={{-190,26},{-182,26}}, color={28,108,200}));
  connect(intake2.n, surgeTank2.p)
    annotation (Line(points={{-162,26},{-154,26}}, color={28,108,200}));
  connect(surgeTank2.n, penstock2.p)
    annotation (Line(points={{-134,26},{-130,26}}, color={28,108,200}));
  connect(turbine2.n, discharge2.p)
    annotation (Line(points={{-86,26},{-80,26}}, color={28,108,200}));
  connect(discharge3.n, tail3.n)
    annotation (Line(points={{-58,-42},{-48,-42}}, color={28,108,200}));
  connect(penstock3.n, turbine3.p)
    annotation (Line(points={{-108,-42},{-104,-42}}, color={28,108,200}));
  connect(reservoir3.n, intake3.p)
    annotation (Line(points={{-188,-42},{-180,-42}}, color={28,108,200}));
  connect(intake3.n, surgeTank3.p)
    annotation (Line(points={{-160,-42},{-152,-42}}, color={28,108,200}));
  connect(surgeTank3.n, penstock3.p)
    annotation (Line(points={{-132,-42},{-128,-42}}, color={28,108,200}));
  connect(turbine3.n, discharge3.p)
    annotation (Line(points={{-84,-42},{-78,-42}}, color={28,108,200}));
  connect(G1.y, PGenTotal.u[1]) annotation (Line(points={{1,88},{24,88},{24,
          67.15},{34,67.15}}, color={0,0,127}));
  connect(G2.y, PGenTotal.u[2]) annotation (Line(points={{1,70},{24,70},{24,
          65.05},{34,65.05}}, color={0,0,127}));
  connect(G3.y, PGenTotal.u[3]) annotation (Line(points={{1,52},{24,52},{24,
          62.95},{34,62.95}}, color={0,0,127}));
  connect(G4.y, PGenTotal.u[4]) annotation (Line(points={{1,32},{24,32},{24,
          60.85},{34,60.85}}, color={0,0,127}));
  connect(discharge4.n, tail4.n)
    annotation (Line(points={{-58,-110},{-48,-110}}, color={28,108,200}));
  connect(penstock4.n, turbine4.p)
    annotation (Line(points={{-108,-110},{-104,-110}}, color={28,108,200}));
  connect(reservoir4.n, intake4.p)
    annotation (Line(points={{-188,-110},{-180,-110}}, color={28,108,200}));
  connect(intake4.n, surgeTank4.p)
    annotation (Line(points={{-160,-110},{-152,-110}}, color={28,108,200}));
  connect(surgeTank4.n, penstock4.p)
    annotation (Line(points={{-132,-110},{-128,-110}}, color={28,108,200}));
  connect(turbine4.n, discharge4.p)
    annotation (Line(points={{-84,-110},{-78,-110}}, color={28,108,200}));
  connect(turbine1.P_out, Gen1.P_in)
    annotation (Line(points={{-96,77},{-96,74}}, color={0,0,127}));
  connect(turbine2.P_out, Gen2.P_in)
    annotation (Line(points={{-96,15},{-96,10}}, color={0,0,127}));
  connect(turbine3.P_out, Gen3.P_in)
    annotation (Line(points={{-94,-53},{-94,-58}}, color={0,0,127}));
  connect(turbine4.P_out, Gen4.P_in)
    annotation (Line(points={{-94,-121},{-94,-128}}, color={0,0,127}));
  connect(PGenTotal.y, Gen.P_in)
    annotation (Line(points={{47.02,64},{92,64},{92,54}}, color={0,0,127}));
  connect(Gen1.u, DeltaP1.y)
    annotation (Line(points={{-106,62},{-121,62}}, color={0,0,127}));
  connect(Gen2.u, DeltaP2.y)
    annotation (Line(points={{-106,-2},{-123,-2}}, color={0,0,127}));
  connect(Gen3.u, DeltaP3.y)
    annotation (Line(points={{-104,-70},{-119,-70}}, color={0,0,127}));
  connect(Gen4.u, DeltaP4.y)
    annotation (Line(points={{-104,-140},{-119,-140}}, color={0,0,127}));
  connect(puLoad.y, gain.u)
    annotation (Line(points={{37,8},{44,8}}, color={0,0,127}));
  connect(Gen.u, gain.y)
    annotation (Line(points={{82,42},{68,42},{68,8},{67,8}}, color={0,0,127}));
  connect(PrefDy1.y, PI1.u_s)
    annotation (Line(points={{33,-58},{54,-58}}, color={0,0,127}));
  connect(PI1.u_m, Pg1.y)
    annotation (Line(points={{66,-70},{66,-72},{33,-72}}, color={0,0,127}));
  connect(PrefDy2.y, PI2.u_s)
    annotation (Line(points={{33,-102},{54,-102}}, color={0,0,127}));
  connect(PI2.u_m, Pg2.y)
    annotation (Line(points={{66,-114},{66,-116},{33,-116}}, color={0,0,127}));
  connect(PrefDy3.y, PI3.u_s)
    annotation (Line(points={{119,-56},{140,-56}}, color={0,0,127}));
  connect(PI3.u_m, Pg3.y)
    annotation (Line(points={{152,-68},{152,-70},{119,-70}}, color={0,0,127}));
  connect(PrefDy4.y, PI4.u_s)
    annotation (Line(points={{119,-98},{140,-98}}, color={0,0,127}));
  connect(PI4.u_m, Pg4.y) annotation (Line(points={{152,-110},{152,-112},{119,
          -112}}, color={0,0,127}));
  connect(turbine1.u_t, Cont1.y) annotation (Line(points={{-96,100},{-98,100},{
          -98,118},{-99,118}}, color={0,0,127}));
  connect(turbine2.u_t, Cont2.y) annotation (Line(points={{-96,38},{-108,38},{
          -108,48},{-119,48}}, color={0,0,127}));
  connect(turbine3.u_t, Cont3.y) annotation (Line(points={{-94,-30},{-108,-30},
          {-108,-18},{-123,-18}}, color={0,0,127}));
  connect(turbine4.u_t, Cont4.y) annotation (Line(points={{-94,-98},{-106,-98},
          {-106,-86},{-119,-86}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=200,
      Interval=0.4,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-220,-160},{380,140}})),
    Icon(coordinateSystem(extent={{-220,-160},{380,140}})));
end ParallelTurbineCaseDroopControl;
