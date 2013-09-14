module Kernel
  def sendmsg *args, &blk
    args.empty? ?
      ->(rcv){ rcv } :
      ->(rcv){ rcv.send(*args, &blk) }
  end
end # module Kernel
