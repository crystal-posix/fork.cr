# fork.cr

* [Source](https://github.com/postmodern/fork.cr)
* [Issues](https://github.com/postmodern/fork.cr/issues)
* [Docs](https://postmodern.github.io/docs/fork.cr/index.html)

libc's [fork] for [Crystal][crystal].

## Features

* Provides a `Fork.fork` function.
* Provides a `Fork.wait` function.
* Provides a `Fork.waitpid` function.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     fork:
       github: postmodern/fork.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "fork"

if (pid = Fork.fork) == 0
  # running in child process

  # exit with status -1
  exit -1
else
  # running in parent process

  status = Fork.waitpid(pid) # wait for the child process to exit
  puts "Child process exiting with status: #{status}"
end
```

Using fork with a block:

```crystal
status = Fork.fork do
  # running in child process

  # exit with status -1
  exit -1
end

puts "Child process exiting with status: #{status}"
```

## Contributing

1. Fork it (<https://github.com/postmodern/fork/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Postmodern](https://github.com/postmodern) - creator and maintainer

[fork]: https://man7.org/linux/man-pages/man2/fork.2.html
[crystal]: https://crystal-lang.org/
