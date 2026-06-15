locals {
  math        = 2 * 2         # Math -> +, - , /, *, %, -number
  equality    = 2 == 3        # returns a boolean, -> != , ==
  comparision = 2 > 1         # reetunrs a boolean. -> <= , < , > , >=
  logical     = true || false # || and && (and and or)

}

output "operators" {

  value = {
    math = local.math
    equa = local.equality
    comp = local.comparision
    logi = local.logical
  }

}