variable thefilename {
  type = string
  default = "sample1.txt"
}
/*
variable thecontent {
  type = number
  default = 33
}
*/
/*
variable thecontent {
  type = bool
  default = true
}
*/
/*
variable thecontent {
  type = list(string)
  default = ["red", "green", "blue"]
}
*/
/*
variable thecontent {
  type = tuple([string,bool,number])
  default = ["red", false, 33]
}
*/
variable thecontent {
  type = map
  default = {
    name = "Yoga",
    age = 33
  }
}