require "test_helper"
require_relative "../../lib/sequence_diagram/sequencer"

module SequenceDiagram
  class SequencerTest < Minitest::Test
    def setup
      @sequencer = Sequencer.new
      @chain = Chain.new(Wheel.new)
      @bike = Bike.new(Pedals.new(@chain))
    end

    def test_output
      expected = [
        "sequenceDiagram",
        "caller->>Bike: ride",
        "Bike->>Pedals: push",
        "Pedals->>Chain: pull",
        "Chain->>Wheel: spin",
        "Wheel-->>Chain: spin",
        "Chain-->>Pedals: pull",
        "Pedals-->>Bike: push",
        "Bike-->>caller: ride"
      ]

      @sequencer.enable { @bike.ride }
      actual = @sequencer.call
      assert_equal(expected, actual)
    end

    def test_class_sequence
      expected = [
        "sequenceDiagram",
        "caller->>Bike: ride",
        "Bike->>Pedals: push",
        "Pedals->>Chain: pull",
        "Chain->>Wheel: spin",
        "Wheel-->>Chain: spin",
        "Chain-->>Pedals: pull",
        "Pedals-->>Bike: push",
        "Bike-->>caller: ride"
      ]
      actual = Sequencer.call { @bike.ride }
      assert_equal(expected, actual)
    end

    def test_chain_pull
      expected = [
        "sequenceDiagram",
        "caller->>Chain: pull",
        "Chain->>Wheel: spin",
        "Wheel-->>Chain: spin",
        "Chain-->>caller: pull"
      ]
      actual = Sequencer.call { @chain.pull }
      assert_equal(expected, actual)
    end
  end
end

class Bike
  def initialize(pedals)
    @pedals = pedals
  end

  def ride
    @pedals.push
  end
end

class Pedals
  def initialize(chain)
    @chain = chain
  end

  def push
    @chain.pull
  end
end

class Chain
  def initialize(wheel)
    @wheel = wheel
  end

  def pull
    @wheel.spin
  end
end

class Wheel
  def spin; end
end
