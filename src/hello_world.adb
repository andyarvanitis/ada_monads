with maybe_monad_tests; use maybe_monad_tests;
with text_io; use text_io;


procedure hello_world is
   pragma SPARK_Mode;
begin
   put_line(test_maybe(1)'image);
   put_line("Done.");
end hello_world;
