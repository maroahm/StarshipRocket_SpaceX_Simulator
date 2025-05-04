package Rocket_Stage is

   protected type Propellant_Tank is
      
      procedure Init(O: in Float; RF: in Float);
      procedure D_O(T: in Float);
      procedure D_RF(T: in Float);
      function Get_P_O return Float; 
      function Get_P_RF return Float;
      
   private
       Max_O: Float := 0.0;
      Max_RF: Float:=0.0;
      Current_O:Float:=0.0;
      Current_RF: Float:=0.0;
      
   end Propellant_Tank;
   
   type Tank is access Propellant_Tank;
   Core_Stage_Tank, Second_Stage_Tank: Tank;
   
   
   task type Raptor_Engine is
      entry Init(S:String; N:Integer; PT:Tank);
      entry Engine_Start;
      entry Engine_Shut_Off;
   end Raptor_Engine;
   
   type Engine_Arr is array (Natural range <>) of Raptor_Engine;
   
   task type Stage(Num_Engines: Natural) is
      entry Init(S: String; PT: Tank);
      entry Start_Engines;
      entry MECO;
   end Stage;
   
   type En_Stage is access Stage;
   
   Core_Stage, Second_Stage: En_Stage;

end Rocket_Stage;
