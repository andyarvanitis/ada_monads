with text_io; use text_io;
with maybes;
with maybe_monads;

package body examples_maybe is

   package ints is new maybes(integer); use ints;
   package m_ints is new maybe_monads(ints); use m_ints;

   procedure run is
      n: constant integer := 5;
      result: ints.maybe;
      function decr(x: integer) return ints.maybe is (if x > 0 then just(x - 1) else nothing);
   begin
      new_line;
      put_line("Started running example...");

      result := (just(n) >= decr'access) >= decr'access;

      case result.value is
         when e_just =>
            put("just");
            put_line(result.data'image);
         when e_nothing =>
            put_line("nothing");
      end case;

      --  Alternatively:
      --  put_line(result'image);

      put_line("Finished running.");
   end run;

end examples_maybe;
