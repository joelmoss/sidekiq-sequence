# frozen_string_literal: true

require 'rails/generators/active_record'

module SidekiqSequence
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      source_root File.join(__dir__, 'templates')

      desc 'Install Sidekiq::Sequence, including a database migration.'

      def copy_migration
        migration_template 'migration.rb', 'db/migrate/create_sidekiq_sequence_record.rb',
                           migration_version: migration_version
      end

      def migration_version
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end

      def properties_type
        case ActiveRecord::Base.connection_db_config[:adapter].to_s
        when /postg/i # postgres, postgis
          'jsonb'
        when /mysql/i
          'json'
        else
          'text'
        end
      end
    end
  end
end
