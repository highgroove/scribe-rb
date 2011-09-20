require "spec_helper"

describe FacebookService::QueuedLogMessageHandler do
  subject do
    described_class.new("Test Handler")
  end

  describe "#queue" do
    it "provides access to messages received" do
      subject.Log(["foo", "bar", "baz"])

      subject.queue.pop.should eq("foo")
      subject.queue.pop.should eq("bar")
      subject.queue.pop.should eq("baz")
    end
  end

  describe "#log" do
    it "returns ResultCode::OK" do
      subject.Log(["foo"]).should eq(ResultCode::OK)
    end
  end
end
