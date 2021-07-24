lib LibC
  # Bits in the third argument to `waitpid'.
  @[Flags]
  enum WaitPidFlags
    NONE = 0

    # Don't block waiting.
    WNOHANG   = 1

    # Report status of stopped children.
    WUNTRACED = 2

    {% if flag?(:use_xopen_extended) %}
      # Report stopped child (same as WUNTRACED).
      WSTOPPED = 2

      # Report dead child.
      WEXITED = 4

      # Report continued child.
      WCONTINUED = 8

      # Don't reap, just poll status.
      WNOWAIT = 0x01000000
    {% end %}

    # Don't wait on children of other threads #in this group
    WNOTHREAD = 0x20000000

    # Wait for any child.
    WALL   = 0x40000000

    # Wait for cloned process.
    WCLONE = -2147483648 # 0x80000000_u32.to_i32!
  end
end
