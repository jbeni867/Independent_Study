# QUESTION 1
# How can you crash your server? What happens if you crash it with and without a supervisor?
# Method 1: Division by zero
1 / 0
# Method 2: Explicitly raising an error
raise "Oops, the server crashed!"
# Method 3: Bad pattern match
{:ok, value} = {:error, "failed"}
# Method 4: Forcefully killing the process using its PID
Process.exit(server_pid, :kill)

# QUESTION 2
# Add a timeout to the pitcher or catcher. What happens when you time out?
ball_glove_with_timeout = fn ->
  receive do
    {:pitch, pitcher} ->
      IO.puts("Caught the ball!")
      send pitcher, {:catch, self()}
  after
    5000 ->
      IO.puts("Catcher waited too long and left the field!")
  end
end
