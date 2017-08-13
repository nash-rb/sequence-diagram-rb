require "ostruct"

module SequenceDiagram
  class Sequencer
    def self.call
      sequencer = new
      sequencer.enable { yield }
      sequencer.call
    end

    def enable
      trace.enable { yield }
    end

    def call
      format_steps(steps)
    end

  private

    def trace
      @trace ||= TracePoint.new(:call, :return) do |trace_point|
        capture(trace_point)
      end
    end

    def callers
      @callers ||= ["caller"]
    end

    def steps
      @steps ||= []
    end

    def capture(trace_point)
      steps << extract_step(trace_point)
    end

    def extract_step(trace_point)
      OpenStruct.new(
        caller:   determine_caller(trace_point),
        receiver: trace_point.defined_class,
        message:  trace_point.method_id,
        event:    trace_point.event
      )
    end

    def format_steps(steps)
      ["sequenceDiagram"] + steps.map { |step| format_step(step) }
    end

    def format_step(step)
      case step.event
      when :call
        "#{step.caller}->>#{step.receiver}: #{step.message}"
      when :return
        "#{step.receiver}-->>#{step.caller}: #{step.message}"
      end
    end

    def determine_caller(trace_point)
      if trace_point.event == :call
        caller = callers.last
        callers << trace_point.defined_class
      else
        caller = callers.pop
        caller = callers.pop if caller == trace_point.defined_class
      end
      caller
    end
  end
end
