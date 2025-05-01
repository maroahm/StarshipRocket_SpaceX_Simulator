package body Rocket_Stage is

   protected type Propellant_Tank is
      Max_O: Float := 0.0;
      Max_RF: Float:=0.0;
      Current_O:Float:=0.0;
      Current_RF: Float:=0.0;
      
      procedure Init(O: in Float, RF: in Float) is
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
         end if
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
         return (Current_RF / Max_RF) * 100.0;
      end Propellant_Tank;
      
      
      task body Raptor_Engine is
         type PStr is access String;
         name: PStr;
      begin
         
         

end Rocket_Stage;
