# frozen_string_literal: true

require 'spec_helper'

describe RubyTerraform::Commands::WorkspaceDelete do
  before do
    RubyTerraform.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyTerraform.reset!
  end

  directory = Faker::File.dir

  it_behaves_like(
    'a valid command line',
    described_class,
    binary: 'terraform',
    options: { operation: 'delete', workspace: 'staging' },
    reason: 'should delete the specified workspace',
    expected: 'terraform workspace delete staging'
  )

  it_behaves_like(
    'a command with an argument',
    described_class, 'workspace delete', :workspace
  )

  it_behaves_like(
    'a command with an argument',
    described_class, 'workspace delete', :directory
  )

  it_behaves_like(
    'a command without a binary supplied',
    described_class, 'workspace delete', directory
  )

  it_behaves_like(
    'a command with a flag',
    described_class, 'workspace delete', :force, directory
  )

  it_behaves_like(
    'a command with a boolean option',
    described_class, 'workspace delete', :lock, directory
  )

  it_behaves_like(
    'a command with an option',
    described_class, 'workspace delete', :lock_timeout, directory
  )

  it_behaves_like(
    'a command with global options',
    described_class, 'workspace delete', directory
  )
end
