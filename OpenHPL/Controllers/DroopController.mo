within OpenHPL.Controllers;
model DroopController "Droop controller model"
  extends OpenHPL.Icons.Governor;
  outer Constants Const "using standard class with constants";
  //// control parameters of the governor
  parameter Modelica.SIunits.Frequency f_ref = 50 "Reference frequency of the system" annotation (
    Dialog(group = "Controller parameter"));
  parameter Modelica.SIunits.Power P_r = 100e6 "Rated power of the generator" annotation (
    Dialog(group = "Controller parameter"));
  parameter Real D = 4 "Droop characteristics of the generator in percentage" annotation (
    Dialog(group = "Controller parameter"));
  Modelica.Blocks.Interfaces.RealOutput P_g
    "Output power of the synchronous generator to PI controller"                                         annotation (Placement(visible = true, transformation(origin={110,-60},   extent={{-10,-10},
           {10,10}},                                                                             rotation=0)));

  Modelica.Blocks.Interfaces.RealOutput P_dy_ref "Dynamic reference output power to PI controller" annotation (Placement(visible = true, transformation(origin={110,60},    extent={{-10,-10},
           {10,10}},                                                                             rotation=0)));


  Modelica.Blocks.Interfaces.RealInput P_sg
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput f_grid
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
equation
  P_dy_ref = -(P_r/1e6)/(D/100)*((f_grid-f_ref)/(f_ref))+P_sg;
  P_g = P_sg;
  annotation (
    Documentation(info="<html>
<p>This is a simple model of the governor that controls the guide vane oppening in the turbine based on the reference power production.</p>
<p><br><br>This is a simple model of a droop controller that determines the dynamic reference power to the PI controller for generating turbine valve signal for controlling the flow.</p>
<p>The model is taken from:&nbsp;<a href=\"Resources/Report/Generator_model.pdf\">Resources/Report/Generator_model.pdf</a></p>
</html>"));
end DroopController;
