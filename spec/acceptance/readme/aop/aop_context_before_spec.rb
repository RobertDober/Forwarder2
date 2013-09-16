require 'spec_helper'

reset_count = 
  ->(*args){ self.count = ary.size; args }

describe Forwarder do
  context "AOP blox execute in correct context" do
    let :counter do
      OpenStruct.new( count: 0, ary: %w{a b c}).tap do |os|
        os.singl do
          extend Forwarder
        end
      end
    end

    context :forward do
      before do
        counter.singl do
          forward :<<, to: :ary, before: reset_count
        end
      end

      it "updates counter" do
        counter << Object
        expect(
          counter.count
        ).to eq( 3 )
      end

      it "returns the correct result" do
        expect( counter << "count" ).to eq(%w{a b c count})
      end
    end # context :forward

    context :forward_all do 
      before do
        counter.singl do
          forward_all :<<, :clear, to: :ary, before: reset_count
        end
      end

      it "updates counter" do
        counter << Object
        expect(
          counter.count
        ).to eq( 3 )
      end

      it "returns the correct result" do
        expect( counter << "count" ).to eq(%w{a b c count})
      end

      it "clears the counter" do
        counter.clear
        expect( counter.count ).to eq( 3 )
      end
    end # context :forward
  end # context "AOP blox execute in correct context"
end # describe Forwarder
