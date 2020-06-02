within OpenHPL;
package Controllers "Collection of different controllers"
  extends Modelica.Icons.Package;

  extends Icons.Governor;




  model VarController
    "Controller for dispatching variable power from wind and solar using hydro. This controller generates gate signal for hydroturbine based on power production from solar and wind, and total power needed for loads. For now only simple turbine can be used."
  extends OpenHPL.Icons.VarController;
  inner Data data "using standard class with constants";

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
      Real P_diff = P_load-P_pv-P_wind;
  equation
    u_v = abs((P_load-P_pv-P_wind)/sqrt((data.rho*data.g*H_n)^3/data.p_a)/eta/C_v);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end VarController;
end Controllers;
