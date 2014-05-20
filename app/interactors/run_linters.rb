class RunLinters
  include Interactor::Organizer

  organize RunRubocop, RunCoffeelint
end
