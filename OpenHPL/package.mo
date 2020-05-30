package OpenHPL
  extends Icons.Logo;
  import C = Modelica.Constants;
  import SI = Modelica.SIunits;

  annotation (
    version="1.1.1",
    versionDate="2020-01-09",
    Protection(access = Access.packageDuplicate),
    uses(Modelica(version="3.2.3"),PVSystems(version="0.6.3"),OpenIPSL(version="1.5.0"),WindPowerPlants(version="1.1.1"),PhotoVoltaics(version="1.3.1")),
    preferredView="info",
    Documentation(info="<html>
<p>The OpenHPL is an open-source hydropower library that
consists of hydropower unit models and is modelled using Modelica.</p>
<p>It is developed at the <a href=\"https://www.usn.no/english\">University of South-Eastern Norway (USN)</a>, Campus Porsgrunn. </p>
<p>For more information see the <a href=\"modelica://OpenHPL.UsersGuide\">User's Guide</a>.</p>
</html>"));
end OpenHPL;
