require "spec_helper"

describe FacebookService::BaseHandler do
  subject do
    described_class.new("Test Handler")
  end

  describe "#getName" do
    it "returns the name given in the constructor" do
      subject.getName.should eq("Test Handler")
    end
  end

  describe "#getVersion" do
    it "returns an empty string" do
      subject.getVersion.should be_empty
    end
  end

  describe "#getStatus" do
    it "always returns alive" do
      subject.getStatus.should eq(Fb_status::ALIVE)
    end
  end

  describe "#getStatusDetails" do
    it "returns an empty string" do
      subject.getStatusDetails.should be_empty
    end
  end

  # TODO: Expose an interface for manipulating counters

  describe "#setOption" do
    it "stores the option" do
      subject.setOption("foo", "bar")

      subject.getOption("foo").should eq("bar")
    end
  end

  describe "#getOptions" do
    it "returns all options as a Hash" do
      subject.setOption("foo", "bar")
      subject.setOption("foo2", "bar2")


      subject.getOptions.should eq({"foo" => "bar", "foo2" => "bar2"})
    end
  end

  describe "#getCpuProfile" do
    it "returns an empty string" do
      subject.getCpuProfile.should be_empty
    end
  end

  describe "#aliveSince" do
    before { Timecop.freeze(Time.now) }
    after  { Timecop.return }

    it "returns the time the service was created" do
      subject.aliveSince.should eq(Time.now.to_i)
    end
  end

  describe "#reinitialize" do
    it "provides a noop method" do
      subject.should respond_to(:reinitialize)
    end
  end

  describe "#shutdown" do
    it "provides a noop method" do
      subject.should respond_to(:shutdown)
    end
  end
end
