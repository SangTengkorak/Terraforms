resource "random_integer" "rint" {
  min = 55
  max = 875
}

resource "random_string" "rstr" {
  length = 32
}

output "name1" {
  value = random_integer.rint.result
}

output "name2" {
  value = random_string.rstr.result
}