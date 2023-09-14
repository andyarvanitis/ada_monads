with maybes;

generic
   with package a is new maybes (<>); use a;
package maybe_monads is
   pragma pure;

   --  return :: a -> m a
   function mreturn(x: in a.t) return a.maybe is (just(x));

   generic
      with package b is new maybes (<>); use b;
   package binds is
      function ">="(mx: in a.maybe;
                     f: not null access function(x: in a.t) return b.maybe)
               return b.maybe is
         (case mx.kind is
            when e_just => f(mx.data),
            when e_nothing => nothing);
   end binds;

   package bind_a_a is new binds(b => a);

   -- (>>=) :: m a -> (a -> m a) -> m a
   function ">="(mx: in a.maybe;
                  f: not null access function(x: in a.t) return a.maybe)
            return a.maybe
      renames bind_a_a.">=";

end maybe_monads;
