require "./bits/waitflags"

lib LibC
  fun fork : PidT
  fun wait(Int *) : PidT
  fun waitpid(PidT, Int *, Int) : PidT
end
