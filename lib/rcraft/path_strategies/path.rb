require 'forwardable'

module PathStrategy
  class Path
    extend Forwardable

    attr_accessor :path

    def initialize(moves)
      @path = moves
    end

    def_delegators :@path, :empty?, :any?, :count, :==
    def_delegator  :@path, :first, :next
    def_delegator  :@path, :shift, :next!   
  end
end