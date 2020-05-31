within OpenHPL;
package Controllers "Collection of different controllers"
  extends Modelica.Icons.Package;

  extends Icons.Governor;




  model VarController
    "Controller for dispatching variable power from wind and solar using hydro. This controller generates gate signal for hydroturbine based on power production from solar and wind, and total power needed for loads. For now only simple turbine can be used."
  extends OpenHPL.Icons.VariabilityController;
  inner Data data "using standard class with constants";

    Modelica.Blocks.Math.MultiProduct multiProduct(nu=5)
      annotation (Placement(transformation(extent={{-6,0},{10,16}})));
    Modelica.Blocks.Sources.RealExpression rho(y=data.rho)
      "Density of fluid (water)-kg/m3"
      annotation (Placement(transformation(extent={{-58,14},{-38,34}})));
    Modelica.Blocks.Sources.RealExpression gravity(y=data.g)
      "Acceleration due to gravity-m/s2"
      annotation (Placement(transformation(extent={{-58,0},{-38,20}})));
    Modelica.Blocks.Sources.RealExpression p_a(y=data.p_a)
      "Atomoshpheric pressure-Pa" annotation (Placement(transformation(
          extent={{-10,-9},{10,9}},
          rotation=180,
          origin={-60,55})));
    Modelica.Blocks.Interfaces.RealVectorInput eta
      "Hydarulic efficiency of turbine."
      annotation (Placement(transformation(extent={{-42,82},{-2,122}}),
          iconTransformation(extent={{-24,96},{-16,104}})));
    Modelica.Blocks.Interfaces.RealVectorInput C_v "Valve capacity of turbine."
      annotation (Placement(transformation(extent={{0,80},{40,120}}),
          iconTransformation(extent={{16,96},{24,104}})));
    Modelica.Blocks.Interfaces.RealVectorInput H_n
      "Nominal height of the hydro plant."
      annotation (Placement(transformation(extent={{40,80},{80,120}}),
          iconTransformation(extent={{56,96},{64,104}})));
    Modelica.Blocks.Interfaces.RealVectorInput dp
      "Pressure difference of the turbine = p_i_tr - p_o_tr, Pa"
      annotation (Placement(transformation(extent={{-80,80},{-40,120}}),
          iconTransformation(extent={{-64,96},{-56,104}})));
    Modelica.Blocks.Math.Sqrt sqrt
      annotation (Placement(transformation(extent={{-38,40},{-18,60}})));
    Modelica.Blocks.Math.Division division
      annotation (Placement(transformation(extent={{-72,62},{-52,82}})));
    Modelica.Blocks.Math.Division division1
      annotation (Placement(transformation(extent={{48,-10},{68,10}})));
    Modelica.Blocks.Math.MultiSum multiSum(k={1,-1,-1}, nu=3)
      annotation (Placement(transformation(extent={{0,-28},{12,-16}})));
    Modelica.Blocks.Interfaces.RealVectorInput P_load
      "Load or power reference to load"
      annotation (Placement(transformation(extent={{-120,40},{-82,78}}),
          iconTransformation(extent={{-104,56},{-96,64}})));
    Modelica.Blocks.Interfaces.RealVectorInput P_pv
      "Power production from solar plant."
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
          iconTransformation(extent={{-104,-4},{-96,4}})));
    Modelica.Blocks.Interfaces.RealVectorInput P_wind
      "Power production from wind power plant."
      annotation (Placement(transformation(extent={{-120,-78},{-80,-38}}),
          iconTransformation(extent={{-104,-64},{-96,-56}})));
    Modelica.Blocks.Interfaces.RealOutput u_v
      "Guide valve signal to the turbine."
      annotation (Placement(transformation(extent={{100,-20},{138,18}})));
  equation
    connect(dp, division.u1)
      annotation (Line(points={{-60,100},{-60,78},{-74,78}}, color={0,0,127}));
    connect(division.y, sqrt.u) annotation (Line(points={{-51,72},{-44,72},{-44,50},
            {-40,50}}, color={0,0,127}));
    connect(gravity.y, multiProduct.u[1])
      annotation (Line(points={{-37,10},{-6,10},{-6,12.48}},   color={0,0,127}));
    connect(rho.y, multiProduct.u[2])  annotation (Line(points={{-37,24},{-26,24},
            {-26,10.24},{-6,10.24}},     color={0,0,127}));
    connect(division.u2, p_a.y) annotation (Line(points={{-74,66},{-76,66},{-76,55},
            {-71,55}}, color={0,0,127}));
    connect(P_load, multiSum.u[1]) annotation (Line(points={{-101,59},{-79,59},{-79,
            -19.2},{4.44089e-16,-19.2}}, color={0,0,127}));
    connect(P_pv, multiSum.u[2]) annotation (Line(points={{-100,0},{-56,0},{-56,-22},
            {4.44089e-16,-22}}, color={0,0,127}));
    connect(P_wind, multiSum.u[3]) annotation (Line(points={{-100,-58},{-56,-58},{
            -56,-24.8},{4.44089e-16,-24.8}}, color={0,0,127}));
    connect(multiSum.y, division1.u1) annotation (Line(points={{13.02,-22},{36,-22},
            {36,6},{46,6}}, color={0,0,127}));
    connect(multiProduct.y, division1.u2) annotation (Line(points={{11.36,8},{30,8},
            {30,-6},{46,-6}}, color={0,0,127}));
    connect(division1.y, u_v) annotation (Line(points={{69,0},{102,0},{102,-1},{119,
            -1}}, color={0,0,127}));
    connect(C_v, multiProduct.u[3])
      annotation (Line(points={{20,100},{8,100},{8,8},{-6,8}}, color={0,0,127}));
    connect(H_n, multiProduct.u[4]) annotation (Line(points={{60,100},{28,100},{28,
            5.76},{-6,5.76}}, color={0,0,127}));
    connect(eta, multiProduct.u[5]) annotation (Line(points={{-22,102},{-22,53},{-6,
            53},{-6,3.52}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end VarController;
end Controllers;
