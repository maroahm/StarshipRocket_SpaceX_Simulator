with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, Util, Rocket_Stage;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, Util, Rocket_Stage;

procedure Main is

   Catastrophic_Failure: exception;

   task Flight_Computer;

   task body Flight_Computer is
      num : Natural:= 33;
   begin
      Gen_Failure.Init;
      Core_Stage_Tank:= new Propellant_Tank;
      Second_Stage_Tank := new Propellant_Tank;

      Core_Stage_Tank.Init(3400.0,700.0);
      Second_Stage_Tank.Init(1600.0,330.0);


      Core_Stage := new Stage(num);
      Core_Stage.Init("Super Heavy Booster", Core_Stage_Tank);
      for I in reverse 1..10 loop
         Printer.P(Integer'Image(I));
         delay 1.0;
      end loop;
      Core_Stage.Start_Engines;
      Printer.P("We have lift off!");
      while Core_Stage_Tank.Get_P_O > 10.0 and Core_Stage_Tank.Get_P_RF > 10.0 loop
         delay 0.2;
         Printer.P("Super Heavy Booster: Oxidizer Percentage: " &
                     Core_Stage_Tank.Get_P_O'Image);
         Printer.P("Super Heavy Booster: Rocket Fuel Percentage: " &
                     Core_Stage_Tank.Get_P_RF'Image);
         if Gen_Failure.failure then
            Core_Stage.MECO;
         end if;
      end loop;
      Core_Stage.MECO;
      delay 2.0;
      Printer.P("Successful Stage Separation");

      Second_Stage := new Stage(6);
      Second_Stage.Init("Starship", Second_Stage_Tank);

      Second_Stage.Start_Engines;
      while Second_Stage_Tank.Get_P_O >= 10.0 and
        Second_Stage_Tank.Get_P_RF >= 10.0 loop
         delay 0.2;
         Printer.P("Starship: Rocket Fuel Percentage:" & Second_Stage_Tank.Get_P_RF'Image);
         Printer.P("Starship: Oxidizer Percentage" & Second_Stage_Tank.Get_P_O'Image);
         if Gen_Failure.failure then
            Second_Stage.MECO;
         end if;
      end loop;
      Second_Stage.MECO;
      Printer.P("Successful Oribit Insertion");
   end Flight_Computer;
begin

   --  Insert code here.
   null;
end Main;
