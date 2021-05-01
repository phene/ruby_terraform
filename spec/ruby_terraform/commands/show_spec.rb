# frozen_string_literal: true

require 'spec_helper'

describe RubyTerraform::Commands::Show do
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
    reason: 'prefers the path if both path and directory provided',
    expected: 'terraform show some/path/to/terraform/plan',
    options: {
      directory: Faker::File.dir,
      path: 'some/path/to/terraform/plan'
    }
  )

  it_behaves_like(
    'a command with an argument',
    described_class, 'show', :directory
  )
  it_behaves_like(
    'a command with an argument',
    described_class, 'show', :path
  )
  it_behaves_like(
    'a command without a binary supplied',
    described_class, 'show', directory
  )
  it_behaves_like(
    'a command with a flag',
    described_class, 'show', :no_color, directory
  )
  it_behaves_like(
    'a command with a flag',
    described_class, 'show', :json, directory
  )
  it_behaves_like(
    'a command with global options',
    described_class, 'show', directory
  )
end
