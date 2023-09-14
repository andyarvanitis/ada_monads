generic
   type t is private;
package maybes is
   pragma pure;

   type kinds is (e_nothing, e_just);

   type maybe(kind: kinds := e_nothing) is record
      case kind is
         when e_nothing => null;
         when e_just => 
            data: t;
      end case;
   end record;

   -- Data constructors

   function nothing return maybe is (kind => e_nothing);

   function just(x: in t) return maybe is (maybe'(e_just, x));

   -- Utility functions

   function is_nothing(m: in maybe) return boolean is (m.kind = e_nothing);

   function is_just(m: in maybe) return boolean is (m.kind = e_just);

   function from_just(m: in maybe) return t is (m.data)
      with pre => m.kind = e_just;

end maybes;
