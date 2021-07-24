require "./src/fork"

puts "Before fork"

pid = Fork.fork

if pid == 0
  puts "Inside child"
  
  print "Sleeping in child..."
  4.downto(1) do |i|
    sleep 1
    print " #{i}..."
  end
  puts

  puts "Exiting child"
  exit 1
else
  puts "Inside parent"

  puts "Waiting for child to exit..."
  status = Fork.waitpid(pid)

  puts "Child exited with #{status.exit_status}"
end
