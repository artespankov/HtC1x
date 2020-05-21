(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer;

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern;

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu;

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end;

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string;

(**** you can put all your code here ****)

(* Problem 1 *)
val only_capitals = List.filter (fn w => w <> "" andalso Char.isUpper(String.sub(w, 0)));

(* Problem 2 *)
val longest_string1 =
    List.foldl (fn(x, y) => if String.size(x) > String.size(y) then x else y) "";

(* Problem 3 *)
val longest_string2 =
    List.foldl (fn(x, y) => if String.size(x) >= String.size(y) then x else y) "";

(* Problem 4 *)
fun longest_string_helper f =
    List.foldl (fn (x,y) => if f(String.size(x),  String.size(y)) then x else y) "";
					   
val longest_string3 = longest_string_helper (fn (x,y) => x > y); 
val longest_string4 = longest_string_helper (fn (x,y) => x >= y);

(* Problem 5 *)
val longest_capitalized = longest_string1 o only_capitals;

(* Problem 6 *)
val rev_string  = String.implode o List.rev o String.explode;

(* Problem 7 *)
fun first_answer f xs =
    case xs of
	[] => raise NoAnswer
     |  x::xs' => case f(x) of
		      SOME v => v
		    | _ => first_answer f xs'
	    
(* Problem 8 *)
fun all_answers f xs =
    let fun aux (xs, acc) =
		     case xs of
			 [] => SOME acc
		      |  x::xs' => case f(x) of
					NONE => NONE
				     | SOME lst  => aux(xs', acc @ lst)
    in
	aux(xs, [])
    end;



(* Problem 9a *)
val count_wc_helper = g (fn _ => 1);

val count_wildcards  = count_wc_helper (fn _ => 0);

(* Problem 9b *)
val count_wild_and_variable_lengths = count_wc_helper (fn s => String.size s);
    
(* Problem 9c *)
fun count_some_var (s, p) = g (fn _ => 0) (fn is => if is = s then 1 else 0) p;

(* Problem 10 *)
val check_pat  =
    let
	fun p_strings p =
	    case p of
		Variable x        => [x]
	      | TupleP ps         => List.foldl (fn (p, l) => (p_strings p) @ l) [] ps
	      | ConstructorP(_,p') => p_strings p'
	      | _                 => []

	fun test ss = 
	    case ss of
		[] => true
	      | s::rss  =>  if List.exists (fn x => s = x) rss then false else test rss
    in
	test o p_strings
    end;


(* Problem 11 *)
fun match (v, p) =
    case (v, p) of
	(_, Wildcard) => SOME []
      | (v, Variable s) => SOME [(s,v)]
      | (Unit, UnitP) => SOME []
      | (Const c', ConstP c) => if c'=c then SOME [] else NONE
      | (Tuple vs, TupleP ps) => if List.length vs = List.length ps
				 then all_answers match (ListPair.zip (vs, ps))
				 else NONE
      | (Constructor (s, v), ConstructorP (s', p)) => if s = s'
						      then match (v, p)
						      else NONE
      | _ => NONE;
	    
  
(* Problem 12 *)
fun first_match v ps =
    (SOME (first_answer (fn p => match (v, p)) ps)
    handle NoAnswer => NONE)
