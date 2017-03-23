require 'docking_station'

describe DockingStation do
  let(:bike) {double(:bike) }

  it 'responds to release_bike' do
    expect(subject).to respond_to :release_bike
  end

  it 'releases working bikes' do
    allow(bike).to receive(:working?).and_return(true)
    expect(bike).to be_working
  end

  it 'responds to dock' do
    expect(subject).to respond_to(:dock).with(1).argument
  end



  it 'docks something' do
    expect(subject.dock(bike)).to include bike
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end



  describe '#release_bike' do
    let(:bike) { double(:bike)}
    it 'releases a bike' do
      allow(bike).to receive(:working?).and_return(true)
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'raises an error when there are no bikes available' do
      expect {subject.release_bike}.to raise_error 'No bikes available'
    end

    it 'will not release a broken bike' do
      allow(bike).to receive(:report_broken)
      allow(bike).to receive(:working?).and_return(false)
      bike.report_broken
      subject.dock(bike)
      expect {subject.release_bike}.to raise_error 'No bikes available'
    end
  end

  describe '#dock' do
    it 'raises an error when full' do
      subject.capacity.times { subject.dock double(:bike) }
      expect {subject.dock double(:bike)}.to raise_error 'Docking station full'
    end
  end

  describe 'initialization' do
    subject { DockingStation.new}
    let(:bike) { double(:bike) }
    it 'defaults capacity' do
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect{ subject.dock(bike) }.to raise_error 'Docking station full'
    end
    it 'has a variable capacity' do
      docking_station = DockingStation.new(50)
      50.times { docking_station.dock bike }
      expect{ docking_station.dock bike }.to raise_error 'Docking station full'
    end
  end

end
