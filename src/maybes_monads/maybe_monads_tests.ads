package maybe_monad_tests is
   pragma pure;
   pragma elaborate_body;
   pragma SPARK_Mode;

   function test_maybe(i: in integer) return boolean
      with pre => i >= integer'first and i <= integer'last;

end maybe_monad_tests;
