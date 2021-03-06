require 'spec_helper'

describe Resque::Assurances::Uniqueness do
  it 'enqueues workers once' do
    2.times { Resque.enqueue(UniqueWorker, 42) }
    expect(UniqueWorker).to have_queue_size_of(1)
    expect(UniqueWorker).to have_queued(42)
  end

  it 'enqueues workers without args once' do
    2.times { Resque.enqueue(UniqueWorker) }
    expect(UniqueWorker).to have_queue_size_of(1)
  end

  it 'enqueues workers with different args' do
    Resque.enqueue(UniqueWorker, 42)
    Resque.enqueue(UniqueWorker, 43)
    expect(UniqueWorker).to have_queue_size_of(2)
    expect(UniqueWorker).to have_queued(42)
    expect(UniqueWorker).to have_queued(43)
  end

  it 'enqueues different workers with the same args' do
    Resque.enqueue(UniqueWorker, 42)
    Resque.enqueue(AnotherUniqueWorker, 42)
    expect(UniqueWorker).to have_queued(42)
    expect(AnotherUniqueWorker).to have_queued(42)
  end

  it 'can be queued again after the work is performed' do
    Resque.enqueue(UniqueWorker)
    expect(UniqueWorker).to have_queue_size_of(1)
    ResqueSpec.perform_all(UniqueWorker.queue)
    expect(UniqueWorker).to have_queue_size_of(0)
    Resque.enqueue(UniqueWorker)
    expect(UniqueWorker).to have_queue_size_of(1)
  end

  it 'can be queued again if the work fails' do
    Resque.enqueue(UniqueWorker, 42)
    expect(UniqueWorker).to have_queue_size_of(1)
    expect(UniqueWorker).to receive(:do_some_work).and_raise(StandardError)
    ResqueSpec.perform_all(UniqueWorker.queue) rescue StandardError
    expect(UniqueWorker).to have_queue_size_of(0)
    Resque.enqueue(UniqueWorker)
    expect(UniqueWorker).to have_queue_size_of(1)
  end
end
