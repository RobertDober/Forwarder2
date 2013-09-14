#
# These specs assure that the README examples work as intented.
#

require 'spec_helper'

describe Forwarder do
  describe "AOP" do 
    context "before_with_block" do 
      let :lazy do
        OpenStruct.new data: (1..999).lazy
      end

      context :forward do
        before do
          class << lazy
            extend Forwarder
            forward :drop_until, to: :data, as: :drop_while, before_with_block: ->(&b){b.negated}
          end
        end

        it "drops correctly" do
          expect(
            lazy.drop_until(&sendmsg(:>, 10)).peek
          ).to eq(11)
        end
      end # context :forward

      context :forward_all do
        before do
          class << lazy
            extend Forwarder
            forward_all :drop_until, :xxx, to: :data, as: :drop_while, before_with_block: ->(&b){b.negated}
          end
        end

        it "drops correctly" do
          expect(
            lazy.drop_until(&sendmsg(:>, 10)).peek
          ).to eq(11)
        end
        it "for all forwarded methods" do
          expect(
            lazy.xxx(&sendmsg(:>, 10)).peek
          ).to eq(11)
          
        end
      end # context :forward
    end # context "before_with_block"
  end # describe "AOP"
end
