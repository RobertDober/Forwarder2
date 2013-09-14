#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do
  describe "AOP all" do 
    
    let :counter do
      OpenStruct.new( count: 0, ary: [])
    end
    before do
      class << counter
        extend Forwarder
        reset_count = ->(result){ self.count = ary.size; result }
        forward_all :<<, :clear, to: :ary, after: reset_count
      end
    end

    it "updates counter" do
      counter << Object
      expect(
        counter.count
      ).to eq( 1 )
    end

    it "returns the correct result" do
      expect( counter << "count" ).to eq(%w{count})
    end
  end # describe "AOP all"
end
