# frozen_string_literal: true

require 'sql_statement_parsing'

# Utility able to parse a server log and turning it into a collection of Hash / YAML output
class LogParser
  attr_reader :log_path

  def initialize(log_path)
    @log_path = log_path
  end

  def hashes
    sql_statements.map { |statement| SqlStatementParsing::Object.new(statement).hash }
  end

  def yaml
    sql_statements.map { |statement| SqlStatementParsing::Object.new(statement).yaml }
  end

  private

  def sql_statements
    @sql_statements ||= File.readlines(log_path).select do |line|
      line.match(/INSERT INTO/) || line.match(/UPDATE/)
    end
  end
end

output = ARGV.length > 1 ? ARGV.last : :yaml

puts LogParser.new("./logs/#{ARGV.first}").send(output)
