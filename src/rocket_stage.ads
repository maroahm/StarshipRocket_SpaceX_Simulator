package Rocket_Stage is

   protected type Propellant_Tank is
      
      procedure Init(O: in Float, RF: in Float);
      procedure D_O(T: in Float);
      procedure D_RF(T: in Float);
      function Get_P_O return Float; 
      function Get_P_RF return Float;
      
   end Propellant_Tank;

end Rocket_Stage;
