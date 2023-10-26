# rescript-result-exn
Provides api for result&lt;'a, exn> type.
Extends Belt.Result api, and adds more functions for converting reult with option monads
and catching exceptions from throwable functions and wrapping them to Error(exn).

## Api

#### ResultExn.resi
```rescript
type resultexn<'a> = result<'a, exn>

//when res is Ok('n) returns 'n, when res is Error('exn), raise an 'exn
let getExn: resultexn<'a> => 'a

exception ResultIsNotAnError
//when res is Ok(_) raises ResultIsNotAnError, when res is Error(exn) return exn
let getErr: resultexn<'a> => exn

//when res is Ok('n), returns f('n), otherwise default.
let mapWithDefault: (resultexn<'a>, 'b, 'a => 'b) => 'b

//mapWithDefault, but with uncurried function
let mapWithDefaultU: (resultexn<'a>, 'b, (. 'a) => 'b) => 'b

//When res is Ok(n), returns Ok(f(n)). Otherwise returns res unchanged.
//Function f takes a value of the same type as n and returns an ordinary value.
let map: (resultexn<'a>, 'a => 'b) => resultexn<'b>

//When r1 is Ok('a) and r2 is Ok('b) returns Ok(f('a, 'b)). Otherwise returns Error(exn).
let map2: (resultexn<'a>, resultexn<'b>, ('a, 'b) => 'c) => resultexn<'c>

//When r1 is Ok('a) and r2 is Ok('b) and r3 is (Ok('c)) returns Ok(f('a, 'b, 'c)).
//Otherwise returns Error(exn) (exception of first error parameter meets).
let map3: (resultexn<'a>, resultexn<'b>, resultexn<'c>, ('a, 'b, 'c) => 'd) => resultexn<'d>

//When all parameters 'a, 'b, 'c, 'd is Ok returns Ok(f('a, 'b, 'c, 'd)).
//Otherwise returns Error(exn) (exception of first error parameter meets).
let map4: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  resultexn<'d>,
  ('a, 'b, 'c, 'd) => 'e,
) => resultexn<'e>

//map, but with uncurried function
let mapU: (resultexn<'a>, (. 'a) => 'b) => resultexn<'b>

//When res is Ok('n), returns f('n). Otherwise, returns res unchanged.
//Function f takes a value of the same type as 'n and returns a resultexn<'b>
let flatMap: (resultexn<'a>, 'a => resultexn<'b>) => resultexn<'b>

//When r1 is Ok('a), r2 is Ok('b) return f('a, 'b). Otherwise return Error(exn) (- first exn param)
let flatMap2: (resultexn<'a>, resultexn<'b>, ('a, 'b) => resultexn<'c>) => resultexn<'c>

//When r1 is Ok('a), r2 is Ok('b) and r3 is Ok('c) return f('a, 'b, 'c).
//Otherwise return Error(exn) (- first exn param)
let flatMap3: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  ('a, 'b, 'c) => resultexn<'d>,
) => resultexn<'d>

//When r1 is Ok('a), r2 is Ok('b), r3 is Ok('c) and r4 is Ok('d) return f('a, 'b, 'c, 'd).
//Otherwise return Error(exn) (- first exn param)
let flatMap4: (
  resultexn<'a>,
  resultexn<'b>,
  resultexn<'c>,
  resultexn<'d>,
  ('a, 'b, 'c, 'd) => resultexn<'e>,
) => resultexn<'e>

//flatMap, but with uncurried function
let flatMapU: (resultexn<'a>, (. 'a) => resultexn<'b>) => resultexn<'b>

//If res is Ok('n), returns 'n, otherwise default
let getWithDefault: (resultexn<'a>, 'a) => 'a

//Returns true if res is of the form Ok('n), false if it is the Error('e) variant.
let isOk: resultexn<'a> => bool

//Returns true if res is of the form Error(e), false if it is the Ok(n) variant.
let isError: resultexn<'a> => bool

//converts array<resultexn<'a>> to resultexn<array<'a>>
let lift: array<resultexn<'a>> => resultexn<array<'a>>

exception TryToGettingResultFromNone
//Converts option<'a> to result<'a, exn>
let fromSome: option<'a> => resultexn<'a>

exception UnexpectedSomeValue(string)
//Converts option<'a> to result<unit, exn>.
//Some will be converted to Error(UnexpectedSomeValue(value converted to JSON))
let fromNone: option<'a> => resultexn<unit>

//Converts result<'a, exn> to option<'a>
let okToOption: resultexn<'a> => option<'a>

//Converts result<'a, exn> to option<exn>
let errToOption: resultexn<'a> => option<exn>

//Exectes the function and catching and wrapping raised errors to Error(exn)
let catchExn: (unit => 'a) => resultexn<'a>

//Exectes the function and catching and wrapping raised errors to Error(exn)
let catchResult: (unit => resultexn<'a>) => resultexn<'a>
```


## License
MIT
Uses lot of Belt package of rescript, thats is licensed under LGPL version 3


## Author
Anatoly Starodubtsev
tostar74@mail.ru

Uses lot of Belt package of rescript, thats had been created by Hongbo Zhang.

Original Belt's api and list of authors and contributors may been found of site: 
https://rescript-lang.org/docs/manual/latest/api/belt