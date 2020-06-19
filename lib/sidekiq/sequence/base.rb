# frozen_string_literal: true

module Sidekiq
  module Sequence
    class Base
      class << self
        attr_reader :steps

        def step(worker_class)
          @steps = [] if steps.nil?
          @steps << worker_class.name
        end
      end

      def self.perform_step(index, id)
        if index >= steps.size
          # No more steps in the sequence, so delete the record.
          Record.destroy id
        else
          steps[index].constantize.perform_async id
        end
      end

      def initialize(data = {})
        record = Record.create(data: data)

        # Start first job in the sequence.
        steps.first.constantize.perform_async record.id
      end
    end
  end
end
