
generic
   type a is private;
   type b is private;
   type ma is private;
   type mb is private;
   --  return :: a -> m a
   with function return_a(x: in a) return ma;
   --  return :: b -> m b
   with function return_b(x: in b) return mb;
   -- (>>=) :: m a -> (a -> m a) -> m a
   with function bind_aa(mx: in ma; f: access function(y: in a) return ma) return ma;
   -- (>>=) :: m a -> (a -> m b) -> m b
   with function bind_ab(mx: in ma; f: access function(y: in a) return mb) return mb;
   -- (>>=) :: m b -> (b -> m a) -> m a
   with function bind_ba(mx: in mb; f: access function(y: in b) return ma) return ma;
package monads is
   pragma pure;
   pragma SPARK_Mode;
   pragma elaborate_body;

   function retrn(x: in a) return ma is (return_a(x));
   function retrn(x: in b) return mb is (return_b(x));

   function ">="(mx: in ma; f: access function(y: in a) return ma) return ma
      renames bind_aa;

   function ">="(mx: in ma; f: access function(y: in a) return mb) return mb
      renames bind_ab;

   function ">="(mx: in mb; f: access function(y: in b) return ma) return ma
      renames bind_ba;

   generic
      with function k_ab(x: in a) return mb;
      with function k_ba(x: in b) return ma;

      with function h_ab(x: in a) return mb;
      with function h_ba(x: in b) return ma;

   package verification is
      function k(x: in a) return mb is (k_ab(x));
      function k(x: in b) return ma is (k_ba(x));

      function h(x: in a) return mb is (h_ab(x));
      function h(x: in b) return ma is (h_ba(x));

      function fx(x: in a) return ma is (k(x) >= h'access);
      function fx(x: in b) return mb is (k(x) >= h'access);

      -- The monad laws must hold:
      --
      --  return a >>= k           =  k a
      --  m >>= return             =  m
      --  m >>= (\x -> k x >>= h)  =  (m >>= k) >>= h
      --
      function verify(x: in a; mx: in ma) return boolean
         with pre => (retrn(x) >= k'access) = k(x) and
                     (mx >= retrn'access) = mx and
                     (mx >= fx'access) = ((mx >= k'access) >= h'access);

   end verification;

end monads;
