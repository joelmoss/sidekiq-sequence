# frozen_string_literal: true

class Sidekiq::Sequence::Record < ApplicationRecord
  def self.table_name_prefix
    'sidekiq_sequence_'
  end
end
