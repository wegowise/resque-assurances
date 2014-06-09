require 'spec_helper'

describe Resque::Assurances::JobKey do
  it 'generates a unique key from different payloads' do
    key1 = described_class.new(TestWorker, [42])
    key2 = described_class.new(TestWorker, [43])
    expect(key1.to_s).to_not eq key2.to_s
  end

  it 'generates a unique key from different worker classes' do
    key1 = described_class.new(TestWorker, [42])
    key2 = described_class.new(UniqueWorker, [42])
    expect(key1.to_s).to_not eq key2.to_s
  end

  it 'generates the same key when worker and payloads are the same' do
    key1 = described_class.new(TestWorker, [42])
    key2 = described_class.new(TestWorker, [42])
    expect(key1.to_s).to eq key2.to_s
  end
end
