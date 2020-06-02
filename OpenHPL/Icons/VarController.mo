within OpenHPL.Icons;
partial class VarController "Icon for variability controller."
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={
        Text(lineColor={28,108,200},
          extent={{-130,138},{134,106}},
          textString="%name",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={238,46,47},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.None),
        Text(
          extent={{-94,70},{-46,50}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="P_ref"),
        Text(
          extent={{-92,8},{-44,-12}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="P_PV"),
        Text(
          extent={{-98,-50},{-50,-70}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="P_w"),
        Text(
          extent={{-82,94},{-34,74}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="dp"),
        Text(
          extent={{-44,94},{4,74}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="eta"),
        Text(
          extent={{-4,94},{44,74}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="C_v"),
        Text(
          extent={{36,94},{84,74}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="H_n"),
        Bitmap(extent={{-40,-66},{60,52}}, fileName=
              "modelica://OpenHPL/Resources/Images/variabilityController.svg"),
        Text(
          extent={{56,12},{104,-8}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="u_v")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end VarController;
