within OpenHPL.Renewables.HydroPlants;
model HydroEuler "A hydro power plant with euler turbine."
parameter Modelica.SIunits.Length H_n = 25 "Nominal head of the hydro plant" annotation (
    Dialog(group = "Turbine nominal rating"));
    parameter Modelica.SIunits.VolumeFlowRate Vdot_n = 25 "Nominal discharge of the hydro plant" annotation (
    Dialog(group = "Turbine nominal rating"));
    parameter Real u_n = 0.95 "Nominal turbine valve signal" annotation (
    Dialog(group = "Turbine nominal rating"));
    parameter Real eta_h = 0.9 "Hydarulic efficiency of the turbine" annotation (
    Dialog(group = "Turbine nominal rating"));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Bitmap(extent={{-60,-58},{60,58}}, fileName=
              "modelica://OpenHPL/Resources/Images/HydroPlants.svg"),
        Text(
          extent={{-110,18},{-46,-14}},
          lineColor={28,108,200},
          textString="u_v"),
        Text(
          extent={{50,14},{108,-14}},
          lineColor={28,108,200},
          textString="P_h"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          lineThickness=0.5),
        Text(
          extent={{-72,168},{72,106}},
          lineColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
            false)));
end HydroEuler;
