type resultexn<'a> = result<'a, exn>

//when res is Ok('n) returns 'n, when res is Error('exn), raise an 'exn
@inline
let getExn: resultexn<'a> => 'a

exception ResultIsNotAnError
//when res is Ok(_) raises ResultIsNotAnError, when res is Error(exn) return exn
@inline
let getErr: resultexn<'a> => exn

//when res is Ok('n), returns f('n), otherwise default.
@inline
let mapWithDefault: (resultexn<'a>, 'b, 'a => 'b) => 'b

//mapWithDefault, but with uncurried function
@inline
let mapWithDefaultU: (resultexn<'a>, 'b, (. 'a) => 'b) => 'b

//When res is Ok(n), returns Ok(f(n)). Otherwise returns res unchanged.
//Function f takes a value of the same type as n and returns an ordinary value.
@inline
let map: (resultexn<'a>, 'a => 'b) => resultexn<'b>

//When r1 is Ok('a) and r2 is Ok('b) returns Ok(f('a, 'b)). Otherwise returns Error(exn).
@inline
let map2: (resultexn<'a>, resultexn<'b>, ('a, 'b) => 'c) => resultexn<'c>

//When r1 is Ok('a) and r2 is Ok('b) and r3 is (Ok('c)) returns Ok(f('a, 'b, 'c)).
//Otherwise returns Error(exn) (exception of first error parameter meets).
@inline
let map3: (resultexn<'a>, resultexn<'b>, resultexn<'c>, ('a, 'b, 'c) => 'd) => resultexn<'d>

//When all parameters 'a, 'b, 'c, 'd is Ok returns Ok(f('a, 'b, 'c, 'd)).
//Otherwise returns Error(exn) (exception of first error parameter meets).
@inline
let map4: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  resultexn<'d>,
  ('a, 'b, 'c, 'd) => 'e,
) => resultexn<'e>

//map, but with uncurried function
@inline
let mapU: (resultexn<'a>, (. 'a) => 'b) => resultexn<'b>

//Async version of mapU function
@inline
let mapUAsync: (resultexn<'a>, (. 'a) => promise<'b>) => promise<resultexn<'b>>

//Async version of map function
@inline
let mapAsync: (resultexn<'a>, 'a => promise<'b>) => promise<resultexn<'b>>

//Async version of map2 function
@inline
let map2Async: (resultexn<'a>, resultexn<'b>, ('a, 'b) => promise<'c>) => promise<resultexn<'c>>

//Async version of map3 function
@inline
let map3Async: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  ('a, 'b, 'c) => promise<'d>,
) => promise<resultexn<'d>>

//Async version of map4 function
@inline
let map4Async: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  resultexn<'d>,
  ('a, 'b, 'c, 'd) => promise<'e>,
) => promise<resultexn<'e>>

//When res is Ok('n), returns f('n). Otherwise, returns res unchanged.
//Function f takes a value of the same type as 'n and returns a resultexn<'b>
@inline
let flatMap: (resultexn<'a>, 'a => resultexn<'b>) => resultexn<'b>

//When r1 is Ok('a), r2 is Ok('b) return f('a, 'b). Otherwise return Error(exn) (- first exn param)
@inline
let flatMap2: (resultexn<'a>, resultexn<'b>, ('a, 'b) => resultexn<'c>) => resultexn<'c>

//When r1 is Ok('a), r2 is Ok('b) and r3 is Ok('c) return f('a, 'b, 'c).
//Otherwise return Error(exn) (- first exn param)
@inline
let flatMap3: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  ('a, 'b, 'c) => resultexn<'d>,
) => resultexn<'d>

//When r1 is Ok('a), r2 is Ok('b), r3 is Ok('c) and r4 is Ok('d) return f('a, 'b, 'c, 'd).
//Otherwise return Error(exn) (- first exn param)
@inline
let flatMap4: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  resultexn<'d>,
  ('a, 'b, 'c, 'd) => resultexn<'e>,
) => resultexn<'e>

//flatMap, but with uncurried function
@inline
let flatMapU: (resultexn<'a>, (. 'a) => resultexn<'b>) => resultexn<'b>

//Async version of flatMapU function
@inline
let flatMapUAsync: (resultexn<'a>, (. 'a) => promise<resultexn<'b>>) => promise<resultexn<'b>>

//Async version of flatMap function
@inline
let flatMapAsync: (resultexn<'a>, 'a => promise<resultexn<'b>>) => promise<resultexn<'b>>

//Async version of flatMap2 function
@inline
let flatMap2Async: (
  resultexn<'a>,
  resultexn<'b>,
  ('a, 'b) => promise<resultexn<'c>>,
) => promise<resultexn<'c>>

//Async version of flatMap3 function
@inline
let flatMap3Async: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  ('a, 'b, 'c) => promise<resultexn<'d>>,
) => promise<resultexn<'d>>

//Async version of flatMap4 function
@inline
let flatMap4Async: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  resultexn<'d>,
  ('a, 'b, 'c, 'd) => promise<resultexn<'e>>,
) => promise<resultexn<'e>>

//If res is Ok('n), returns 'n, otherwise default
@inline
let getWithDefault: (resultexn<'a>, 'a) => 'a

//Returns true if res is of the form Ok('n), false if it is the Error('e) variant.
@inline
let isOk: resultexn<'a> => bool

//Returns true if res is of the form Error(e), false if it is the Ok(n) variant.
@inline
let isError: resultexn<'a> => bool

//converts array<resultexn<'a>> to resultexn<array<'a>>
let lift: array<resultexn<'a>> => resultexn<array<'a>>

exception TryToGettingResultFromNone
//Converts option<'a> to result<'a, exn>
@inline
let fromSome: option<'a> => resultexn<'a>

exception UnexpectedSomeValue(string)
//Converts option<'a> to result<unit, exn>
@inline
let fromNone: option<'a> => resultexn<unit>

//Converts result<'a, exn> to option<'a>
@inline
let okToOption: resultexn<'a> => option<'a>

//Converts result<'a, exn> to option<exn>
@inline
let errToOption: resultexn<'a> => option<exn>

//Exectes the function f: 'a => 'b and catching and wrapping raised errors to Error(exn)
@inline
let tryExec: (unit => 'a) => resultexn<'a>

//Exectes the function f: 'a => result<'b, exn> and catching and wrapping raised errors to Error(exn)
@inline
let tryExecFlat: (unit => resultexn<'a>) => resultexn<'a>

//Promise will return result<'a, exn> where exn is catched exception
@inline
let thenTry: promise<'a> => promise<resultexn<'a>>

//Catches extra exceptions, which will happens at promise<result<'a, exn>> execution
@inline
let thenTryFlat: promise<resultexn<'a>> => promise<resultexn<'a>>

//Converts promise<result<'a, exn>> with throwable function and catch exception into Error
@inline
let thenTryMap: (promise<resultexn<'a>>, 'a => 'b) => promise<resultexn<'b>>

//Converts promise<result<'a, exn>> with throwable resulting function and catch exception into Error
@inline
let thenTryFlatMap: (promise<resultexn<'a>>, 'a => resultexn<'b>) => promise<resultexn<'b>>

//Chains promise<result<'a, exn>> with 'a => promise<'b> map funciton
@inline
let thenTryMapAsync: (promise<resultexn<'a>>, 'a => promise<'b>) => promise<resultexn<'b>>

//Chains promise<result<'a, exn>> with 'a => promise<result<'b, exn>> map funciton
@inline
let thenTryFlatMapAsync: (
  promise<resultexn<'a>>,
  'a => promise<resultexn<'b>>,
) => promise<resultexn<'b>>
