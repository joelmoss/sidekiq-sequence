# frozen_string_literal: true

module Sidekiq
  module Sequence
    # rubocop:disable Style/ClassVars
    class Base
      @@steps = []

      def self.step(worker_class)
        @@steps << worker_class
      end

      def self.perform_step(index, id)
        if index >= @@steps.size
          # No more steps in the sequence, so delete the record.
          Record.destroy id
        else
          @@steps[index].perform_async id
        end
      end

      def initialize(data = {})
        record = Record.create(data: data)

        # Start first job in the sequence.
        @@steps.first.perform_async record.id
      end
    end
    # rubocop:enable Style/ClassVars
  end
end
