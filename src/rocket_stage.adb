with Util, Ada.Calendar;
use Util,Ada.Calendar;
package body Rocket_Stage is

   protected body Propellant_Tank is
     
      
      procedure Init(O: in Float; RF: in Float) is
      begin
         Max_O := O;
         Max_RF := RF;
         Current_O := O;
         Current_RF := RF;
      end Init;
      
      procedure D_O(T: in Float) is
         Dif : Float := 4.85 *T;
      begin
         if Current_O > Dif then
            Current_O := Current_O - Dif;
         else
            Current_O := 0.0;
         end if;
      end D_O;
      
      procedure D_RF(T: in Float) is
         Dif : Float := 1.0*T;
      begin
         if Current_RF > Dif then
            Current_RF := Current_RF - Dif;
         else
            Current_RF := 0.0;
         end if;
      end D_RF;
      
      function Get_P_O return Float is
      begin
         return (Current_O / Max_O) * 100.0;
      end Get_P_O;
      
      function Get_P_RF return Float is
      begin
         return (Current_RF / Max_RF) * 100.0;
      end Get_P_RF;
   end Propellant_Tank;
      
      
   task body Raptor_Engine is
      type PStr is access String;
      Engine_Name: PStr;
      Engine_Num:Integer;
      Engine_Tank: Tank;
      D: Duration;
      T1: Time:= Clock;
      T2:Time;
      Flight_Terminated: Boolean;
   begin
         
      accept Init(S:String; N:Integer; PT:Tank) do
         Engine_Name:= new String'(S);
         Engine_Num:= N;
         Engine_Tank:= PT;

      end Init;
         
      accept Engine_Start do
         printer.P(Engine_Name.all & " engine " & Engine_Num'Image & " is starting");
      end Engine_Start;
      loop
         select
            accept Engine_Shut_Off do
               Printer.P(Engine_Name.all & " engine " & Engine_Num'Image & " is shutting off");
               Flight_Terminated:= True;
            end Engine_Shut_Off;
            exit;
         or
            delay 0.1;
            T2:= Clock;
            if not Flight_Terminated and Engine_Tank /= null then
               D:= T2 - T1;
               Engine_Tank.D_O(Float(D));
               Engine_Tank.D_RF(Float(D));
            end if;
         end select;
         
      end loop;
   end Raptor_Engine;
   
   task body Stage is
      type Pstr is access String;
      Stage_Name: Pstr;
      Engines: Engine_Arr(1..Num_Engines);
   begin
      accept Init(S: String; PT: Tank) do
         Stage_Name:= new String'(S);
         for i in 1..Num_Engines loop
            Engines(i).Init(S, i, PT);
         end loop;
      end Init;
      accept Start_Engines do
         Printer.P("Main Engines on " & Stage_Name.all & " starting");
         for I in 1..Num_Engines loop
            Engines(I).Engine_Start;
         end loop;
      end Start_Engines;
      loop
         select 
            accept MECO do
               for I in Engines'Range loop
                  Engines(I).Engine_Shut_Off;
               end loop;
               Printer.P("Main engines on " & Stage_Name.all & " shut down");
            end MECO;
            exit;
         or
            terminate;
         end select;
               
      end loop;
   end Stage;
   
end Rocket_Stage;
