open RescriptMocha
open Mocha

exception TestExn

describe("test ResultExn", () => {
  describe("test getExn", () => {
    it(
      "positive",
      () => {
        let given = Ok("sadk")
        let nominal = "sadk"
        Assert.equal(given->ResultExn.getExn, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given: ResultExn.resultexn<string> = Error(TestExn)
        let nominal = TestExn
        switch given->ResultExn.getExn {
        | _ => raise(TestExn)
        | exception e => Assert.deep_equal(e, nominal)
        }
      },
    )
  })

  describe("test getErr", () => {
    it(
      "positive",
      () => {
        let given: ResultExn.resultexn<string> = Ok("sadk")
        try {
          let _ = given->ResultExn.getErr
          raise(TestExn)
        } catch {
        | ResultExn.ResultIsNotAnError => Assert.ok(true)
        | _ => raise(TestExn)
        }
      },
    )
    it(
      "negative",
      () => {
        let given = Error(TestExn)
        let nominal = TestExn
        Assert.deep_equal(given->ResultExn.getErr, nominal)
      },
    )
  })

  describe("test map", () => {
    it(
      "positive",
      () => {
        let given = Ok(12)
        let nominal = Ok(24)
        let result = ResultExn.map(given, x => x * 2)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given = Error(TestExn)
        let nominal = Error(TestExn)
        let result = ResultExn.map(given, x => x * 2)
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test map2", () => {
    it(
      "positive",
      () => {
        let given1 = Ok(12)
        let given2 = Ok(7)
        let nominal = Ok(19)
        let result = ResultExn.map2(given1, given2, (x, y) => x + y)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 1",
      () => {
        let given1 = Error(TestExn)
        let given2 = Ok(7)
        let nominal = Error(TestExn)
        let result = ResultExn.map2(given1, given2, (x, y) => x + y)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 2",
      () => {
        let given2 = Error(TestExn)
        let given1 = Ok(7)
        let nominal = Error(TestExn)
        let result = ResultExn.map2(given1, given2, (x, y) => x + y)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 3",
      () => {
        let given2 = Error(TestExn)
        let given1 = Error(TestExn)
        let nominal = Error(TestExn)
        let result = ResultExn.map2(given1, given2, (x, y) => x + y)
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test map3", () => {
    it(
      "positive",
      () => {
        let given1 = Ok(12)
        let given2 = Ok(7)
        let given3 = Ok(3)
        let nominal = Ok(22)
        let result = ResultExn.map3(given1, given2, given3, (x, y, z) => x + y + z)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 1",
      () => {
        let given1 = Error(TestExn)
        let given2 = Ok(7)
        let given3 = Ok(3)
        let nominal = Error(TestExn)
        let result = ResultExn.map3(given1, given2, given3, (x, y, z) => x + y + z)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 2",
      () => {
        let given1 = Ok(12)
        let given2 = Error(TestExn)
        let given3 = Ok(3)
        let nominal = Error(TestExn)
        let result = ResultExn.map3(given1, given2, given3, (x, y, z) => x + y + z)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 3",
      () => {
        let given1 = Error(TestExn)
        let given2 = Ok(7)
        let given3 = Error(TestExn)
        let nominal = Error(TestExn)
        let result = ResultExn.map3(given1, given2, given3, (x, y, z) => x + y + z)
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test flatMap", () => {
    it(
      "positive",
      () => {
        let given = Ok(12)
        let nominal = Ok(24)
        let result = ResultExn.flatMap(given, x => Ok(x * 2))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given = Error(TestExn)
        let nominal = Error(TestExn)
        let result = ResultExn.flatMap(given, x => Ok(x * 2))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test flatMap2", () => {
    it(
      "positive",
      () => {
        let given1 = Ok(12)
        let given2 = Ok(7)
        let nominal = Ok(19)
        let result = ResultExn.flatMap2(given1, given2, (x, y) => Ok(x + y))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 1",
      () => {
        let given1 = Error(TestExn)
        let given2 = Ok(7)
        let nominal = Error(TestExn)
        let result = ResultExn.flatMap2(given1, given2, (x, y) => Ok(x + y))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 2",
      () => {
        let given2 = Error(TestExn)
        let given1 = Ok(7)
        let nominal = Error(TestExn)
        let result = ResultExn.flatMap2(given1, given2, (x, y) => Ok(x + y))
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 3",
      () => {
        let given2 = Error(TestExn)
        let given1 = Error(TestExn)
        let nominal = Error(TestExn)
        let result = ResultExn.flatMap2(given1, given2, (x, y) => Ok(x + y))
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test liftArr", () => {
    it(
      "positive",
      () => {
        let given = [Ok(12), Ok(123)]
        let result = given->ResultExn.lift
        let nominal = Ok([12, 123])
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given = [Ok(12), Error(TestExn)]
        let result = given->ResultExn.lift
        let nominal = Error(TestExn)
        Assert.deep_equal(result, nominal)
      },
    )
  })

  describe("test fromSome", () => {
    it(
      "positive",
      () => {
        let given = Some(102)
        let nominal = Ok(102)
        Assert.deep_equal(given->ResultExn.fromSome, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given = None
        let nominal = Error(ResultExn.TryToGettingResultFromNone)
        Assert.deep_equal(given->ResultExn.fromSome, nominal)
      },
    )
  })

  describe("test fromNone", () => {
    it(
      "positive",
      () => {
        let given = Some(102)
        let nominal = Error(ResultExn.UnexpectedSomeValue("102"))
        Assert.deep_equal(given->ResultExn.fromNone, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given = None
        let nominal = Ok()
        Assert.deep_equal(given->ResultExn.fromNone, nominal)
      },
    )
  })

  describe("test okToOption", () => {
    it(
      "positive",
      () => {
        let given = Ok(102)
        let nominal = Some(102)
        Assert.deep_equal(given->ResultExn.okToOption, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given = Error(TestExn)
        let nominal = None
        Assert.deep_equal(given->ResultExn.okToOption, nominal)
      },
    )
  })

  describe("test errToOption", () => {
    it(
      "positive",
      () => {
        let given = Ok(102)
        let nominal = None
        Assert.deep_equal(given->ResultExn.errToOption, nominal)
      },
    )
    it(
      "negative",
      () => {
        let given = Error(TestExn)
        let nominal = Some(TestExn)
        Assert.deep_equal(given->ResultExn.errToOption, nominal)
      },
    )
  })

  describe("test catchExn", () => {
    it(
      "positive",
      () => {
        let f = () => 12
        let result = ResultExn.tryExec(f)
        let nominal = Ok(12)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative",
      () => {
        let f = () => {
          Js.Exn.raiseError("error")
        }
        let result = ResultExn.tryExec(f)
        Assert.ok(result->ResultExn.isError)
      },
    )
  })

  describe("test catchResult", () => {
    it(
      "positive",
      () => {
        let f = () => Ok(12)
        let result = ResultExn.tryExecFlat(f)
        let nominal = Ok(12)
        Assert.deep_equal(result, nominal)
      },
    )
    it(
      "negative 1",
      () => {
        let f = () => {
          Js.Exn.raiseError("error")
        }
        let result = ResultExn.tryExecFlat(f)
        Assert.ok(result->ResultExn.isError)
      },
    )
    it(
      "negative 1",
      () => {
        let f = () => Error(TestExn)
        let result = ResultExn.tryExecFlat(f)
        Assert.deep_equal(result->ResultExn.getErr, TestExn)
      },
    )
  })
})
