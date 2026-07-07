# question 1
# Add a find state to the state machine that transitions from lost to found. Add this code in both the concrete and abstract versions of your state machine. Which is easier, and why?

# CONCRETE
defmodule VideoStore.Concrete do
  import StateMachine.Behavior

  def rent(video), do: fire(state_machine, video, :rent)
  def return(video), do: fire(state_machine, video, :return)
  def lose(video), do: fire(state_machine, video, :lose)

  def find(video), do: fire(state_machine, video, :find)

  def state_machine do
    [
      available: [
        rent: [to: :rented, calls: [&VideoStore.Concrete.renting/1]]
      ],
      rented: [
        return: [to: :available, calls: [&VideoStore.Concrete.returning/1]],
        lose: [to: :lost, calls: [&VideoStore.Concrete.losing/1]]
      ],
      lost: [
        find: [to: :found, calls: [&VideoStore.Concrete.finding/1]]
      ],
      found: []
    ]
  end

  def renting(video), do: video
  def returning(video), do: video
  def losing(video), do: video
  def finding(video), do: video
end

# ABSTRACT
defmodule VidStore do
  use StateMachine

  state :available, rent: [to: :rented, calls: [&VidStore.renting/1]]

  state :rented,
    return: [to: :available, calls: [&VidStore.returning/1]],
    lose: [to: :lost, calls: [&VidStore.losing/1]]

  state :lost, find: [to: :found, calls: [&VidStore.finding/1]]
  state :found, []

  def renting(video), do: video
  def returning(video), do: video
  def losing(video), do: video
  def finding(video), do: video
end
