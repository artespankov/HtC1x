(*
	sum : T1 -> T2
	xs: T1

	x: T3
	xs': T3 list 
	T2 = int [because 0 might be returned]
	T3 = int [because x:T3 and we add x to something]
	from T1 = T3 list and T3 = int, we know T1 = int list
	from that and T2 = int, we know f: int list -> int
*)


fun sum xs =
    case xs of
	[] => 0
      | x::xs' => x + (sum xs');

(* Polymorphic functions *)

(* 
  length : T1 -> T2
  xs: T1
 
  x: T3
  xs': T3 list

  T1 = T3 list
  T2 = int

  T3 list -> int
  'a list -> int
*)

fun length xs =
    case xs of
	[] => 0
      | x::xs' => 1 + (length xs');


(* 
   f: T1 * T2 * T3 -> T4
   x: T1
   y: T2
   z: T3

   T4 = T1 * T2 * T3
   T4 = T2 * T1 * T3

   only way those can be true is if T1 = T2
   put it all together: f: T1 * T1 * T3 -> T1 * T1 * T3
   'a * 'a * 'b -> 'a * 'a * 'b
*)
fun f (x,y,z) =
    if true
    then (x,y,z)
    else (y,x,z);

(*
 compose: T1 * T2 -> T3
 f: T1
 g: T2
 x: T4

 body being a function has type T3 = T4 -> T5
 from g being passed x, T2 = T4 -> T6 for some T6
 from f being passed the result of g, T1 = T6 -> T7 for some T7
 from call to f being the body of anonymous function T7 = T5

 put it all together: T1 = T6 -> T5, T2 = T4 -> T6, T3 = T4 -> T5
 (T6 -> T5) * (T4 -> T6) -> (T4 -> T5)
 ('a -> 'b) * ('c -> 'a) -> ('c -> 'b)
 *)
fun compose (f,g) = fn x => f (g x);

(* Mutual recusrsion | functions *)
(* FSM - Finite State Machine *)

fun state1 input_left = ()
and state2 input_left = ();

fun match xs = (* The sequence should match patter 1,2,1,2, so pairs + start with 1 and end with 2 - [1, 2, 1, 2, 1, 2]*)
    let fun s_need_one xs =
	    case xs of
		[] => true
	      | 1::xs' => s_need_two xs'
	      | _ => false
	and s_need_two xs =
	    case xs of
		[] => false
	      | 2::xs' => s_need_one xs'
	      | _ => false
    in
	s_need_one xs
    end;

(* Mutual recusrsion | datatypes *)

datatype t1 = Foo of int | Bar of t2
     and t2 = Baz of string | Quux of t1;

fun no_zeros_or_empty_strings_t1 x =
    case x of
	Foo i => i <>0
      | Bar y  => no_zeros_or_empty_strings_t2 y
and no_zeros_or_empty_strings_t2 x =
    case x of
	Baz s => size s > 0
      | Quux y => no_zeros_or_empty_strings_t1 y;


(* 
   fun earlier (f,x) = ... f y ...
   fun later x = earlier (later, x) ...
*)

(* Modules *)
structure MyMathLib =

struct
val half_pi  = Math.pi / 2.0;
fun doubler y = y + y;
fun fact x =
    if x =0
    then 1
    else x * fact(x-1);
end;


val pi = MyMathLib.half_pi + MyMathLib.half_pi;

(* Signature (sig of Module) *)

signature MATHLIB =
sig
    val fact : int -> int
    val half_pi : real
    (* PRIVATE DEFINITION - could be used wihtin the module only, not defined on module signature *)
    (* val doubler : int -> int *)
end

structure MyMathLib :> MATHLIB =
struct
val half_pi  = Math.pi / 2.0;
fun doubler y = y + y;
fun fact x =
    if x =0
    then 1
    else x * fact(x-1);
end;



signature RATIONAL_A =
sig
    type rational
    (*abstract rational type definition instead of explicit to hide the signature *)
    (* datatype rational = Whole of int | Frac of int * int *)
    exception BadFrac
    val make_frac: int * int -> rational
    val add: rational * rational -> rational
    val toString: rational -> string

    (* explicit Whole exposition *)
    val Whole: int -> rational
end;

structure Rational1 :> RATIONAL_A =
struct
  datatype rational = Whole of int | Frac of int*int
  exception BadFrac

  (*internal*)

  fun gcd (x, y) =
      if x=y
      then x
      else
	  if x < y
	  then gcd(x, y-x)
	  else gcd(y, x);

  fun reduce r =
      case r of
	  Whole _ => r
	| Frac(x,y) =>
	  if x=0
	  then Whole 0
	  else
	      let val d = gcd(abd x,y) in
		  if d=y
		  then Whole(x div d);
(* instantiates the rational *)	      
fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce(Frac(~x,~y))
    else reduce(Frac(x,y));
		       
fun add (r1, r2) =
    case (r1, r2) of
	(Whole(i), Whole(j)) => Whole(i+j)
      | (Whole(i), Frac(j,k)) => Frac(j+k*i, k)
      | (Frac(j,k), Whole(i)) => Frac(j+k*i, k)
      | (Frac(a,b), Frac(c,d)) => reduce (Frac(a*d + b*c, b*d));

fun toString r =
    case r of
	Whole(i) => Int.toString i
      | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b);
				 

	
						       
	  
	
