(* datatypes *)
datatype UniversalChoicesType =
	 FOURTYTWO of int
	 | ZERO of int
	 | ANSWER

(* Pattern matching *)
fun cases(qe: UniversalChoicesType) =
    let
	val re1 = "true"
	val re2 = "false"
	val re3 = "undefined"
    in 
	case qe of
	    FOURTYTWO i => re1
	 |  ZERO i => re2
	 |  ANSWER => re3
    end;

datatype exp =
	 Constant of int
	 | Negate of exp
	 | Add of exp * exp
	 | Multiply of exp * exp;
	 

(* Pattern matching #2 *)
fun eval(e) =
    case e of
	 Constant(i)       => i 
       | Negate(e1)        => ~(eval e1) 
       | Add(e1, e2)       => (eval e1) + (eval e2)
       | Multiply(e1, e2)  => (eval e1) * (eval e2);


type expression = exp;

datatype suit = Club | Diamond | Heart | Spade
datatype rank = Ace | Jack | King | Num of int | Queen

type card = suit * rank
type person_name = {first: string,
		    last: string,
		    middle: string option,
		    student_num: int option}
val c1 = (Diamond, Ace)
val c2 = (Club, Queen)


fun sum_of_list(xs) = 
    case xs of
	[] => 0 
     |  x::xs' => x + sum_of_list(xs');

fun append(xs, ys) =
    case xs of
	[] => ys 
      | x::xs' => x::append(xs', ys)

(* Each of pattern *)
(* fun sum_triple(triple) =
    let
	val (x, y, z) = triple
    in
	x + y + z
    end; *)
fun sum_triple(x,y,z) =
    x + y + z;
			   
(* fun full_name(r)=
    let 
    	val {first=x, middle=y, last=z} = r
    in
	x ^ " " ^ y ^ " " ^ z
    end; *)

fun full_name({first=x, middle=y, last=z})=
    x ^ " " ^ y ^ " " ^ z;

(* NESTED PATTERNS *)

exception ListLengthMismatchError

fun zip(l1, l2, l3) =
    case (l1, l2, l3) of
	([],[],[]) => []
     |  (hl1::tl1, hl2::tl2, hl3::tl3) => (hl1,hl2,hl3)::zip(tl1, tl2, tl3)
     | _ => raise ListLengthMismatchError;

fun unzip(tl) =
    case tl of
	[] => ([], [], [])
      | (a, b, c)::tls => let val (aa, bb, cc) = unzip(tls)
			  in
			     (a::aa,b::bb,c::cc)
			  end;


fun nondecreasing xs =
    case xs of
	[] => true
      | _::[] => true
      | head::neck::tail => head < neck andalso nondecreasing(neck::tail);

datatype sgn = P | N | Z

fun multsign (x1, x2) =
    let fun sign x = if x = 0 then Z else if x > 0 then P else N
    in
	case (sign x1, sign x2) of
	    (Z, _) => Z
	  | (_, Z) => Z
	  | (P, P) => P
	  | (N, N) => P
	  | _ => N 
	(*| (N, P) => N
	  | (P, N) => N *)
    end;


fun len xs =
	case xs of
	    [] => 0
	  | _::xs' => 1 + len xs';

(* useful patterns *)
(* 
 1. a::b::c::d - match all lists with >= 3 
 2. a::b::c::[] - match all lists with 3 elements
 3. ((a,b), (c,d))::e - match all non-empty lists of pairs of pairs
  *)

(* EXCEPTIONS *)

fun hd xs =
    case xs of
	[] => raise List.Empty
      | x::_ => x;

exception MyUndesirableCondition;
exception MyOtherException of int * int;
raise MyOtherException(22,11);
fun mydiv x,y =
	    if y = 0
	    then raise MyUndesirableCondition
	    else x div y;

fun maxlist (xs, ex) =
    case xs of
	[] => raise ex
      | x::[] => x
      | x::xs' => Int.max(x, maxlist(xs', ex));

val w = maxlist ([3,4,5], MyUndesirableCondition);
val x =  maxlist ([3,4,5], MyUndesirableCondition)
	 handle MyUndesirableCondition => 42;
val y =  maxlist ([], MyUndesirableCondition)
	 handle MyUndesirableCondition => 42;
(* val z =  maxlist ([], MyUndesirableCondition); *)

(* TAIL RECURSION *)
fun fact n =
    let fun aux(n, acc) =
	    if n=0
	    then acc
	    else aux(n-1, n*acc)
    in
	aux(n, 1)
    end;


fun sum xs =
    case xs of
	[] => 0
      | x::xs' => x + sum xs';

fun sum_ xs =
    let fun aux(xs, acc) =
	    if xs => []
	     | x::xs'  = aux(xs', acc+x)	
    in
	aux(xs, 0)
    end;
	
fun rev xs =
    case xs of
	[] => []
      | x::xs' => rev(xs') @ [x];

fun rev_ xs =
    let fun aux (xs, acc) =
	    case xs of
		[] => acc 
	     | x::xs' => aux(xs', acc::x)
    in
	aux(xs, [])
    end;
