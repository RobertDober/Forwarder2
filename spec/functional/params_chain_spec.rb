require 'spec_helper'
require 'forwarder/params'

describe Forwarder::Params do
  describe "when it can use Forwardable" do
    let :forwardee do double "forwardee" end 
    let :target do [:@ivar, :method] end
    let :message do :a_message end
    let :translation do :another_message end

    subject do
      described_class.new( forwardee )
    end

    it "forwards to a chain" do
      forwardee
        .should_receive( :module_eval )
        .with( "def #{message} *args, &blk; #{target.join(".")}.#{translation}( *args, &blk ) end", anything, anything )
      subject.prepare_forward( message, to_chain: target, as: translation )
      subject.forward!
    end

  end

end # describe Forwarder::Params
