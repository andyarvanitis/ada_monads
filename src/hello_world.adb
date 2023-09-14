with maybe_monads_tests; use maybe_monads_tests;
with text_io; use text_io;
with examples_maybe;


procedure hello_world is
   pragma SPARK_Mode;
begin
   put_line(test_maybe(1)'image);
   put_line("Done.");

   examples_maybe.run;

end hello_world;
