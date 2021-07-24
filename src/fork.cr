require "./unistd"
require "./bits/waitflags"

module Fork
  VERSION = "0.1.0"

  alias WaitPidFlags = LibC::WaitPidFlags
  alias PidT = LibC::PidT
  alias StatusT = Int32

  class Error < IO::Error
  end

  extend self

  #
  # Waits for any child to exit and retuns the exit status.
  #
  # Raises an `Error` exception if the
  # [wait(2)](https://man7.org/linux/man-pages/man2/waitpid.2.html)
  # syscall returned -1.
  #
  def wait() : Process::Status
    status = uninitialized LibC::Int

    if LibC.wait(pointerof(status)) == -1
      raise Error.new(String.new(LibC.strerror(Errno.value)))
    end

    return Process::Status.new(status.to_i32)
  end

  #
  # Waits for a specific child process to exit and rturns the exit status.
  #
  # Raises an `Error` exception if the 
  # [waitpid(2)](https://man7.org/linux/man-pages/man2/waitpid.2.html)
  # syscall returned -1.
  #
  def waitpid(pid : PidT, options = WaitPidFlags::NONE) : Process::Status
    status = uninitialized LibC::Int

    if LibC.waitpid(pid,pointerof(status),options) == -1
      raise Error.new(String.new(LibC.strerror(Errno.value)))
    end

    return Process::Status.new(status.to_i32)
  end

  #
  # Forks a new child process.
  #
  # * In the child process, `0` will be returned.
  # * In the parent process, the child process'es PID will be returned.
  #
  # ```crystal
  # if (pid = Fork.fork) == 0
  #   # in the child process
  # else
  #   # in the parent process
  # end
  # ```
  #
  def fork : PidT
    LibC.fork()
  end

  #
  # Forks a new child process.
  #
  # * In the child process, the given block will be called.
  # * In the parent process, the process will wait for the child process to exit
  #   and return the child process'es exit status.
  #
  # ```crystal
  # status = Fork.fork do
  #   # in the child process
  # end
  #
  # puts "Child process exited with #{status.exit_status}"
  # ```
  #
  def fork(&block : ->) : StatusT
    if (pid = fork()) == 0
      # running in child process
      block.call()
    else
      # running in parent process
      return waitpid(pid)
    end
  end
end
