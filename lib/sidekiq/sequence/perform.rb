# frozen_string_literal: true

module Sidekiq
  module Sequence
    module Perform
      def perform(id, *args)
        @record = Record.find(id)
        @data = @record.data

        super(*args)

        @record.increment(:current_step).save!

        # Perform the next in sequence.
        self.class.parent.perform_step @record.current_step, @record.id
      end
    end
  end
end
