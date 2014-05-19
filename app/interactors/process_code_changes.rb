class ProcessCodeChanges
  include Interactor::Organizer

  organize PrepareRepository, GenerateReport, CleanUpRepository
end
