with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package body Util is

   protected body Printer is
      procedure P(S: in String :="") is
      begin
         Put_Line(S);
      end P;
   end Printer;
   
   protected body Gen_Failure is
   
      procedure Init is
      begin
         Reset(G);
      end Init;
      
      function Generate return Float is
      begin
         return Random(G);
      end Generate;
      
      function failure return Boolean is
      begin
         if Random(G) < 0.0001 then
            return True;
         else
            return false;
         end if;
      end failure;
   end Gen_Failure;

end Util;
