package body monads is
   pragma SPARK_Mode;

   package body verification is

      function verify(x: in a; mx: in ma) return boolean is
      begin
         if retrn(x) = mx then
            return true;
         else
            return false;
         end if;
      end verify;

   end verification;

end monads;

