with maybes;
with maybe_monads;
with monads;

package body maybe_monads_tests is
   pragma SPARK_Mode;

   package ints is new maybes(integer); use ints;
   package bools is new maybes(boolean); use bools;

   package m_ints is new maybe_monads(ints); use m_ints;
   package m_bools is new maybe_monads(bools); use m_bools;

   package b_ib is new m_ints.binds(bools); use b_ib; -- m int -> m boolean
   package b_bi is new m_bools.binds(ints); use b_bi; -- m boolean -> m int

   function just_ab(x: in integer) return bools.maybe is (just(x /= 0));
   function just_ba(x: in boolean) return ints.maybe is (just(boolean'pos(x)));

   function nothing_ab(x: in integer with unreferenced) return bools.maybe is (nothing);
   function nothing_ba(x: in boolean with unreferenced) return ints.maybe is (nothing);

   package monad_laws is new monads(a => integer,
                                    b => boolean,
                                    ma => ints.maybe,
                                    mb => bools.maybe,
                                    return_a => m_ints.mreturn,
                                    return_b => m_bools.mreturn,
                                    bind_aa => m_ints.">=",
                                    bind_ab => b_ib.">=",
                                    bind_ba => b_bi.">=");

   function test_maybe(i: in integer) return boolean is
      pragma SPARK_Mode;
      package laws1 is new monad_laws.verification(just_ab, nothing_ba, nothing_ab, just_ba);
      package laws2 is new monad_laws.verification(nothing_ab, just_ba, just_ab, nothing_ba);
   begin
      return laws1.verify(i, just(i)) and
             laws2.verify(i, just(i));
   end test_maybe;

end maybe_monads_tests;
