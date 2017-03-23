require 'bike'

describe Bike do
  it 'responds to working?' do
    expect(subject).to respond_to :working?
  end

  it 'can be reported broken' do
    subject.report_broken
    expect(subject).not_to be_working
  end
end
