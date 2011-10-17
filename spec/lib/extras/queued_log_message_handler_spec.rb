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

  context "with message limit" do
    it "accepts messages and returns ResultCode::OK if the size limit is not exceeded" do
      subject.message_limit = 1

      subject.Log(["foo"]).should eq(ResultCode::OK)
      subject.queue.size.should eq(1)
    end

    it "does not accept messages and returns ResultCode::TRY_LATER if the size limit is exceeded" do
      subject.message_limit = 0

      subject.Log(["foo"]).should eq(ResultCode::TRY_LATER)
      subject.queue.size.should be_zero
    end

    it "does not accept messages and returns ResultCode::TRY_LATER if the size limit would be reached by adding the messages" do
      subject.message_limit = 1

      subject.Log(["foo"]).should eq(ResultCode::OK)
      subject.Log(["bar"]).should eq(ResultCode::TRY_LATER)
      subject.queue.size.should eq(1)
    end
  end

  context "with a custom queue" do
    let(:queue) { Queue.new }
    subject     { described_class.new("Test Handler", :queue => queue) }

    it "accepts a custom queue object" do
      subject.queue.should equal(queue)
    end
  end
end
