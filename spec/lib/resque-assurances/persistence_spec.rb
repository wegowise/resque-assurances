require 'spec_helper'

describe Resque::Assurances::Persistence do
  before(:each) do
    PersistedWorker.destroy_queue!
  end

  it 'performs ordered jobs normally' do
    Resque.enqueue(PersistedWorker, 42)
    Resque.enqueue(PersistedWorker, 43)
    expect(PersistedWorker).to receive(:perform).with(42).ordered
    expect(PersistedWorker).to receive(:perform).with(43).ordered
    ResqueSpec.perform_all(PersistedWorker.queue)
  end

  it 'persists the job payloads if the resque queue is destroyed' do
    Resque.enqueue(PersistedWorker, 42)
    expect(PersistedWorker).to receive(:do_some_work).with(42)
    Resque.enqueue(PersistedWorker)
    ResqueSpec.perform_all(PersistedWorker.queue)
  end
end
