require 'spec_helper'
require 'forwarder/arguments'

describe Forwarder::Arguments do
  describe ArgumentError do
    describe "wrong arg count" do
      it 'is raised for too few args' do
        ->{ described_class.new :hello }.should raise_error( ArgumentError )
      end
      it 'is raised for too many args' do
        ->{ described_class.new :hello, {to: :friend}, 42 }.should raise_error( ArgumentError )
      end
    end # describe "wrong arg count" do
    describe "wrong arg semantics" do
      it 'is raised for no target' do
        ->{ described_class.new :hello, as: :hello }.should raise_error( ArgumentError, /no target specified/ )
      end
      it 'is raised for too many targets' do
        ->{ described_class.new :hello, to: :hello, to_chain: [] }.should raise_error( ArgumentError, /more than one target specified/ )
      end
      it 'raises for translations in many messages' do
        ->{ described_class.new [:a, :b], to: :hello, as: :omega }.should raise_error( ArgumentError, /cannot provide translations/ )
      end
      it 'raises for arguments in many messages' do
        ->{ described_class.new [:a, :b], to: :hello, with: 42 }.should raise_error( ArgumentError, /cannot provide arguments/ )
      end
      it 'raises for arguments and a to_hash: target' do
        ->{ described_class.new :a, to_hash: :b, with: :c }.should raise_error( ArgumentError, /cannot provide arguments/ )
      end
    end # describe "wrong arg semantics"
  end # describe ArgumentError
end # describe Forwarder::Arguments do
