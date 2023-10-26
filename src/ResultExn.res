open Belt

type resultexn<'a> = result<'a, exn>

//when res is Ok('n) returns 'n, when res is Error('exn), raise an 'exn
@inline
let getExn = (r: resultexn<'a>): 'a =>
  switch r {
  | Ok(x) => x
  | Error(e) => raise(e)
  }

exception ResultIsNotAnError

//when res is Ok(_) raises ResultIsNotAnError, when res is Error(exn) return exn
@inline
let getErr = (r: resultexn<'a>): exn =>
  switch r {
  | Ok(_) => raise(ResultIsNotAnError)
  | Error(e) => e
  }

//when res is Ok('n), returns f('n), otherwise default.
@inline
let mapWithDefault = (r: resultexn<'a>, b: 'b, f: 'a => 'b): 'b => Result.mapWithDefault(r, b, f)

//mapWithDefault, but with uncurried function
@inline
let mapWithDefaultU = (r: resultexn<'a>, b: 'b, f: (. 'a) => 'b): 'b =>
  Result.mapWithDefaultU(r, b, f)

//When res is Ok(n), returns Ok(f(n)). Otherwise returns res unchanged.
//Function f takes a value of the same type as n and returns an ordinary value.
@inline
let map = (r: resultexn<'a>, f: 'a => 'b): resultexn<'b> => Result.map(r, f)

//When r1 is Ok('a) and r2 is Ok('b) returns Ok(f('a, 'b)). Otherwise returns Error(exn).
@inline
let map2 = (r1: resultexn<'a>, r2: resultexn<'b>, f: ('a, 'b) => 'c): resultexn<'c> =>
  switch (r1, r2) {
  | (Ok(ok1), Ok(ok2)) => Ok(f(ok1, ok2))
  | (Error(e), _) => Error(e)
  | (_, Error(e)) => Error(e)
  }

//When r1 is Ok('a) and r2 is Ok('b) and r3 is (Ok('c)) returns Ok(f('a, 'b, 'c)).
//Otherwise returns Error(exn) (exception of first error parameter meets).
@inline
let map3 = (
  r1: resultexn<'a>,
  r2: resultexn<'b>,
  r3: resultexn<'c>,
  f: ('a, 'b, 'c) => 'd,
): resultexn<'d> =>
  switch (r1, r2, r3) {
  | (Ok(ok1), Ok(ok2), Ok(ok3)) => Ok(f(ok1, ok2, ok3))
  | (Error(e), _, _) => Error(e)
  | (_, Error(e), _) => Error(e)
  | (_, _, Error(e)) => Error(e)
  }

//When all parameters 'a, 'b, 'c, 'd is Ok returns Ok(f('a, 'b, 'c, 'd)).
//Otherwise returns Error(exn) (exception of first error parameter meets).
@inline
let map4 = (
  r1: resultexn<'a>,
  r2: resultexn<'b>,
  r3: resultexn<'c>,
  r4: resultexn<'d>,
  f: ('a, 'b, 'c, 'd) => 'e,
): resultexn<'e> =>
  switch (r1, r2, r3, r4) {
  | (Ok(ok1), Ok(ok2), Ok(ok3), Ok(ok4)) => Ok(f(ok1, ok2, ok3, ok4))
  | (Error(e), _, _, _) => Error(e)
  | (_, Error(e), _, _) => Error(e)
  | (_, _, Error(e), _) => Error(e)
  | (_, _, _, Error(e)) => Error(e)
  }

//map, but with uncurried function
@inline
let mapU = (r: resultexn<'a>, f: (. 'a) => 'b): resultexn<'b> => Result.mapU(r, f)

//When res is Ok('n), returns f('n). Otherwise, returns res unchanged.
//Function f takes a value of the same type as 'n and returns a resultexn<'b>
@inline
let flatMap = (r: resultexn<'a>, f: 'a => resultexn<'b>): resultexn<'b> => Result.flatMap(r, f)

//When r1 is Ok('a), r2 is Ok('b) return f('a, 'b). Otherwise return Error(exn) (- first exn param)
@inline
let flatMap2 = (r1: resultexn<'a>, r2: resultexn<'b>, f: ('a, 'b) => resultexn<'c>): resultexn<
  'c,
> =>
  switch (r1, r2) {
  | (Ok(ok1), Ok(ok2)) => f(ok1, ok2)
  | (Error(e), _) => Error(e)
  | (_, Error(e)) => Error(e)
  }

//When r1 is Ok('a), r2 is Ok('b) and r3 is Ok('c) return f('a, 'b, 'c).
//Otherwise return Error(exn) (- first exn param)
@inline
let flatMap3 = (
  r1: resultexn<'a>,
  r2: resultexn<'b>,
  r3: resultexn<'c>,
  f: ('a, 'b, 'c) => resultexn<'d>,
): resultexn<'d> =>
  switch (r1, r2, r3) {
  | (Ok(ok1), Ok(ok2), Ok(ok3)) => f(ok1, ok2, ok3)
  | (Error(e), _, _) => Error(e)
  | (_, Error(e), _) => Error(e)
  | (_, _, Error(e)) => Error(e)
  }

//When r1 is Ok('a), r2 is Ok('b), r3 is Ok('c) and r4 is Ok('d) return f('a, 'b, 'c, 'd).
//Otherwise return Error(exn) (- first exn param)
@inline
let flatMap4 = (
  r1: resultexn<'a>,
  r2: resultexn<'b>,
  r3: resultexn<'c>,
  r4: resultexn<'d>,
  f: ('a, 'b, 'c, 'd) => resultexn<'e>,
): resultexn<'e> =>
  switch (r1, r2, r3, r4) {
  | (Ok(ok1), Ok(ok2), Ok(ok3), Ok(ok4)) => f(ok1, ok2, ok3, ok4)
  | (Error(e), _, _, _) => Error(e)
  | (_, Error(e), _, _) => Error(e)
  | (_, _, Error(e), _) => Error(e)
  | (_, _, _, Error(e)) => Error(e)
  }

//flatMap, but with uncurried function
@inline
let flatMapU = (r: resultexn<'a>, f: (. 'a) => resultexn<'b>): resultexn<'b> =>
  Result.flatMapU(r, f)

//If res is Ok('n), returns 'n, otherwise default
@inline
let getWithDefault = (r: resultexn<'a>, def: 'a): 'a => Result.getWithDefault(r, def)

//Returns true if res is of the form Ok('n), false if it is the Error('e) variant.
@inline
let isOk = (r: resultexn<'a>): bool => Result.isOk(r)

//Returns true if res is of the form Error(e), false if it is the Ok(n) variant.
@inline
let isError = (r: resultexn<'a>): bool => Result.isError(r)

//converts array<resultexn<'a>> to resultexn<array<'a>>
let lift = (r: array<resultexn<'a>>): resultexn<array<'a>> => {
  let errors = r->Js.Array2.filter(el => isError(el))
  if Array.length(errors) > 0 {
    Error(errors[0]->Option.getExn->getErr)
  } else {
    Ok(Array.map(r, el => el->getExn))
  }
}

exception TryToGettingResultFromNone

//Converts option<'a> to result<'a, exn>
@inline
let fromSome = (o: option<'a>): resultexn<'a> =>
  switch o {
  | None => Error(TryToGettingResultFromNone)
  | Some(x) => Ok(x)
  }

exception UnexpectedSomeValue(string)

//Converts option<'a> to result<unit, exn>
@inline
let fromNone = (o: option<'a>): resultexn<unit> =>
  switch o {
  | None => Ok()
  | Some(x) => Error(UnexpectedSomeValue(Js.Json.stringifyAny(x)->Option.getWithDefault("")))
  }

//Converts result<'a, exn> to option<'a>
@inline
let okToOption = (r: resultexn<'a>): option<'a> =>
  switch r {
  | Ok(x) => Some(x)
  | Error(_) => None
  }

//Converts result<'a, exn> to option<exn>
@inline
let errToOption = (r: resultexn<'a>): option<exn> =>
  switch r {
  | Ok(_) => None
  | Error(e) => Some(e)
  }

//Exectes the function f: 'a => 'b and catching and wrapping raised errors to Error(exn)
@inline
let catchExn = (f: unit => 'a): resultexn<'a> =>
  switch f() {
  | x => Ok(x)
  | exception e => Error(e)
  }

//Exectes the function f: 'a => result<'b, exn> and catching and wrapping raised errors to Error(exn)
@inline
let catchResult = (f: unit => resultexn<'a>): resultexn<'a> =>
  switch f() {
  | x => x
  | exception e => Error(e)
  }
