# frozen_string_literal: true

require 'spec_helper'

describe RubyTerraform::Commands::WorkspaceSelect do
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
    options: { operation: 'select', workspace: 'staging' },
    reason: 'should select the specified workspace',
    expected: 'terraform workspace select staging'
  )

  it_behaves_like(
    'a command with an argument',
    described_class, 'workspace select', :workspace
  )

  it_behaves_like(
    'a command with an argument',
    described_class, 'workspace select', :directory
  )

  it_behaves_like(
    'a command without a binary supplied',
    described_class, 'workspace select', directory
  )

  it_behaves_like(
    'a command with global options',
    described_class, 'workspace select', directory
  )
end
