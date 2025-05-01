with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

package Util is

   protected Printer is
      procedure P(S: in String:="");
   end Printer;
   
   protected Gen_Failure is
      procedure Init;
      function Generate return Float;
      function failure return Boolean;
   private
      G: Generator;
   end Gen_Failure;

end Util;
