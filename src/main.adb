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
      for I in reverse 10..1 loop
         Printer.P(I'Image);
         delay 1.0;
      end loop;
      Core_Stage.Start_Engines;
      Printer.P("We have lift off!");
   end Flight_Computer;
begin

   --  Insert code here.
   null;
end Main;
