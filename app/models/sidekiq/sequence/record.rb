# frozen_string_literal: true

class Sidekiq::Sequence::Record < ApplicationRecord
  def self.table_name_prefix
    'sidekiq_sequence_'
  end

  serialize :data, JSON unless connection.adapter_name =~ /postg|mysql/i
end
